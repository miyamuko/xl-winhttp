; -*- mode: lisp; package: xl-winhttp.test.ffi-utils; encoding: shift_jis -*-

;;; xl-winhttp/test/test-ffi-utils.l
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

(defpackage :xl-winhttp.test.ffi-utils
  (:use :lisp :editor
   :lisp-unit
   :winhttp.ffi
   ))

(in-package :xl-winhttp.test.ffi-utils)

(remove-all-tests :xl-winhttp.test.ffi-utils)

(define-test xl-winhttp/ffi/nullp
  (assert-true (nullp 0))
  (assert-true (nullp NULL))
  (assert-true (nullp nil))
  (assert-false (nullp 1))
  (assert-false (nullp "hoge"))
  (assert-false (nullp (si:make-chunk nil 1)))
  )

(define-test xl-winhttp/ffi/make-WSTR
  (let ((wstr (make-WSTR "foo"))
        (bytes (* 2 (1+ 3))))
    (assert-eql bytes (si:chunk-size wstr))
    (assert-equal (format nil "~{~C~}" '(#\f #\NUL #\o #\NUL #\o #\NUL #\NUL #\NUL))
        (si:unpack-string wstr 0 bytes nil)))
  (let ((wstr (make-WSTR ""))
        (bytes (* 2 (1+ 0))))
    (assert-eql bytes (si:chunk-size wstr))
    (assert-equal (format nil "~{~C~}" '(#\NUL #\NUL))
        (si:unpack-string wstr 0 bytes nil)))
  (let ((wstr (make-WSTR nil)))
    (assert-eql 0 wstr))
  (let ((wstr (make-WSTR 0)))
    (assert-eql 0 wstr))
  (let ((wstr (make-WSTR 0 :default -1)))
    (assert-eql -1 wstr))
  )

(define-test xl-winhttp/ffi/make-WSTR-buffer
  (let ((buffer (make-WSTR-buffer 10)))
    (assert-eql 20 (si:chunk-size buffer))
    (assert-eql 'winhttp.ffi::wstr (si:chunk-type buffer))
    )
  (let ((buffer (make-WSTR-buffer 0)))
    (assert-eql 0 (si:chunk-size buffer))
    (assert-eql 'winhttp.ffi::wstr (si:chunk-type buffer))
    )
  )

(define-test xl-winhttp/ffi/make-WSTR-array
  (multiple-value-bind (array chunks)
      (make-WSTR-array '("foo" "bar" "baz"))
    (assert-eql (* 4 (1+ 3)) (si:chunk-size array))
    (assert-eql 3 (length chunks))

    (assert-eql (si:chunk-data (nth 0 chunks)) (si:unpack-uint32 array 0))
    (assert-eql (si:chunk-data (nth 1 chunks)) (si:unpack-uint32 array 4))
    (assert-eql (si:chunk-data (nth 2 chunks)) (si:unpack-uint32 array 8))
    (assert-eql 0 (si:unpack-uint32 array 12))
    )

  (multiple-value-bind (array chunks)
      (make-WSTR-array nil)
    (assert-eql 0 array)
    (assert-eql nil chunks)
    )
  )

(define-test xl-winhttp/ffi/unpack-WSTR
  (let ((wstr (make-WSTR "foo")))
    (assert-equal "foo" (unpack-WSTR wstr)))
  (let ((wstr (make-WSTR "‚ ‚¢‚¤")))
    (assert-equal "‚ ‚¢‚¤" (unpack-WSTR wstr)))
  (let ((wstr (make-WSTR "")))
    (assert-equal nil (unpack-WSTR wstr)))
  (let ((wstr (make-WSTR 0)))
    (assert-equal nil (unpack-WSTR wstr)))
  (let ((wstr (make-WSTR nil)))
    (assert-equal nil (unpack-WSTR wstr)))
  )

(define-test xl-winhttp/ffi/find-error-name
  (assert-equal nil
      (winhttp.ffi::find-error-name -12345))
  (assert-equal 'ERROR_INVALID_PARAMETER
      (winhttp.ffi::find-error-name 87))
  (assert-equal 'ERROR_WINHTTP_TIMEOUT
      (winhttp.ffi::find-error-name 12002))
  (assert-equal 'ERROR_WINHTTP_INVALID_OPTION
      (winhttp.ffi::find-error-name 12009))
  )

(define-test xl-winhttp/ffi/make-error-keyword
  (assert-equal nil
      (winhttp.ffi::make-error-keyword nil))
  (assert-equal :invalid-parameter
      (winhttp.ffi::make-error-keyword 'ERROR_INVALID_PARAMETER))
  (assert-equal :timeout
      (winhttp.ffi::make-error-keyword 'ERROR_WINHTTP_TIMEOUT))
  (assert-equal :invalid-option
      (winhttp.ffi::make-error-keyword 'ERROR_WINHTTP_INVALID_OPTION))
  )
