; -*- mode: lisp; package: xl-winhttp; encoding: shift_jis -*-

;;; xl-winhttp/conditions.l
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

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "xl-winhttp/package")
  )

(in-package :xl-winhttp)

(export '(winhttp-condition
          winhttp-condition-api
          winhttp-condition-error-code
          winhttp-condition-error-name
          ))

;; network-error のサブコンディションにすると、例外を処理しないと
;; いちいちダイアログが出てうざいので simple-error にする
(define-condition winhttp-condition (simple-error)
  (api error-code error-name)
  (:report (lambda (c s)
             (format s "~A に失敗しました。エラーコード: ~D~@[ (~A)~]"
                     (winhttp-condition-api c)
                     (winhttp-condition-error-code c)
                     (winhttp-condition-error-name c)
                     ))))

(defmacro raise-winhttp-condition (api)
  `(let ((error-code (GetLastError)))
     (error (make-condition 'winhttp-condition
                            :api ,api
                            :error-code error-code
                            :error-name (find-error-name error-code)))))

(defmacro assert-BOOL (&body body)
  (let ((result (gensym)))
    `(let ((,result (progn ,@body)))
       (when (nullp ,result)
         (raise-winhttp-condition ',(caar body)))
       t)))

(defmacro assert-SUCCESS (&body body)
  (let ((result (gensym)))
    `(let ((,result (progn ,@body)))
       (when (/= ,result ERROR_SUCCESS)
         (raise-winhttp-condition ',(caar body)))
       t)))


(provide "xl-winhttp/conditions")

;;; End
