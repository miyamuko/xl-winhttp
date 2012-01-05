; -*- mode: lisp; package: xl-winhttp; encoding: shift_jis -*-

;;; xl-winhttp/types.l
;;
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
  (require "xl-winhttp/package")
  (require "xl-winhttp/conditions")
  )

(in-package :xl-winhttp)

(defstruct hinternet
  handle closed-p)

(defstruct (session
            (:include hinternet)))

(defstruct (connection
            (:include hinternet)))

(defstruct (request
            (:include hinternet)))

(defmacro define-hinternet-wrapper (type)
  (let ((func (intern (format nil "wrap-~A" type)))
        (ctor (intern (format nil "make-~A" type))))
    `(defmacro ,func ((api &rest args))
       (let (($args (gensym))
             ($handle (gensym)))
         `(let ((,$args (list ,@args)))
            (let ((,$handle (apply ',api ,$args)))
              (when (zerop ,$handle)
                (raise-winhttp-condition ',api))
              (gc-guard ,$handle ,$args)
              (,',ctor :handle ,$handle)
              ))))))

(define-hinternet-wrapper session)
(define-hinternet-wrapper connection)
(define-hinternet-wrapper request)


(defmacro check-valid-handle (hinternet typespec)
  `(progn
     (check-type ,hinternet ,typespec)
     (when (hinternet-closed-p ,hinternet)
       (error "Closed HINTERNET handle: ~S" ,hinternet))))


(provide "xl-winhttp/types")

;;; End
