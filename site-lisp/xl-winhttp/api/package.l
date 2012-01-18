; -*- mode: lisp; package: user; encoding: shift_jis -*-

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
  (require "ansi-loop")
  (require "ansify")
  (require "alexandria")
  (require "xl-winhttp/internal")

  (unless (find-package :xl-winhttp.api)
    (defpackage :xl-winhttp.api
      (:nicknames :winhttp :xl-winhttp winhttp.api)
      (:use
       :lisp
       :editor
       :winapi
       :xl-winhttp.ffi
       :xl-winhttp.internal
       )
      (:shadowing-import-from :ansi-loop
       :loop
       :loop-finish
       )
      (:shadowing-import-from :ansify
       :check-type
       :destructuring-bind
       :ecase
       :etypecase
       :typecase
       )
      (:shadowing-import-from :alexandria
       :emptyp
       :ensure-car
       :ensure-list
       :symbolicate
       :when-let
       :with-gensyms
       )
      ))
  )

(in-package :xl-winhttp.api)

(shadow
 '(;; defpackage では shadow と shadowing-import-from を同時に使えない
   open
   connect
   ))


(provide "xl-winhttp/api/package")

;;; End
