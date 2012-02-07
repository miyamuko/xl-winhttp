; -*- mode: lisp; package: xl-winhttp.internal; encoding: shift_jis -*-

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
  (require "xl-winhttp/internal/package")
  )

(in-package :xl-winhttp.internal)

(export '(toggle-debug
          enable-debug

          info
          debug
          trace
          ))

(defvar *debug-prefix* "xl-winhttp:")
(defvar *debug-enabled-p* nil)
(defvar *debug-level* :debug)

(defconstant +debug-levels+ '(:info :debug :trace))


(defun toggle-debug (&optional (arg nil sv))
  (interactive)
  (enable-debug (if sv arg (not *debug-enabled-p*))))

(defun enable-debug (enable)
  (interactive)
  (cond ((member enable +debug-levels+)
         (setf *debug-level* enable))
        (enable
         (setf *debug-level* :debug)))
  (setf *debug-enabled-p* enable)
  (ToggleDebugOutput (pack-BOOL (debug-level-enabled-p :trace)))
  (message "Debug: ~:[Off~;On~]" enable))


(defun info (fmt &rest args)
  (debug-output :info args))

(defun debug (fmt &rest args)
  (debug-output :debug fmt args))

(defun trace (fmt &rest args)
  (debug-output :trace fmt args))

(defun debug-output (level fmt args)
  (when (debug-level-enabled-p level)
    (let* ((msg (apply 'format nil fmt args))
           (log (format nil "[~4,'0D] ~A ~A"
                        (GetCurrentThreadId) *debug-prefix* msg)))
      (OutputDebugString (si:make-string-chunk log)))))

(defun debug-level-enabled-p (level)
  (<= (position level +debug-levels+)
      (position *debug-level* +debug-levels+)))


(provide "xl-winhttp/internal/debug")

;;; End
