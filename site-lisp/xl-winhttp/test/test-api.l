; -*- mode: lisp; package: xl-winhttp.test.api; encoding: shift_jis -*-

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

(defpackage :xl-winhttp.test.api
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

(in-package :xl-winhttp.test.api)

(remove-all-tests :xl-winhttp.test.api)

(define-test xl-winhttp/api/check-platform
  (assert-equal t (check-platform)))

(define-test xl-winhttp/api/crack-url
  (assert-equal (values "http" nil nil "www.yahoo.co.jp" 80 nil nil)
      (crack-url "http://www.yahoo.co.jp"))
  (assert-equal (values "http" nil nil "www.google.co.jp" 80 "/search" "?q=xyzzy")
      (crack-url "http://www.google.co.jp/search?q=xyzzy"))
  (assert-equal (values "https" nil nil "127.0.0.1" 443 "/index.html" nil)
      (crack-url "https://127.0.0.1/index.html"))
  (assert-equal (values "https" nil nil "127.0.0.1" 444 "/index.html" nil)
      (crack-url "https://127.0.0.1:444/index.html"))

  ;; reject-userpwd
  (assert-equal (values "http" "foo" "bar" "www.yahoo.co.jp" 8080 nil nil)
      (crack-url "http://foo:bar@www.yahoo.co.jp:8080"))
  (assert-winhttp-condition (WinHttpCrackUrl 12005 ERROR_WINHTTP_INVALID_URL)
      (crack-url "http://foo:bar@www.yahoo.co.jp:8080" :reject-userpwd t))

  ;; escape
  (assert-equal (values "http" nil nil "www.google.co.jp" 80 "/search" "?q=%E3%81%82")
      (crack-url "http://www.google.co.jp/search?q=あ" :escape t))

  ;; decode
  (assert-equal (values "http" nil nil "www.google.co.jp" 80 "/search" "?q=あ")
      (crack-url "http://www.google.co.jp/search?q=%E3%81%82" :decode t))

  ;; EUC の場合は decode できない
  ;; Windows 7 以降の場合は ERROR_WINHTTP_INVALID_URL が発生する
  (assert-equal (values "http" nil nil "search.hatena.ne.jp" 80 "/search" "?word=%A4%A2")
      (crack-url "http://search.hatena.ne.jp/search?word=%A4%A2" :decode nil))
  (when (windows7-or-later-p)
    (assert-winhttp-condition (WinHttpCrackUrl 87 ERROR_INVALID_PARAMETER)
        (crack-url "http://search.hatena.ne.jp/search?word=%A4%A2" :decode t)))
  )

(define-test xl-winhttp/api/create-url
  (assert-equal "http://"
      (create-url nil nil nil nil nil nil nil nil))
  (assert-equal "http://www.yahoo.co.jp"
      (create-url nil nil nil "www.yahoo.co.jp" nil nil nil nil))

  (assert-equal "http://www.yahoo.co.jp"
      (create-url "http" nil nil "www.yahoo.co.jp" 80 nil nil nil))
  (assert-equal "http://www.yahoo.co.jp"
      (create-url "http" "" "" "www.yahoo.co.jp" 80 "" "" nil))

  (assert-equal "http://foo:bar@www.yahoo.co.jp:8080"
      (create-url "http" "foo" "bar" "www.yahoo.co.jp" 8080 nil nil nil))
  (assert-equal "http://www.google.co.jp/search?q=xyzzy"
      (create-url "http" nil nil "www.google.co.jp" 80 "/search" "?q=xyzzy" nil))
  (assert-equal "https://127.0.0.1/index.html"
      (create-url "https" nil nil "127.0.0.1" 443 "/index.html" nil nil))
  (assert-equal "https://127.0.0.1:444/index.html"
      (create-url "https" nil nil "127.0.0.1" 444 "/index.html" nil nil))

  (assert-equal "http://127.0.0.1/index.html"
      (create-url INTERNET_SCHEME_HTTP nil nil "127.0.0.1" INTERNET_DEFAULT_HTTP_PORT "/index.html" nil nil))
  (assert-equal "https://127.0.0.1/index.html"
      (create-url INTERNET_SCHEME_HTTPS nil nil "127.0.0.1" INTERNET_DEFAULT_HTTPS_PORT "/index.html" nil nil))

  (assert-equal "http://127.0.0.1/index.html"
      (create-url :http nil nil "127.0.0.1" nil "/index.html" nil nil))
  (assert-equal "https://127.0.0.1/index.html"
      (create-url :https nil nil "127.0.0.1" nil "/index.html" nil nil))

  (assert-equal "http://127.0.0.1:81/index.html"
      (create-url 'http nil nil "127.0.0.1" 81 "/index.html" nil nil))
  (assert-equal "https://127.0.0.1:444/index.html"
      (create-url 'https nil nil "127.0.0.1" 444 "/index.html" nil nil))

  ;; secure-p
  (assert-equal "https://"
      (create-url nil nil nil nil nil nil nil t))
  (assert-equal "https://www.yahoo.co.jp"
      (create-url nil nil nil "www.yahoo.co.jp" nil nil nil t))
  (assert-equal "http://www.yahoo.co.jp"
      (create-url "http" nil nil "www.yahoo.co.jp" nil nil nil t))
  (assert-equal "https://www.yahoo.co.jp"
      (create-url "https" nil nil "www.yahoo.co.jp" nil nil nil t))
  (assert-equal "https://www.yahoo.co.jp:444"
      (create-url "https" nil nil "www.yahoo.co.jp" 444 nil nil t))

  ;; escape
  (assert-equal "http://www.google.co.jp/search?q=%20!%22%23$%25&'()"
      (create-url "http" nil nil "www.google.co.jp" 80 "/search" "?q= !\"#$%&'()" nil :escape t))
  ;; reject-userpwd
  (assert-equal "http://www.yahoo.co.jp:8080"
      (create-url "http" "foo" "bar" "www.yahoo.co.jp" 8080 nil nil nil :reject-userpwd t))
  )


(define-test xl-winhttp/api/time-to-system-time
  (assert-equal (values 0 0 0 1 1 1900 1)
      (time-to-system-time "Mon, 01 Jan 1900 00:00:00 GMT"))
  (assert-equal (values 1 2 18 3 5 2000 3)
      (time-to-system-time "Wed, 03 May 2000 18:02:01 GMT"))
  (assert-equal (values 1 2 3 4 5 2000 4)
      (time-to-system-time (time-from-system-time 1 2 3 4 5 2000)))
  )

(define-test xl-winhttp/api/time-from-system-time
  (assert-equal "Sat, 01 Jan 2000 00:00:00 GMT"
      (time-from-system-time 0 0 0 1 1 2000))
  (assert-equal "Thu, 04 May 2000 03:02:01 GMT"
      (time-from-system-time 1 2 3 4 5 2000))
  (assert-equal "Wed, 03 May 2000 18:02:01 GMT"
      (multiple-value-bind (second minute hour date month year day-of-week)
          (time-to-system-time "Wed, 03 May 2000 18:02:01 GMT")
        (time-from-system-time second minute hour date month year)))
  )

(define-test xl-winhttp/api/time-to-universal-time
  (assert-equal (encode-universal-time 0 0 0 1 1 1900 0)
      (time-to-universal-time "Mon, 01 Jan 1900 00:00:00 GMT"))
  (assert-equal (encode-universal-time 1 2 3 4 5 2000 0)
      (time-to-universal-time "Thu, 04 May 2000 03:02:01 GMT"))
  (assert-equal (encode-universal-time 1 2 3 4 5 2000 0)
      (time-to-universal-time (time-from-universal-time (encode-universal-time 1 2 3 4 5 2000 0))))
  )

(define-test xl-winhttp/api/time-from-universal-time
  (assert-equal "Mon, 01 Jan 1900 00:00:00 GMT"
      (time-from-universal-time (encode-universal-time 0 0 9 1 1 1900)))
  (assert-equal "Wed, 03 May 2000 18:02:01 GMT"
      (time-from-universal-time (encode-universal-time 1 2 3 4 5 2000)))
  (assert-equal "Wed, 03 May 2000 18:02:01 GMT"
      (time-from-universal-time (time-to-universal-time "Wed, 03 May 2000 18:02:01 GMT")))
  )


(define-test xl-winhttp/api/query-option-session
  (with-open (session :user-agent "xl-winhttp/1.0")
    (assert-equal "xl-winhttp/1.0"
        (query-option session WINHTTP_OPTION_USER_AGENT))
    (assert-equal "xl-winhttp/1.0"
        (query-option session :user-agent))

    (set-timeouts session :connect 123)
    (assert-equal 123
        (query-option session WINHTTP_OPTION_CONNECT_TIMEOUT))
    (assert-equal 123
        (query-option session :connect-timeout))
    )
  )

(define-test xl-winhttp/api/set-option-session
  (with-open (session :user-agent "xl-winhttp/1.0")
    (set-option session WINHTTP_OPTION_USER_AGENT "xl-winhttp/1.1")
    (assert-equal "xl-winhttp/1.1"
        (query-option session WINHTTP_OPTION_USER_AGENT))

    (set-option session :user-agent "xl-winhttp/1.1")
    (assert-equal "xl-winhttp/1.1"
        (query-option session :user-agent))

    (set-option session WINHTTP_OPTION_CONNECT_TIMEOUT 123456)
    (assert-equal 123456
        (query-option session WINHTTP_OPTION_CONNECT_TIMEOUT))

    (set-option session :connect-timeout 123456)
    (assert-equal 123456
        (query-option session :connect-timeout))
    )
  )

(define-test xl-winhttp/api/set-query-option-request
  (with-open (session)
    (with-connect (connection session "www.google.co.jp")
      (with-open-request (request connection "GET" "/")
        (set-option request WINHTTP_OPTION_USERNAME "foo")
        (assert-equal "foo"
            (query-option request WINHTTP_OPTION_USERNAME))
        (assert-equal "foo"
            (query-option request :username))

        (set-option request WINHTTP_OPTION_USERNAME "bar")
        (assert-equal "bar"
            (query-option request WINHTTP_OPTION_USERNAME))
        (assert-equal "bar"
            (query-option request :username))

        (set-option request WINHTTP_OPTION_WRITE_BUFFER_SIZE 123)
        (assert-equal 123
            (query-option request WINHTTP_OPTION_WRITE_BUFFER_SIZE))
        (assert-equal 123
            (query-option request :write-buffer-size))

        (set-option request :write-buffer-size 12345)
        (assert-equal 12345
            (query-option request WINHTTP_OPTION_WRITE_BUFFER_SIZE))
        (assert-equal 12345
            (query-option request :write-buffer-size))
        )))
  )

(define-test xl-winhttp/api/invalid-option
  (with-open (session)
    (assert-error 'simple-error
        (set-option session WINHTTP_OPTION_HANDLE_TYPE 10))

    (assert-error 'simple-error
        (query-option session WINHTTP_OPTION_CONFIGURE_PASSPORT_AUTH))
    )
  )

(define-test xl-winhttp/api/open-request/accept
  (with-open (session :user-agent "xl-winhttp")
    (with-connect (connection session "www.google.co.jp")
      (with-open-request (request connection "GET" "/")
        (send-request request)
        (receive-response request)
        (assert-equal nil
            (query-request-header request :accept))
        )
      (with-open-request (request connection "GET" "/foo"
                                  :accept "*/*")
        (send-request request)
        (receive-response request)
        (assert-equal "*/*"
            (query-request-header request :accept))
        )
      (with-open-request (request connection "GET" "/"
                                  :accept (list "text/html" "image/png"))
        (add-request-headers request '(:accept "*/*") :coalesce-with-comma t)
        (send-request request)
        (receive-response request)
        (assert-equal "text/html, image/png, */*"
            (query-request-header request :accept))
        )
      ))
  )

(define-test xl-winhttp/api/send-request/header
  (with-open (session :user-agent "xl-winhttp")
    (with-connect (connection session "www.google.co.jp")
      (with-open-request (request connection "GET" "/")
        (send-request request :headers '(:X-String :foo
                                         :X-Number 123))
        (receive-response request)
        (assert-equal "foo"
            (query-request-header request "X-String"))
        (assert-equal "123"
            (query-request-header request "X-Number"))
        )
      )))

(define-test xl-winhttp/api/add-request-headers
  (with-open (session :user-agent "xl-winhttp")
    (with-connect (connection session "www.google.co.jp")
      (with-open-request (request connection "GET" "/")
        (add-request-headers request '(:X-String :bar
                                       :X-Number 124))
        (assert-equal "bar"
            (query-request-header request "X-String"))
        (assert-equal "124"
            (query-request-header request "X-Number"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-headers request '(:X-String :foo))
        (add-request-headers request '(:X-String :bar))
        (assert-equal '("foo" "bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-headers request '(:X-String :foo) :add-if-new t)
        (assert-winhttp-condition (WinHttpAddRequestHeaders 12155 ERROR_WINHTTP_HEADER_ALREADY_EXISTS)
            (add-request-headers request '(:X-String :bar) :add-if-new t))
        (assert-equal '("foo")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (assert-winhttp-condition (WinHttpAddRequestHeaders 12150 ERROR_WINHTTP_HEADER_NOT_FOUND)
            (add-request-headers request '(:X-String :bar) :replace t))
        (add-request-headers request '(:X-String :foo) :add t)
        (add-request-headers request '(:X-String :bar) :replace t)
        (assert-equal '("bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-headers request '(:X-String :foo) :coalesce t)
        (add-request-headers request '(:X-String :bar) :coalesce t)
        (assert-equal '("foo, bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-headers request '(:X-String :foo) :coalesce-with-comma t)
        (add-request-headers request '(:X-String :bar) :coalesce-with-comma t)
        (assert-equal '("foo, bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-headers request '(:X-String :foo) :coalesce-with-semicolon t)
        (add-request-headers request '(:X-String :bar) :coalesce-with-semicolon t)
        (assert-equal '("foo; bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-headers request '(:X-String :foo :X-String :bar))
        (assert-equal '("foo" "bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-headers request '(:X-String :foo :X-String :bar) :coalesce-with-semicolon t)
        (add-request-headers request '(:X-String :baz :X-String :hoge) :coalesce-with-semicolon t)
        (assert-equal '("foo; bar; baz; hoge")
            (query-request-headers request "X-String"))
        )
      )))

(define-test xl-winhttp/api/add-request-header
  (with-open (session :user-agent "xl-winhttp")
    (with-connect (connection session "www.google.co.jp")
      (with-open-request (request connection "GET" "/")
        (add-request-header request :X-String :bar)
        (assert-equal "bar"
            (query-request-header request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-header request :X-String :foo)
        (add-request-header request :X-String :bar)
        (assert-equal '("foo" "bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-header request :X-String :foo :add-if-new t)
        (assert-winhttp-condition (WinHttpAddRequestHeaders 12155 ERROR_WINHTTP_HEADER_ALREADY_EXISTS)
            (add-request-header request :X-String :bar :add-if-new t))
        (assert-equal '("foo")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (assert-winhttp-condition (WinHttpAddRequestHeaders 12150 ERROR_WINHTTP_HEADER_NOT_FOUND)
            (add-request-header request :X-String :bar :replace t))
        (add-request-header request :X-String :foo :add t)
        (add-request-header request :X-String :bar :replace t)
        (assert-equal '("bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-header request :X-String :foo :coalesce t)
        (add-request-header request :X-String :bar :coalesce t)
        (assert-equal '("foo, bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-header request :X-String :foo :coalesce-with-comma t)
        (add-request-header request :X-String :bar :coalesce-with-comma t)
        (assert-equal '("foo, bar")
            (query-request-headers request "X-String"))
        )

      (with-open-request (request connection "GET" "/")
        (add-request-header request :X-String :foo :coalesce-with-semicolon t)
        (add-request-header request :X-String :bar :coalesce-with-semicolon t)
        (assert-equal '("foo; bar")
            (query-request-headers request "X-String"))
        )
      )))

(define-test xl-winhttp/api/query-request-header
  (with-open (session :user-agent "xl-winhttp")
    (with-connect (connection session "www.google.co.jp")
      (with-open-request (request connection "GET" "/")
        (send-request request
                      :headers (format nil "~{~A~%~}" '("X-String: foo"
                                                        "X-String: bar"
                                                        "X-Number: 123"
                                                        "X-Number: 12345"
                                                        "X-Date: Wed, 03 May 2000 18:02:01 GMT"
                                                        "X-Date: Thu, 04 May 2000 03:02:01 GMT"
                                                        )))
        (receive-response request)
        (assert-equal "GET"
            (query-request-header request :request-method))

        (assert-equal "foo"
            (query-request-header request "X-String"))
        (assert-equal "foo"
            (query-request-header request "X-String" :index 0))
        (assert-equal "bar"
            (query-request-header request "X-String" :index 1))
        (assert-equal '("foo" "bar")
            (query-request-headers request "X-String"))

        (assert-equal "123"
            (query-request-header request "X-Number"))
        (assert-equal "123"
            (query-request-header request "X-Number" :index 0))
        (assert-equal "12345"
            (query-request-header request "X-Number" :index 1))
        (assert-equal '("123" "12345")
            (query-request-headers request "X-Number"))

        (assert-equal "Wed, 03 May 2000 18:02:01 GMT"
            (query-request-header request "X-Date"))
        (assert-equal "Wed, 03 May 2000 18:02:01 GMT"
            (query-request-header request "X-Date" :index 0))
        (assert-equal "Thu, 04 May 2000 03:02:01 GMT"
            (query-request-header request "X-Date" :index 1))
        (assert-equal '("Wed, 03 May 2000 18:02:01 GMT"
                        "Thu, 04 May 2000 03:02:01 GMT")
            (query-request-headers request "X-Date"))

        ;; :number
        (assert-equal 123
            (query-request-header request "X-Number" :type :number))
        (assert-equal 123
            (query-request-header request "X-Number" :index 0 :type :number))
        (assert-equal 12345
            (query-request-header request "X-Number" :index 1 :type :number))
        (assert-equal '(123 12345)
            (query-request-headers request "X-Number" :type :number))

        ;; :system-time
        (assert-equal (values 1 2 18 3 5 2000 3)
            (query-request-header request "X-Date" :type :system-time))
        (assert-equal (values 1 2 18 3 5 2000 3)
            (query-request-header request "X-Date" :index 0 :type :system-time))
        (assert-equal (values 1 2 3 4 5 2000 4)
            (query-request-header request "X-Date" :index 1 :type :system-time))
        (assert-equal '((1 2 18 3 5 2000 3)
                        (1 2 3 4 5 2000 4))
            (query-request-headers request "X-Date" :type :system-time))

        ;; :universal-time
        (assert-equal 3166365721
            (query-request-header request "X-Date" :type :universal-time))
        (assert-equal 3166365721
            (query-request-header request "X-Date" :index 0 :type :universal-time))
        (assert-equal 3166398121
            (query-request-header request "X-Date" :index 1 :type :universal-time))
        (assert-equal '(3166365721 3166398121)
            (query-request-headers request "X-Date" :type :universal-time))

        (let ((actual-headers (split-string (query-request-header request :raw-headers) #\NUL)))
          (assert-true (member "X-String: foo" actual-headers :test #'string-equal))
          (assert-true (member "X-String: bar" actual-headers :test #'string-equal))
          (assert-true (member "X-Number: 123" actual-headers :test #'string-equal))
          (assert-true (member "X-Number: 12345" actual-headers :test #'string-equal))
          (assert-true (member "X-Date: Wed, 03 May 2000 18:02:01 GMT" actual-headers :test #'string-equal))
          (assert-true (member "X-Date: Thu, 04 May 2000 03:02:01 GMT" actual-headers :test #'string-equal))
          )
        )))
  )

(define-test xl-winhttp/api/query-response-header
  (with-open (session :user-agent "xl-winhttp")
    (with-connect (connection session "www.google.co.jp")
      (with-open-request (request connection "GET" "/")
        (send-request request)
        (receive-response request)

        ;; TODO
        ;; テスト用のサーバを書いてレスポンスヘッダ周りのテスト
        )))
  )
