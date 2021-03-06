; -*- mode: lisp; package: xl-winhttp.internal; encoding: shift_jis -*-

;; Copyright (c) 2011-2012 MIYAMUKO Katsuyuki.
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Code:

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "xl-winhttp/internal/package")
  (require "xl-winhttp/internal/debug")
  )

(in-package :xl-winhttp.internal)

(export '(*size-of-WCHAR*
          *size-of-DWORD*
          *size-of-pointer*

          nullp

          make-WSTR
          make-WSTR-buffer
          make-WSTR-array
          unpack-WSTR
          unpack-WSTR-pointer
          WSTR-length
          bytes->WSTR-length

          make-CSTR
          make-CSTR-buffer
          unpack-CSTR
          unpack-CSTR-pointer
          CSTR-length

          make-DWORD
          unpack-DWORD
          unpack-DWORD-pointer
          make-pointer
          unpack-pointer

          chunkp
          check-chunk

          convert-internal-to-WSTR
          convert-WSTR-to-internal

          pack-BOOL
          unpack-BOOL

          get-last-error
          global-free
          ))

(defparameter *size-of-WCHAR* (c::ctypedef-size (c::expand-c-type 'c:wchar_t)))
(defparameter *size-of-DWORD* (c::ctypedef-size (c::expand-c-type 'winapi:DWORD)))
(defparameter *size-of-pointer* (c::ctypedef-size (c::expand-c-type '(c:void *))))


(defun nullp (v)
  (or (not v)
      (and (numberp v) (zerop v))))

(defun make-WSTR (str &key (default NULL))
  (when (nullp str)
    (return-from make-WSTR default))
  (check-type str string)
  ;; si:make-string-chunk は NULL 文字を 1 つだけ付けてくれるが、
  ;; wchar_t の場合は 2 つ必要なので NULL 文字を 1 つ追加しておく
  (si:make-string-chunk (format nil "~A~C"
                                (convert-internal-to-WSTR str)
                                #\NUL)))

(defun make-WSTR-buffer (wstr-len)
  (make-buffer 'wstr (* wstr-len *size-of-WCHAR*)))

;; (make-WSTR-buffer '("foo" "bar" "baz")
;;
;;               chunk             chunk-data
;;              ┌─┬─┐        ┌─┬─┬─┬─┐
;; array  ──→│  │  ┼───→│  │  │  │\0│
;;              └─┴─┘        └┼┴┼┴┼┴─┘
;;                                  │  │  └─────┐
;;                                ┌┘  └─────┐  │
;;                                │                │  │
;;              ┌─┬─┐        ↓─┬─┬─┬─┐│  │
;; chunks ─┬→│  │  ┼───→│f │o │o │\0││  │
;;          │  └─┴─┘        └─┴─┴─┴─┘│  │
;;          │                                      │  │
;;          │                    ┌────────┘  │
;;          │  ┌─┬─┐        ↓─┬─┬─┬─┐    │
;;          ├→│  │  ┼───→│b │a │r │\0│    │
;;          │  └─┴─┘        └─┴─┴─┴─┘    │
;;          │                                          │
;;          │                    ┌──────────┘
;;          │  ┌─┬─┐        ↓─┬─┬─┬─┐
;;          └→│  │  ┼───→│b │a │z │\0│
;;              └─┴─┘        └─┴─┴─┴─┘
(defun make-WSTR-array (strs &key (default NULL))
  (when (nullp strs)
    (return-from make-WSTR-array (values default nil)))
  (dolist (str strs)
    (check-type str string))
  (let* ((chunks (mapcar #'make-WSTR strs))
         (array (si:make-chunk nil (* (1+ (length strs))
                                      *size-of-pointer*))))
    (si:clear-chunk array)
    (let ((offset 0))
      (dolist (chunk chunks)
        ;; ポインタのサイズは 32bit を仮定
        (si:pack-uint32 array offset (si:chunk-data chunk))
        (incf offset *size-of-pointer*)))
    (values array chunks)))

(defun WSTR-length (chunk)
  (when (nullp chunk)
    (return-from WSTR-length 0))
  (check-chunk chunk)
  (bytes->WSTR-length (CSTR-length chunk)))

(defun unpack-WSTR (chunk &optional wstr-len)
  (when (nullp chunk)
    (return-from unpack-WSTR nil))
  (check-chunk chunk)
  (unpack-WSTR-pointer (si:chunk-data chunk) wstr-len))

(defun unpack-WSTR-pointer (pointer &optional wstr-len &key free)
  (unless (nullp pointer)
    (unless wstr-len
      (setf wstr-len (wcslen pointer)))
    (when (< 0 wstr-len)
      (convert-WSTR-to-internal
       (unpack-CSTR-pointer pointer (* wstr-len *size-of-WCHAR*) :free free)))))

(defun bytes->WSTR-length (bytes)
  (identity (floor (/ bytes *size-of-WCHAR*))))


(defun make-CSTR (str &key (default NULL))
  (when (nullp str)
    (return-from make-CSTR default))
  (check-type str string)
  (si:make-string-chunk str))

(defun make-CSTR-buffer (size)
  (make-buffer 'cstr size))

(defun CSTR-length (chunk)
  (when (nullp chunk)
    (return-from CSTR-length 0))
  (check-chunk chunk)
  (let ((size (si:chunk-size chunk)))
    (if (null-terminated-chunk-p chunk)
        (1- size)
      size)))

(defun unpack-CSTR (chunk &optional bytes)
  (when (nullp chunk)
    (return-from unpack-CSTR nil))
  (check-chunk chunk)
  (let ((size (or bytes (CSTR-length chunk))))
    (si:unpack-string chunk 0 size nil)))

(defun unpack-CSTR-pointer (pointer bytes &key free)
  (when (or (nullp pointer)
            (nullp bytes))
    (return-from unpack-CSTR-pointer nil))
  (let ((chunk (si:make-chunk nil bytes nil pointer)))
    (prog1
        (si:unpack-string chunk 0 bytes nil)
      (when free
        (global-free pointer)))))

(defun make-buffer (type size)
  (check-type size integer)
  (let ((r (si:make-chunk type size)))
    (si:clear-chunk r)
    r))

(defun null-terminated-chunk-p (chunk)
  ;; - make-CSTR-buffer で作った chunk
  ;;   - type:      'cstr
  ;;   - chunk:     nil
  ;;   - NULL 終端: no
  ;; - make-CSTR, make-WSTR (si:make-string-chunk) で作った chunk
  ;;   - type:      nil
  ;;   - chunk:     自分自身
  ;;   - NULL 終端: yes
  (not (eq (si:chunk-type chunk) 'cstr)))


(defun make-DWORD (&optional initial-value)
  (let ((r (si:make-chunk 'DWORD *size-of-DWORD*)))
    (si:pack-uint32 r 0 (or initial-value 0))
    r))

(defun unpack-DWORD (chunk)
  (check-chunk chunk)
  (si:unpack-uint32 chunk 0))

(defun unpack-DWORD-pointer (pointer bytes &key free)
  (unless (nullp pointer)
    (let ((chunk (si:make-chunk nil bytes nil pointer)))
      (prog1
          (si:unpack-uint32 chunk 0)
        (when free
          (global-free pointer))))))

(setf (symbol-function 'make-pointer)
      (symbol-function 'make-DWORD)
      (symbol-function 'unpack-pointer)
      (symbol-function 'unpack-DWORD)
      )

(defun chunkp (chunk)
  (eq (type-of chunk) 'si:chunk))

(defun check-chunk (chunk)
  (unless (chunkp chunk)
    (error 'type-error
           :datum chunk
           :expected-type 'si:chunk)))

(defun convert-WSTR-to-internal (str)
  (when str
    (ed::convert-encoding-to-internal ed::*encoding-utf16le* str)))

(defun convert-internal-to-WSTR (str)
  (when str
    (ed::convert-encoding-from-internal ed::*encoding-utf16le* str)))


(defun pack-BOOL (bool)
  (if (not (nullp bool)) TRUE FALSE))

(defun unpack-BOOL (bool)
  (not (nullp bool)))


(defun get-last-error (&optional error-code)
  (let* ((error-code (or error-code (GetLastError)))
         (error-name (find-error-name error-code))
         (error-keyword (make-error-keyword error-name)))
    (values error-code error-name error-keyword)))

(defun find-error-name (error-code)
  (unless (zerop error-code)
    (do-external-symbols (sym :winhttp.ffi)
      (when (and (boundp sym)
                 (equal error-code (symbol-value sym))
                 (string-match "\\`ERROR_" (string sym)))
        (return sym)))))

(defun make-error-keyword (error-name)
  (when error-name
    (let ((r (string error-name)))
      (setf r (substitute-string r "\\`ERROR\\(?:_WINHTTP\\)?_" ""))
      (setf r (substitute #\- #\_ r))
      (setf r (string-downcase r))
      (intern r :keyword))))


(defun global-free (p)
  (unless (nullp p)
    (trace "GlobalFree: ~:@(~8,'0X~)" p)
    (GlobalFree p)))


(provide "xl-winhttp/internal/interop")

;;; End
