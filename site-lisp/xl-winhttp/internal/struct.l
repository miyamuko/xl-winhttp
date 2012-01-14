; -*- mode: lisp; package: xl-winhttp.internal; encoding: shift_jis -*-

;; This file is based on xl-cairo/site-lisp/cairo/util/struct.l.

;; Copyright (c) 2007,2009,2012 MIYAMUKO Katsuyuki.
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
  (require "xl-winhttp/internal/package")
  )

(in-package :xl-winhttp.internal)

(export '(make-structure
          structure-definition
          structure-name
          structure-package
          structure-constructor
          structure-constructors
          structure-slot-descriptions
          structure-slot-names
          structure-accessors
          export-structure
          ))

(defun make-structure (structure &rest rest)
  (apply (structure-constructor structure) rest))

(defun structure-definition (structure)
  (let ((def (cond ((si:*structure-definition-p structure)
                    structure)
                   ((si:*structurep structure)
                    (si:*structure-definition structure))
                   ((symbolp structure)
                    (get structure 'si::structure-definition)))))
    (unless def
      (error 'type-error
             :datum structure
             :expected-type 'structure))
    def))

(defun structure-name (structure)
  (si:*structure-definition-name
   (structure-definition structure)))

(defun structure-package (structure)
  (symbol-package (structure-name structure)))

(defun structure-constructor (structure)
  (car (structure-constructors structure)))

(defun structure-constructors (structure)
  (si:*structure-definition-constructors
   (structure-definition structure)))

(defun structure-slot-descriptions (structure)
  (let ((def (structure-definition structure)))
    (mapcar #'(lambda (i)
                (multiple-value-list (si:*structure-definition-slot-description def i)))
            (iota (si:*structure-definition-nslots def)))))

(defun structure-slot-names (structure)
  (mapcar #'car (structure-slot-descriptions structure)))

(defun structure-accessors (structure)
  (let* ((def (structure-definition structure))
         (name (structure-name def)))
    (mapcar #'(lambda (slot)
                (format-symbol (symbol-package name) "~A-~A" name slot))
            (structure-slot-names def))))


(defun export-structure (structure &key
                                   name accessors constructors
                                   copier predicate
                                   copier-name predicate-name)
  (let* ((def (structure-definition structure))
         (struct-name (structure-name def))
         (struct-package (structure-package def))
         exports)
    (when name
      (export struct-name))
    (when accessors
      (export (structure-accessors def)))
    (when constructors
      (export (structure-constructors def)))
    (when copier
      (export (or copier-name
                  (format-symbol struct-package "copy-~A" struct-name))))
    (when predicate
      (export (or predicate-name
                  (format-symbol struct-package "~A-p" struct-name))))
    ))


(provide "xl-winhttp/internal/struct")

;;; End
