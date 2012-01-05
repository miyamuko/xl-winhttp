; -*- mode: lisp; package: xl-winhttp.ffi; encoding: shift_jis -*-

;;; xl-winhttp/ffi/winapi.l
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
  )

(in-package :xl-winhttp.ffi)

(c:*define NULL 0)

(c:*define-c-type (c:void *) LPCWSTR)
(c:*define-c-type (c:void *) LPCVOID)
(c:*define-c-type (DWORD *) LPDWORD)
(c:*define-c-type (DWORD *) DWORD_PTR)

(c:*define-c-struct SYSTEMTIME
  (WORD wYear)
  (WORD wMonth)
  (WORD wDayOfWeek)
  (WORD wDay)
  (WORD wHour)
  (WORD wMinute)
  (WORD wSecond)
  (WORD wMilliseconds)
  )

(c:*define-dll-entry
  HGLOBAL
  GlobalFree (HGLOBAL)
  "kernel32")

(c:*define-dll-entry
  DWORD
  GetLastError ()
  "kernel32")

(c:*define-dll-entry
  c:size_t
  wcslen ((c:wchar_t *))
  "msvcrt")


(provide "xl-winhttp/ffi/winapi")

;;; End
