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

(defmacro define-with-macro (init-func)
  (let ((name (intern (format nil "with-~A" init-func))))
    `(progn
       (defmacro ,name ((var &rest args) &body body)
         `(let ((,var (,',init-func ,@args)))
            (unwind-protect
                (progn ,@body)
              (close-handle ,var))))
       (setf (get ',name 'ed:lisp-indent-hook) 1)
       (export ',name)
       )))

(define-with-macro open)
(define-with-macro connect)
(define-with-macro open-request)


(provide "xl-winhttp/api/macros")

;;; End
