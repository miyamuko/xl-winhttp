; -*- mode: lisp; package: xl-winhttp.ffi; encoding: shift_jis -*-

;;; xl-winhttp/ffi/winapi.l
;;
;; Copyright (c) 2011 MIYAMUKO Katsuyuki.
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
  (require "xl-winhttp/package")
  )

(in-package :winhttp.ffi)

(export '(make-WSTR
          unpack-WSTR
          WSTR-length
          zero-memory
          make-DWORD
          unpack-DWORD

          assert-BOOL
          ))

(defparameter *size-of-wstr* 2)

(defun nullp (v)
  (or (not v)
      (zerop v)))

(defun make-WSTR (str)
  (check-type str string)
  (si:make-string-chunk (internal-to-utf16 str)))

(defun unpack-WSTR (chunk &optional offset wstr-len)
  (if (and (nullp chunk) (nullp offset))
      nil
    (progn
      (unless (nullp chunk)
        (check-chunk chunk))
      (let* ((size (* (or wstr-len (WSTR-length chunk))
                      *size-of-wstr*))
             (chunk (or chunk
                        (si:make-chunk nil size nil offset))))
        (utf16-to-internal (si:unpack-string chunk 0 size nil))))))

(defun WSTR-length (chunk)
  (check-chunk chunk)
  (identity
   (floor
    (/ (si:chunk-size chunk)
       *size-of-wstr*))))

(defun make-DWORD (&optional initial-value)
  (let ((r (si:make-chunk 'DWORD 4)))
    (si:pack-int32 r 0 (or initial-value 0))
    r))

(defun unpack-DWORD (chunk)
  (check-chunk chunk)
  (si:unpack-int32 chunk 0))

(defun check-chunk (chunk)
  (unless (eq (type-of chunk) 'si:chunk)
    (error 'type-error
           :datum chunk
           :expected-type 'si:chunk)))

(defun utf16-to-internal (str)
  (when str
    (ed::convert-encoding-to-internal ed::*encoding-utf16le* str)))

(defun internal-to-utf16 (str)
  (when str
    (ed::convert-encoding-from-internal ed::*encoding-utf16le* str)))

(defmacro assert-BOOL (&body body)
  (let ((result (gensym)))
    `(let ((,result (progn ,@body)))
       (when (nullp ,result)
         (error (format nil "~A failed" ',(caar body))))
       ,result)))


(provide "xl-winhttp/ffi/winapi")

;;; End
