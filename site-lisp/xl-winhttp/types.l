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
  (require "xl-winhttp/ffi")
  )

(in-package :xl-winhttp)

(deftype port-number ()
  `(integer 0 ,INTERNET_MAX_PORT_NUMBER_VALUE))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384110.aspx#support_for_greater_than_4-gb_upload
(deftype content-length ()
  ;; DWORD
  `(integer 0 ,(expt 2 32)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384116.aspx
(deftype timeout ()
  ;; int
  `(integer -1 ,(expt 2 31)))


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
             ($handle (gensym))
             ($r (gensym)))
         `(let ((,$args (list ,@args)))
            (let ((,$handle (apply ',api ,$args)))
              (when (zerop ,$handle)
                (raise-winhttp-condition ',api))
              (let ((,$r (,',ctor :handle ,$handle)))
                (gc-guard ,$r ,$args)
                ,$r)
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
