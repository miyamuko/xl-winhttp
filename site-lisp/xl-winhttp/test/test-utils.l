; -*- mode: lisp; package: xl-winhttp.test.utils; encoding: shift_jis -*-

;;; xl-winhttp/test/test-utils.l
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
(require "xl-winhttp/test/helper")

(defpackage :xl-winhttp.test.utils
  (:use :lisp :editor
   :lisp-unit
   :xl-winhttp.test.helper
   )
  )

(in-package :xl-winhttp.test.utils)

(remove-all-tests :xl-winhttp.test.utils)

(define-test xl-winhttp/plist-keys
  (assert-equal nil
      (winhttp::plist-keys nil))
  (assert-equal '(:foo :bar :baz)
      (winhttp::plist-keys '(:foo 1 :bar 2 :baz 3)))
  )

(define-test xl-winhttp/plist-values
  (assert-equal nil
      (winhttp::plist-values nil))
  (assert-equal '(1 2 3)
      (winhttp::plist-values '(:foo 1 :bar 2 :baz 3)))
  )

(define-test xl-winhttp/dotp
  (assert-equal nil (winhttp::dotp nil))
  (assert-equal nil (winhttp::dotp '(1)))
  (assert-equal nil (winhttp::dotp '(1 2)))
  (assert-equal t (winhttp::dotp '(1 . 2)))
  )

(define-test xl-winhttp/to-alist
  (assert-equal nil
      (winhttp::to-alist nil))
  (assert-equal '((:foo . 1))
      (winhttp::to-alist '((:foo . 1))))
  (assert-equal '((:foo . 1))
      (winhttp::to-alist '((:foo 1))))
  (assert-equal '((:foo . 1))
      (winhttp::to-alist '(:foo . 1)))
  (assert-equal '((:foo . 1))
      (winhttp::to-alist '(:foo 1)))

  (assert-equal '((:foo . 1) (:bar . 2) (:baz . 3))
      (winhttp::to-alist '((:foo . 1) (:bar . 2) (:baz . 3))))
  (assert-equal '((:foo . 1) (:bar . 2) (:baz . 3))
      (winhttp::to-alist '((:foo 1) (:bar 2) (:baz 3))))
  (assert-equal '((:foo . 1) (:bar . 2) (:baz . 3))
      (winhttp::to-alist '(:foo 1 :bar 2 :baz 3)))
  (assert-equal '((:foo . 1) (:bar . 2) (:baz . 3))
      (winhttp::to-alist '((:foo . 1) :bar 2 :baz 3)))
  (assert-equal '((:foo . 1) (:bar . 2) (:baz . 3))
      (winhttp::to-alist '((:foo . 1) (:bar 2) :baz 3)))
  )

(define-test xl-winhttp/format-headers
  (assert-equal nil
      (winhttp::format-headers nil))
  (assert-equal nil
      (winhttp::format-headers ""))
  (assert-equal "User-Agent: foo"
      (winhttp::format-headers "User-Agent: foo"))

  (assert-equal "User-Agent: foo\r\n"
      (winhttp::format-headers '("User-Agent" "foo")))
  (assert-equal "User-Agent: foo\r\n"
      (winhttp::format-headers '((:User-Agent "foo"))))
  (assert-equal "User-Agent: foo\r\n"
      (winhttp::format-headers '((:User-Agent . :foo))))

  (assert-equal "User-Agent: foo\r\nX-Number: 1\r\nX-Number: 2\r\n"
      (winhttp::format-headers '(:User-Agent :foo :X-Number 1 :X-Number 2)))
  (assert-equal "User-Agent: foo\r\nX-Number: 1\r\nX-Number: 2\r\n"
      (winhttp::format-headers '((:User-Agent . :foo) (:X-Number 1) :X-Number 2)))
  )
