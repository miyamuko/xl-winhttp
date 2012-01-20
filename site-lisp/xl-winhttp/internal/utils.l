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

(export '(plist-keys
          plist-values
          format-verb
          format-headers
          default-port
          compose-url-path
          chomp-null
          ))

(defconstant +CRLF+ (format nil "~C~C" (code-char #x0d) (code-char #x0a)))
(defconstant +NULL+ (format nil "~C" #\NUL))

(defun plist-keys (plist)
  (loop for (k v) on plist by #'cddr
        collect k))

(defun plist-values (plist)
  (loop for (k v) on plist by #'cddr
        collect v))

(defun dotp (lst)
  (and (consp lst)
       (atom (cdr lst))
       (not (null (cdr lst)))))

(defun to-alist (lst)
  (cond ((null lst)
         nil)
        ;; (to-alist '(:foo . 1))
        ((dotp lst)
         (list lst))
        ;; (to-alist '(:foo 1 ...))
        ((atom (car lst))
         (cons (cons (car lst) (cadr lst))
               (to-alist (cddr lst))))
        ;; (to-alist '((:foo . 1) ...)
        ((dotp (car lst))
         (cons (car lst)
               (to-alist (cdr lst))))
        ;; (to-alist '((:foo 1) ...)
        (t
         (cons (cons (caar lst) (cadar lst))
               (to-alist (cdr lst))))))

(defun format-verb (verb)
  ;; Note: This string should be all uppercase. Many servers treat HTTP verbs as case-sensitive,
  ;; and the Internet Engineering Task Force (IETF) Requests for Comments (RFCs) spell these
  ;; verbs using uppercase characters only.
  (etypecase verb
    (null "GET")
    (symbol (string-upcase (string verb)))
    (string
     (if (emptyp verb)
         "GET"
       (string-upcase verb)))))

(defun format-headers (header)
  (etypecase header
    (null nil)
    (string
     (if (emptyp header)
         nil
       header))
    (list
     (let (r)
       (dolist (pair (to-alist header))
         (when (and pair (car pair))
           (push (format nil "~A: ~A~A"
                         (car pair) (or (cdr pair) "")
                         +CRLF+)
                 r)))
       (when r
         (format nil "~{~A~}" (nreverse r)))))
    ))

(defun default-port (scheme)
  (etypecase scheme
    (null INTERNET_DEFAULT_HTTP_PORT)
    (integer
     (cond ((= scheme INTERNET_SCHEME_HTTP) INTERNET_DEFAULT_HTTP_PORT)
           ((= scheme INTERNET_SCHEME_HTTPS) INTERNET_DEFAULT_HTTPS_PORT)
           (t nil)))
    ((or string symbol)
     (cond ((string-equal scheme "http") INTERNET_DEFAULT_HTTP_PORT)
           ((string-equal scheme "https") INTERNET_DEFAULT_HTTPS_PORT)
           (t nil)))
    ))

(defun compose-url-path (object-name)
  ;; RFC 2616
  ;; Note that the absolute path cannot be empty; if none is present in the original URI,
  ;; it MUST be given as "/" (the server root).
  (cond ((null object-name)
         "/")
        ((dotp object-name)
         (compose-url-path (list (car object-name) (cdr object-name))))
        ((listp object-name)
         (compose-url-path (format nil "~{~A~}" (remove-if #'null object-name))))
        ((stringp object-name)
         (if (emptyp object-name)
             "/"
           object-name))
        (t
         (compose-url-path (format nil "~A" object-name)))
        ))

(defun chomp-null (s)
  (unless (nullp s)
    (string-right-trim +NULL+ s)))


(provide "xl-winhttp/internal/utils")

;;; End
