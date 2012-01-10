; -*- mode: lisp; package: xl-winhttp.test.helper; encoding: shift_jis -*-

(require "lisp-unit")
(require "xl-winhttp")

(defpackage :xl-winhttp.test.helper
  (:use :lisp :editor :lisp-unit
   :winhttp
   :winhttp.ffi
   )
  (:shadowing-import-from :winhttp
   open
   connect
   )
  )

(in-package :xl-winhttp.test.helper)

(export '(windows7-or-later-p
          assert-winhttp-condition
          ))

(defun windows7-or-later-p (&optional (major (os-major-version))
                                      (minor (os-minor-version)))
  (let ((ver (+ major (/ minor 10))))
    (<= 6.1 ver)))

(defmacro assert-winhttp-condition ((api error-code error-name) &body body)
  `(handler-case
       (progn
         ,@body
         (error "winhttp-condition not threw"))
     (winhttp-condition (c)
       (assert-equal ',api (winhttp-condition-api c))
       (assert-equal ,error-code (winhttp-condition-error-code c))
       (assert-equal ',error-name (winhttp-condition-error-name c))
       )))
(setf (get 'assert-winhttp-condition 'ed:lisp-indent-hook) 2)


(provide "xl-winhttp/test/helper")

;;; End
