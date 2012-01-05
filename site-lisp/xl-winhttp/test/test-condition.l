; -*- mode: lisp; package: xl-winhttp.test.api; encoding: shift_jis -*-

;;; xl-winhttp/test/test-api.l
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

(require "lisp-unit")

(require "xl-winhttp")

(defpackage :xl-winhttp.test.api
  (:use :lisp :editor
   :lisp-unit
   :winhttp
   :winhttp.ffi
   )
  (:shadowing-import-from :winhttp
   open
   connect
  )
  )

(in-package :xl-winhttp.test.api)

(remove-all-tests :xl-winhttp.test.api)

(define-test xl-winhttp/condition/connect-error
  (with-open (session)
    (with-connect (connection session "localhost" 1234567)
      (with-open-request (request connection "GET" "/")
        (handler-case
            (progn
              (send-request request)
              (error "winhttp-condition not threw"))
          (winhttp-condition (c)
            (assert-equal 12029 (winhttp-condition-error-code c))
            (assert-equal 'ERROR_WINHTTP_CANNOT_CONNECT (winhttp-condition-error-name c))
            (assert-equal 'WinHttpSendRequest (winhttp-condition-api c)))))))
  )

(define-test xl-winhttp/condition/resolve-error
  (with-open (session)
    (with-connect (connection session "no-such-host" 8888)
      (with-open-request (request connection "GET" "/")
        (handler-case
            (progn
              (send-request request)
              (error "winhttp-condition not threw"))
          (winhttp-condition (c)
            (assert-equal 12007 (winhttp-condition-error-code c))
            (assert-equal 'ERROR_WINHTTP_NAME_NOT_RESOLVED (winhttp-condition-error-name c))
            (assert-equal 'WinHttpSendRequest (winhttp-condition-api c)))))))
  )

(define-test xl-winhttp/condition/set-invalid-option
  (with-open (session)
    (handler-case
        (progn
          (set-option-DWORD session WINHTTP_OPTION_HANDLE_TYPE 10)
          (error "winhttp-condition not threw"))
      (winhttp-condition (c)
        (assert-equal 12011 (winhttp-condition-error-code c))
        (assert-equal 'WinHttpSetOption (winhttp-condition-api c))
        ))

    (handler-case
        (progn
          (query-option-DWORD session WINHTTP_OPTION_CONFIGURE_PASSPORT_AUTH)
          (error "winhttp-condition not threw"))
      (winhttp-condition (c)
        (assert-equal 87 (winhttp-condition-error-code c))
        (assert-equal 'WinHttpQueryOption (winhttp-condition-api c))
        ))
    )
  )
