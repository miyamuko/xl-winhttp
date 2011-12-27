; -*- mode: lisp; package: xl-winhttp.ffi; encoding: shift_jis -*-

;;; xl-winhttp/ffi/winhttp.l
;;
;; /*++
;;
;; Copyright (c) 1995-1999  Microsoft Corporation
;;
;; Module Name:
;;
;;     wininet.h
;;
;; Abstract:
;;
;;     Contains manifests, macros, types and prototypes for Microsoft Windows
;;     Internet Extensions
;;
;; --*/

;;; Code:

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "xl-winhttp/package")
  (require "xl-winhttp/ffi/winapi")
  )

(in-package :xl-winhttp.ffi)

(c:*define INTERNET_MAX_HOST_NAME_LENGTH   256)
(c:*define INTERNET_MAX_USER_NAME_LENGTH   128)
(c:*define INTERNET_MAX_PASSWORD_LENGTH    128)
(c:*define INTERNET_MAX_PORT_NUMBER_LENGTH 5)           ;; INTERNET_PORT is unsigned short
(c:*define INTERNET_MAX_PORT_NUMBER_VALUE  65535)       ;; maximum unsigned short value
(c:*define INTERNET_MAX_PATH_LENGTH        2048)
(c:*define INTERNET_MAX_SCHEME_LENGTH      32)          ;; longest protocol name length
(c:*define INTERNET_MAX_URL_LENGTH         (+ INTERNET_MAX_SCHEME_LENGTH
                                              (length "://")
                                              INTERNET_MAX_PATH_LENGTH))

(provide "xl-winhttp/ffi/wininet")

;;; End
