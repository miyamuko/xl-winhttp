; -*- mode: lisp; package: winhttp; encoding: shift_jis -*-

;;; xl-winhttp/api.l
;;
;; Copyright (c) 2011 MIYAMUKO Katsuyuki.
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
  (require "xl-winhttp/types")
  )

(in-package :winhttp)

(export '(open
          connect
          crack-url
          ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384257(v=VS.85).aspx

(defun open (user-agent &optional access-type proxy-name proxy-bypass flags)
  "http://msdn.microsoft.com/en-us/library/windows/desktop/aa384098(v=VS.85).aspx
HINTERNET WINAPI WinHttpOpen(
  __in_opt  LPCWSTR pwszUserAgent,
  __in      DWORD dwAccessType,
  __in      LPCWSTR pwszProxyName,
  __in      LPCWSTR pwszProxyBypass,
  __in      DWORD dwFlags
);
"
  (wrap-session
   (WinHttpOpen (make-WSTR user-agent)
                (or access-type WINHTTP_ACCESS_TYPE_DEFAULT_PROXY)
                (or proxy-name NULL)
                (or proxy-bypass NULL)
                (or flags 0))))

(defun connect (session server port)
  "http://msdn.microsoft.com/en-us/library/windows/desktop/aa384091(v=VS.85).aspx
HINTERNET WINAPI WinHttpConnect(
  __in        HINTERNET hSession,
  __in        LPCWSTR pswzServerName,
  __in        INTERNET_PORT nServerPort,
  __reserved  DWORD dwReserved
);
"
  (wrap-connection
   (WinHttpConnect (session-handle session) (make-WSTR server) port 0)))

(defun crack-url (url &optional flags)
  "http://msdn.microsoft.com/en-us/library/windows/desktop/aa384092(v=VS.85).aspx
BOOL WINAPI WinHttpCrackUrl(
  __in     LPCWSTR pwszUrl,
  __in     DWORD dwUrlLength,
  __in     DWORD dwFlags,
  __inout  LPURL_COMPONENTS lpUrlComponents
);
"
  (let ((wstr-url (make-WSTR url))
        (components (make-URL_COMPONENTS)))
    (si:clear-chunk components)
    ;; -1 を指定すると lpszXxx は wstr-url のメモリを指す
    (setf (URL_COMPONENTS-dwStructSize components) (c:c-struct-size-of URL_COMPONENTS)
          (URL_COMPONENTS-dwSchemeLength components) -1
          (URL_COMPONENTS-dwUserNameLength components) -1
          (URL_COMPONENTS-dwPasswordLength components) -1
          (URL_COMPONENTS-dwHostNameLength components) -1
          (URL_COMPONENTS-dwUrlPathLength components) -1
          (URL_COMPONENTS-dwExtraInfoLength components) -1
          )
    (assert-BOOL
     (WinHttpCrackUrl wstr-url
                      (WSTR-length wstr-url)
                      (or flags 0)
                      components))
    (values (unpack-WSTR nil (URL_COMPONENTS-lpszScheme components)
                         (URL_COMPONENTS-dwSchemeLength components))
            (unpack-WSTR nil (URL_COMPONENTS-lpszUserName components)
                         (URL_COMPONENTS-dwUserNameLength components))
            (unpack-WSTR nil (URL_COMPONENTS-lpszPassword components)
                         (URL_COMPONENTS-dwPasswordLength components))
            (unpack-WSTR nil (URL_COMPONENTS-lpszHostName components)
                         (URL_COMPONENTS-dwHostNameLength components))
            (URL_COMPONENTS-nPort components)
            (unpack-WSTR nil (URL_COMPONENTS-lpszUrlPath components)
                         (URL_COMPONENTS-dwUrlPathLength components))
            (unpack-WSTR nil (URL_COMPONENTS-lpszExtraInfo components)
                         (URL_COMPONENTS-dwExtraInfoLength components))
            )
    ))


(provide "xl-winhttp/api")

;;; End
