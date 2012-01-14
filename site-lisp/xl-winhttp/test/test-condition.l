; -*- mode: lisp; package: xl-winhttp.test.condition; encoding: shift_jis -*-

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

(require "lisp-unit")

(require "xl-winhttp")
(require "xl-winhttp/test/helper")

(defpackage :xl-winhttp.test.condition
  (:use :lisp :editor
   :lisp-unit
   :winhttp
   :winhttp.ffi
   :xl-winhttp.test.helper
   )
  (:shadowing-import-from :winhttp
   open
   connect
  )
  )

(in-package :xl-winhttp.test.condition)

(remove-all-tests :xl-winhttp.test.condition)

(define-test xl-winhttp/condition/connect-error
  (with-open (session)
    (with-connect (connection session "localhost" 12345)
      (with-open-request (request connection "GET" "/")
        (assert-winhttp-condition (WinHttpSendRequest 12029 ERROR_WINHTTP_CANNOT_CONNECT)
            (send-request request)))))
  )

(define-test xl-winhttp/condition/resolve-error
  (with-open (session)
    (with-connect (connection session "no-such-host" 8888)
      (with-open-request (request connection "GET" "/")
        (assert-winhttp-condition (WinHttpSendRequest 12007 ERROR_WINHTTP_NAME_NOT_RESOLVED)
            (send-request request)))))
  )
