; -*- mode: lisp; package: xl-winhttp; encoding: shift_jis -*-

;;; xl-winhttp/debug.l
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
  (require "xl-winhttp/ffi")
  )

(in-package :xl-winhttp)

(export '(toggle-debug
          ))

(defvar *debug-prefix* "xl-winhttp:")
(defvar *debug-enabled-p* nil)

(defun toggle-debug (&optional (arg nil sv))
  (interactive)
  (setf *debug-enabled-p* (if sv
                              arg
                            (not *debug-enabled-p*)))
  (ToggleDebugOutput (pack-BOOL *debug-enabled-p*))
  (message "Debug: ~:[Off~;On~]" *debug-enabled-p*))

(defun debug (fmt &rest args)
  (when *debug-enabled-p*
    (let* ((msg (apply 'format nil fmt args))
           (log (format nil "[~4,'0D] ~A ~A"
                        (GetCurrentThreadId) *debug-prefix* msg)))
      (OutputDebugString (si:make-string-chunk log)))))


(provide "xl-winhttp/debug")

;;; End
