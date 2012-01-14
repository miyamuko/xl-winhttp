; -*- mode: lisp; package: xl-winhttp.test.types; encoding: shift_jis -*-

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

(require "ansify")
(require "lisp-unit")

(require "xl-winhttp")
(require "xl-winhttp/test/helper")

(defpackage :xl-winhttp.test.types
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
  (:shadowing-import-from :ansify
   :check-type
  )
  )

(in-package :xl-winhttp.test.types)

(remove-all-tests :xl-winhttp.test.types)

(define-test xl-winhttp/types/port-number
  (check-type 0 winhttp::port-number)
  (check-type 1 winhttp::port-number)
  (check-type 65535 winhttp::port-number)

  (assert-error 'type-error
      (check-type -1 winhttp::port-number))
  (assert-error 'type-error
      (check-type 65536 winhttp::port-number))

  (assert-error 'type-error
      (check-type 1.1 winhttp::port-number))
  (assert-error 'type-error
      (check-type 1.1d0 winhttp::port-number))
  )

(define-test xl-winhttp/types/content-length
  (check-type 0 winhttp::content-length)
  (check-type 1 winhttp::content-length)
  (check-type (expt 2 32) winhttp::content-length)

  (assert-error 'type-error
      (check-type -1 winhttp::content-length))
  (assert-error 'type-error
      (check-type (1+ (expt 2 32)) winhttp::content-length))

  (assert-error 'type-error
      (check-type 1.1 winhttp::content-length))
  (assert-error 'type-error
      (check-type 1.1d0 winhttp::content-length))
  )

(define-test xl-winhttp/types/timeout
  (check-type -1 winhttp::timeout)
  (check-type 0 winhttp::timeout)
  (check-type 1 winhttp::timeout)
  (check-type (expt 2 31) winhttp::timeout)

  (assert-error 'type-error
      (check-type -2 winhttp::timeout))
  (assert-error 'type-error
      (check-type (1+ (expt 2 31)) winhttp::timeout))

  (assert-error 'type-error
      (check-type 1.1 winhttp::timeout))
  (assert-error 'type-error
      (check-type 1.1d0 winhttp::timeout))
  )
