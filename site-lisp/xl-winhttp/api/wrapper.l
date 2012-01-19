; -*- mode: lisp; package: xl-winhttp.api; encoding: shift_jis -*-

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
  (require "xl-winhttp/api/package")
  (require "xl-winhttp/api/api")
  )

(in-package :xl-winhttp.api)

(export '(query-request-header
          query-request-headers
          query-response-header
          query-response-headers
          ))

(defun query-request-header (request header &key (type :string) (index 0))
  "Retrieves request header information associated with an HTTP request."
  (query-headers request header :request-headers t :type type :index index))

(defun query-request-headers (request header &key (type :string))
  "Retrieves all request header information associated with an HTTP request."
  (query-headers request header :request-headers t :type type :list t))

(defun query-response-header (request header &key (type :string) (index 0))
  "Retrieves response header information associated with an HTTP request."
  (query-headers request header :request-headers nil :type type :index index))

(defun query-response-headers (request header &key (type :string))
  "Retrieves all response header information associated with an HTTP request."
  (query-headers request header :request-headers nil :type type :list t))


(provide "xl-winhttp/api/wrapper")

;;; End
