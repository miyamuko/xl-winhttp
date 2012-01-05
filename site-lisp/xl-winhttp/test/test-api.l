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

(define-test xl-winhttp/api/check-platform
  (assert-equal t (check-platform)))

(define-test xl-winhttp/api/crack-url
  (assert-equal (values "http" nil nil "www.yahoo.co.jp" 80 nil nil)
      (crack-url "http://www.yahoo.co.jp"))
  (assert-equal (values "http" "foo" "bar" "www.yahoo.co.jp" 8080 nil nil)
      (crack-url "http://foo:bar@www.yahoo.co.jp:8080"))
  (assert-equal (values "http" nil nil "www.google.co.jp" 80 "/search" "?q=xyzzy")
      (crack-url "http://www.google.co.jp/search?q=xyzzy"))
  (assert-equal (values "https" nil nil "127.0.0.1" 443 "/index.html" nil)
      (crack-url "https://127.0.0.1/index.html"))
  (assert-equal (values "https" nil nil "127.0.0.1" 444 "/index.html" nil)
      (crack-url "https://127.0.0.1:444/index.html"))
  )

(define-test xl-winhttp/api/create-url
  (assert-equal "http://www.yahoo.co.jp"
      (create-url "http" nil nil "www.yahoo.co.jp" 80 nil nil))
  (assert-equal "http://www.yahoo.co.jp"
      (create-url "http" "" "" "www.yahoo.co.jp" 80 "" ""))

  (assert-equal "http://www.yahoo.co.jp"
      (create-url "http" 0 0 "www.yahoo.co.jp" 80 0 0))
  (assert-equal "http://foo:bar@www.yahoo.co.jp:8080"
      (create-url "http" "foo" "bar" "www.yahoo.co.jp" 8080 nil nil))
  (assert-equal "http://www.google.co.jp/search?q=xyzzy"
      (create-url "http" nil nil "www.google.co.jp" 80 "/search" "?q=xyzzy"))
  (assert-equal "https://127.0.0.1/index.html"
      (create-url "https" nil nil "127.0.0.1" 443 "/index.html" nil))
  (assert-equal "https://127.0.0.1:444/index.html"
      (create-url "https" nil nil "127.0.0.1" 444 "/index.html" nil))

  (assert-equal "http://127.0.0.1/index.html"
      (create-url winhttp.ffi:INTERNET_SCHEME_HTTP nil nil "127.0.0.1" winhttp.ffi:INTERNET_DEFAULT_HTTP_PORT "/index.html" nil))
  (assert-equal "https://127.0.0.1/index.html"
      (create-url winhttp.ffi:INTERNET_SCHEME_HTTPS nil nil "127.0.0.1" winhttp.ffi:INTERNET_DEFAULT_HTTPS_PORT "/index.html" nil))
  )


(define-test xl-winhttp/api/time-to-system-time
  (assert-equal (values 2000 11 2 21 1 6 53 0)
      (time-to-system-time "Tue, 21 Nov 2000 01:06:53 GMT"))
  (assert-equal (values 2012 1 4 5 5 54 55 0)
      (time-to-system-time "Thu, 05 Jan 2012 05:54:55 GMT"))
  )

(define-test xl-winhttp/api/time-from-system-time
  (assert-equal "Tue, 21 Nov 2000 01:06:53 GMT"
      (time-from-system-time 2000 11 2 21 1 6 53 0))
  (assert-equal "Thu, 05 Jan 2012 05:54:55 GMT"
      (time-from-system-time 2012 1 4 5 5 54 55 0))
  (assert-equal "Thu, 05 Jan 2012 05:54:55 GMT"
      (multiple-value-call #'time-from-system-time
        (time-to-system-time "Thu, 05 Jan 2012 05:54:55 GMT")))
  )


(define-test xl-winhttp/api/query-option-WSTR
  (with-open (session :user-agent "xl-winhttp/1.0")
    (assert-equal "xl-winhttp/1.0"
        (query-option-WSTR session WINHTTP_OPTION_USER_AGENT)))
  )

(define-test xl-winhttp/api/set-option-WSTR
  (with-open (session :user-agent "xl-winhttp/1.0")
    (set-option-WSTR session WINHTTP_OPTION_USER_AGENT "xl-winhttp/1.1")
    (assert-equal "xl-winhttp/1.1"
        (query-option-WSTR session WINHTTP_OPTION_USER_AGENT)))
  )

(define-test xl-winhttp/api/query-option-DWORD
  (with-open (session :user-agent "xl-winhttp/1.0")
    (set-timeouts session :connect 123)
    (assert-equal 123
        (query-option-DWORD session WINHTTP_OPTION_CONNECT_TIMEOUT)))
  )

(define-test xl-winhttp/api/set-option-DWORD
  (with-open (session :user-agent "xl-winhttp/1.0")
    (set-option-DWORD session WINHTTP_OPTION_CONNECT_TIMEOUT 123456)
    (assert-equal 123456
        (query-option-DWORD session WINHTTP_OPTION_CONNECT_TIMEOUT)))
  )
