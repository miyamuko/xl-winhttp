; -*- mode: lisp; package: winhttp; encoding: shift_jis -*-

;;; xl-winhttp/types.l
;;
;; Copyright (c) 2011 MIYAMUKO Katsuyuki.
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
  (require "xl-winhttp/package")
  )

(in-package :winhttp)

(defstruct handle
  handle closed-p)

(defstruct (session
            (:include handle)))

(defstruct (connection
            (:include handle)))

(defstruct (request
            (:include handle)))

(defmacro define-handle-wrapper (type)
  (let ((func (intern (format nil "wrap-~A" type)))
        (ctor (intern (format nil "make-~A" type)))
        (handle (gensym)))
    `(defmacro ,func (&body body)
       `(let ((,',handle (progn ,@body)))
          (when (zerop ,',handle)
            (error (format nil "~A failed" ',(caar body))))
          (,',ctor :handle ,',handle)))))

(define-handle-wrapper session)
(define-handle-wrapper connection)
(define-handle-wrapper request)


(defun assert-handle (handle)
  (check-type handle handle)
  (when (handle-closed-p handle)
    (error "Closed handle: ~S" handle)))


(provide "xl-winhttp/types")

;;; End
