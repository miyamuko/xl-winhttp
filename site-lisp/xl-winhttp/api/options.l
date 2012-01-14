; -*- mode: lisp; package: xl-winhttp.api; encoding: shift_jis -*-

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
  (require "xl-winhttp/api/package")
  (require "xl-winhttp/api/types")
  )

(in-package :xl-winhttp.api)

(defun check-option (operation handle option)
  (ecase operation
    (:set-option
     (unless (option-can-set-p option)
       (error (format nil "~S オプションは設定できません。" (option-name option)))))
    (:query-option
     (unless (option-can-query-p option)
       (error (format nil "~S オプションは取得できません。" (option-name option)))))
    )
  ;; WINHTTP_OPTION_ENABLETRACING など、ハンドルを指定しなくてもいいオプションがある
  (when handle
    (etypecase handle
      (session
       (unless (option-accept-session-handle-p option)
         (error (format nil "~S オプションは session ハンドルには指定できません。" (option-name option)))))
      (request
       (unless (option-accept-request-handle-p option)
         (error (format nil "~S オプションは request ハンドルには指定できません。" (option-name option)))))
      ))
  )

(provide "xl-winhttp/api/options")

;;; End
