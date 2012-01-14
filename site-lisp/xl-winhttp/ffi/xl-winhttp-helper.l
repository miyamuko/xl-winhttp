; -*- mode: lisp; package: xl-winhttp.ffi; encoding: shift_jis -*-

;;; xl-winhttp/ffi/xl-winhttp-helper.l
;;
;; Copyright (c) 2012 MIYAMUKO Katsuyuki.
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
  (require "xl-winhttp/ffi/winhttp")
  )

(in-package :xl-winhttp.ffi)

(defparameter *xl-winhttp-helper-dll* "xl-winhttp/ffi/xl-winhttp-helper.dll")
(defparameter *helper-dll* nil)

(defun helper-dll ()
  (or *helper-dll*
      (setf *helper-dll*
            (find-dll *xl-winhttp-helper-dll*))))

(defun find-dll (base)
  (dolist (loadpath *load-path*)
    (let ((fullpath (merge-pathnames base loadpath)))
      (when (file-exist-p fullpath)
        (return fullpath)))))

;; xl-winhttp-helper.dll をアンロードする。
;; アンロード後に WinHTTP からコールバックされると
;; xyzzy がクラッシュするので注意すること。
(defun unload-helper-dll ()
  (dolist (sym '(GetWinHttpStatusCallbackAddress
                 QueryWinHttpStatusCallbackInfoAvailable
                 TakeWinHttpStatusCallbackInfo
                 ))
    (fmakunbound sym))
  (gc))


(c:*define-c-struct WINHTTP_STATUS_CALLBACK_INFO
  (HINTERNET hInternet)
  (DWORD_PTR dwContext)
  (DWORD dwInternetStatus)
  (LPVOID lpvStatusInformation)
  (DWORD dwStatusInformationLength)
  (BOOL bNeedGlobalFree)
  )
(c:*define-c-type (WINHTTP_STATUS_CALLBACK_INFO *) LPWINHTTP_STATUS_CALLBACK_INFO)

(c:*define-dll-entry
  WINHTTP_STATUS_CALLBACK
  GetWinHttpStatusCallbackAddress ()
  (helper-dll))

(c:*define-dll-entry
  BOOL
  QueryWinHttpStatusCallbackInfoAvailable ()
  (helper-dll))

(c:*define-dll-entry
  BOOL
  TakeWinHttpStatusCallbackInfo (LPWINHTTP_STATUS_CALLBACK_INFO)
  (helper-dll))

(c:*define-dll-entry
  c:void
  ToggleDebugOutput (BOOL)
  (helper-dll))


(provide "xl-winhttp/ffi/xl-winhttp-helper")

;;; End
