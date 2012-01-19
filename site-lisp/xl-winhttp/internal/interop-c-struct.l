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
  )

(in-package :xl-winhttp.internal)

(export '(unpack-WINHTTP_ASYNC_RESULT
          pack-WINHTTP_PROXY_INFO
          unpack-WINHTTP_PROXY_INFO
          pack-SYSTEMTIME
          unpack-SYSTEMTIME
          ))

(defun unpack-WINHTTP_ASYNC_RESULT (result)
  (check-chunk result)
  (values (unpack-flags (WINHTTP_ASYNC_RESULT-dwResult result)
                        *async-result-type* :flags nil)
          (WINHTTP_ASYNC_RESULT-dwError result)))

(defun pack-WINHTTP_PROXY_INFO (&key proxy-name proxy-bypass access-type)
  (let ((&proxy-info (make-WINHTTP_PROXY_INFO))
        (&proxy-name (make-WSTR proxy-name :default WINHTTP_NO_PROXY_NAME))
        (&proxy-bypass (make-WSTR proxy-bypass :default WINHTTP_NO_PROXY_BYPASS)))
    (unless access-type
      (setf access-type (if (equal &proxy-name WINHTTP_NO_PROXY_NAME)
                            ;; MSDN にはプロキシを指定しない場合は、WINHTTP_ACCESS_TYPE_DEFAULT_PROXY
                            ;; を指定しろと書いてあるが NO_PROXY じゃないとエラーになる
                            WINHTTP_ACCESS_TYPE_NO_PROXY
                          WINHTTP_ACCESS_TYPE_NAMED_PROXY)))
    (si:clear-chunk &proxy-info)
    (setf (WINHTTP_PROXY_INFO-lpszProxy &proxy-info) &proxy-name
          (WINHTTP_PROXY_INFO-lpszProxyBypass &proxy-info) &proxy-bypass
          (WINHTTP_PROXY_INFO-dwAccessType &proxy-info) (make-flag access-type *access-type* :flags nil)
          )
    (values &proxy-info &proxy-name &proxy-bypass)))

(defun unpack-WINHTTP_PROXY_INFO (proxy-info)
  (values (unpack-WSTR-pointer (WINHTTP_PROXY_INFO-lpszProxy proxy-info) nil :free t)
          (unpack-WSTR-pointer (WINHTTP_PROXY_INFO-lpszProxyBypass proxy-info) nil :free t)
          (unpack-flags (WINHTTP_PROXY_INFO-dwAccessType proxy-info) *access-type* :flags nil)
          ))

(defun pack-SYSTEMTIME (second minute hour date month year)
  (let ((&systime (make-SYSTEMTIME)))
    (si:clear-chunk &systime)
    (setf (SYSTEMTIME-wYear &systime) year
          (SYSTEMTIME-wMonth &systime) month
          (SYSTEMTIME-wDay &systime) date
          (SYSTEMTIME-wHour &systime) hour
          (SYSTEMTIME-wMinute &systime) minute
          (SYSTEMTIME-wSecond &systime) second
          )
    &systime))

(defun unpack-SYSTEMTIME (&systime)
  (values (SYSTEMTIME-wSecond &systime)
          (SYSTEMTIME-wMinute &systime)
          (SYSTEMTIME-wHour &systime)
          (SYSTEMTIME-wDay &systime)
          (SYSTEMTIME-wMonth &systime)
          (SYSTEMTIME-wYear &systime)
          (SYSTEMTIME-wDayOfWeek &systime)))

(defun SYSTEMTIME->universal-time (&systime)
  )

(provide "xl-winhttp/internal/interop-c-struct")

;;; End
