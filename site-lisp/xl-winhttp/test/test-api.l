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
   )
  (:shadowing-import-from :winhttp
   open
   connect
  )
  )

(in-package :xl-winhttp.test.api)

(remove-all-tests :xl-winhttp.test.api)

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
