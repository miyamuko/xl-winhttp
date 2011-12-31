; -*- mode: lisp; package: xl-winhttp; encoding: shift_jis -*-

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

(in-package :xl-winhttp)

(export '(open
          connect
          open-request
          close-handle
          send-request
          write-data
          receive-response
          add-request-headers
          set-credentials
          read-data
          query-auth-schemes
          query-data-available
          query-headers
          crack-url

          with-open
          with-connect
          with-open-request
          ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384098.aspx
;; HINTERNET WINAPI WinHttpOpen(
;;   __in_opt  LPCWSTR pwszUserAgent,
;;   __in      DWORD dwAccessType,
;;   __in      LPCWSTR pwszProxyName,
;;   __in      LPCWSTR pwszProxyBypass,
;;   __in      DWORD dwFlags
;; );
(defun open (user-agent &key access-type proxy-name proxy-bypass flags)
  "Initializes, for an application, the use of WinHTTP functions and returns a WinHTTP-session handle."
  (wrap-session
   (WinHttpOpen (make-WSTR user-agent)
                (or access-type WINHTTP_ACCESS_TYPE_DEFAULT_PROXY)
                (make-WSTR proxy-name :default WINHTTP_NO_PROXY_NAME)
                (make-WSTR proxy-bypass :default WINHTTP_NO_PROXY_BYPASS)
                (or flags 0))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384091.aspx
;; HINTERNET WINAPI WinHttpConnect(
;;   __in        HINTERNET hSession,
;;   __in        LPCWSTR pswzServerName,
;;   __in        INTERNET_PORT nServerPort,
;;   __reserved  DWORD dwReserved
;; );
(defun connect (session server port)
  "Specifies the initial target server of an HTTP request and returns
an HINTERNET connection handle to an HTTP session for that initial target."
  (check-valid-handle session session)
  (wrap-connection
   (WinHttpConnect (session-handle session)
                   (make-WSTR server)
                   port
                   0)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384099.aspx
;; HINTERNET WINAPI WinHttpOpenRequest(
;;   __in  HINTERNET hConnect,
;;   __in  LPCWSTR pwszVerb,
;;   __in  LPCWSTR pwszObjectName,
;;   __in  LPCWSTR pwszVersion,
;;   __in  LPCWSTR pwszReferrer,
;;   __in  LPCWSTR *ppwszAcceptTypes,
;;   __in  DWORD dwFlags
;; );
(defun open-request (connection verb object-name &key version referrer accept-types flags)
  "Creates an HTTP request handle."
  (check-valid-handle connection connection)
  (wrap-request
   (WinHttpOpenRequest (connection-handle connection)
                       (make-WSTR verb)
                       (make-WSTR object-name)
                       (make-WSTR version)
                       (make-WSTR referrer :default WINHTTP_NO_REFERER)
                       (make-WSTR-array accept-types :default WINHTTP_DEFAULT_ACCEPT_TYPES)
                       (or flags 0))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384090.aspx
;; BOOL WINAPI WinHttpCloseHandle(
;;   __in  HINTERNET hInternet
;; );
(defun close-handle (hinternet)
  "Closes a single HINTERNET handle."
  ;; close しているかどうかのチェックはしないので check-valid-handle は呼ばない
  (check-type hinternet hinternet)
  (unless (hinternet-closed-p hinternet)
    (assert-BOOL
     (WinHttpCloseHandle (hinternet-handle hinternet)))
    (gc-free (hinternet-handle hinternet))
    (setf (hinternet-closed-p hinternet) t)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384110.aspx
;; BOOL WINAPI WinHttpSendRequest(
;;   __in      HINTERNET hRequest,
;;   __in_opt  LPCWSTR pwszHeaders,
;;   __in      DWORD dwHeadersLength,
;;   __in_opt  LPVOID lpOptional,
;;   __in      DWORD dwOptionalLength,
;;   __in      DWORD dwTotalLength,
;;   __in      DWORD_PTR dwContext
;; );
(defun send-request (request &key data headers total-length context)
  "Sends the specified request to the HTTP server."
  (check-valid-handle request request)
  (let ((&headers (make-WSTR headers :default WINHTTP_NO_ADDITIONAL_HEADERS))
        (&data (make-CSTR data :default WINHTTP_NO_REQUEST_DATA)))
    (assert-BOOL
     (WinHttpSendRequest (request-handle request)
                         &headers
                         (WSTR-length &headers)
                         &data
                         (CSTR-length &data)
                         (or total-length (CSTR-length &data))
                         (or context NULL)))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384120.aspx
;; BOOL WINAPI WinHttpWriteData(
;;   __in   HINTERNET hRequest,
;;   __in   LPCVOID lpBuffer,
;;   __in   DWORD dwNumberOfBytesToWrite,
;;   __out  LPDWORD lpdwNumberOfBytesWritten
;; );
(defun write-data (request data)
  "Writes request data to an HTTP server."
  (check-valid-handle request request)
  (let ((&written (make-DWORD))
        (&data (make-CSTR data)))
    (assert-BOOL
     (WinHttpWriteData (request-handle request)
                       &data
                       (CSTR-length &data)
                       &written))
    (unpack-DWORD &written)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384105.aspx
;; BOOL WINAPI WinHttpReceiveResponse(
;;   __in        HINTERNET hRequest,
;;   __reserved  LPVOID lpReserved
;; );
(defun receive-response (request)
  "Waits to receive the response to an HTTP request initiated by winhttp:send-request.
When winhttp:receive-response completes successfully, the status code and
response headers have been received and are available for the application to
inspect using winhttp:query-headers.

An application must call winhttp:receive-response before it can use
winhttp:query-data-available and winhttp:read-data to access the response
entity body (if any)."
  (check-valid-handle request request)
  (assert-BOOL
   (WinHttpReceiveResponse (request-handle request) NULL)))


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384087.aspx
;; BOOL WINAPI WinHttpAddRequestHeaders(
;;   __in  HINTERNET hRequest,
;;   __in  LPCWSTR pwszHeaders,
;;   __in  DWORD dwHeadersLength,
;;   __in  DWORD dwModifiers
;; );
(defun add-request-headers (request headers &key (modifiers WINHTTP_ADDREQ_FLAG_ADD))
  "Adds one or more HTTP request headers to the HTTP request handle."
  (check-valid-handle request request)
  (check-type headers string)
  (let ((headers (make-WSTR headers)))
    (assert-BOOL
     (WinHttpAddRequestHeaders (request-handle request)
                               headers
                               (WSTR-length headers)
                               modifiers))))


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384112.aspx
;; BOOL WINAPI WinHttpSetCredentials(
;;   __in        HINTERNET hRequest,
;;   __in        DWORD AuthTargets,
;;   __in        DWORD AuthScheme,
;;   __in        LPCWSTR pwszUserName,
;;   __in        LPCWSTR pwszPassword,
;;   __reserved  LPVOID pAuthParams
;; );
(defun set-credentials (request auth-targets auth-scheme username password)
  "Passes the required authorization credentials to the server."
  (check-valid-handle request request)
  (assert-BOOL
   (WinHttpSetCredentials (request-handle request)
                          auth-targets
                          auth-scheme
                          (make-WSTR username)
                          (make-WSTR password)
                          NULL)))


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384104.aspx
;; BOOL WINAPI WinHttpReadData(
;;   __in   HINTERNET hRequest,
;;   __out  LPVOID lpBuffer,
;;   __in   DWORD dwNumberOfBytesToRead,
;;   __out  LPDWORD lpdwNumberOfBytesRead
;; );
(defun read-data (request num-of-bytes-to-read)
  "Reads data from a handle opened by the winhttp:open-request function."
  (check-valid-handle request request)
  (let ((&buffer (make-CSTR-buffer num-of-bytes-to-read))
        (&num-of-bytes-read (make-DWORD)))
    (assert-BOOL
     (WinHttpReadData (request-handle request)
                      &buffer
                      num-of-bytes-to-read
                      &num-of-bytes-read))
    (let ((bytes (unpack-DWORD &num-of-bytes-read)))
      (values (unpack-CSTR &buffer bytes)
              bytes))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384100.aspx
;; BOOL WINAPI WinHttpQueryAuthSchemes(
;;   __in   HINTERNET hRequest,
;;   __out  LPDWORD lpdwSupportedSchemes,
;;   __out  LPDWORD lpdwFirstScheme,
;;   __out  LPDWORD pdwAuthTarget
;; );
(defun query-auth-schemes (request)
  "Returns the authorization schemes that are supported by the server."
  (check-valid-handle request request)
  (let ((&supported-schemes (make-DWORD))
        (&first-scheme (make-DWORD))
        (&auth-target (make-DWORD)))
    (assert-BOOL
     (WinHttpQueryAuthSchemes (request-handle request)
                              &supported-schemes
                              &first-scheme
                              &auth-target))
    (values (unpack-DWORD &supported-schemes)
            (unpack-DWORD &first-scheme)
            (unpack-DWORD &auth-target))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384101.aspx
;; BOOL WINAPI WinHttpQueryDataAvailable(
;;   __in   HINTERNET hRequest,
;;   __out  LPDWORD lpdwNumberOfBytesAvailable
;; );
(defun query-data-available (request)
  "Returns the amount of data, in bytes, available to be read with winhttp:read-data."
  (check-valid-handle request request)
  (let ((&num-of-bytes-available (make-DWORD)))
    (assert-BOOL
     (WinHttpQueryDataAvailable (request-handle request)
                                &num-of-bytes-available))
    (unpack-DWORD &num-of-bytes-available)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384102.aspx
;; BOOL WINAPI WinHttpQueryHeaders(
;;   __in      HINTERNET hRequest,
;;   __in      DWORD dwInfoLevel,
;;   __in_opt  LPCWSTR pwszName,
;;   __out     LPVOID lpBuffer,
;;   __inout   LPDWORD lpdwBufferLength,
;;   __inout   LPDWORD lpdwIndex
;; );
(defun query-headers (request header &key (index WINHTTP_NO_HEADER_INDEX))
  "Retrieves header information associated with an HTTP request."
  (check-valid-handle request request)
  (check-type header (or integer string symbol))
  (check-type index integer)
  (multiple-value-bind (info-level name)
      (cond ((integerp header)
             (values header WINHTTP_HEADER_NAME_BY_INDEX))
            (t
             (values WINHTTP_QUERY_CUSTOM (make-WSTR (string header)))))
    (let ((&buffer-length (make-DWORD))
          (&header-index (make-DWORD index)))
      (let ((bytes (progn
                     ;; ヘッダを格納するバッファサイズを取得 (最後の NULL 文字分を含む)。
                     ;; &header-index には次のヘッダのインデックスはセットされない。
                     (WinHttpQueryHeaders (request-handle request)
                                          info-level name
                                          NULL &buffer-length
                                          &header-index)
                     (unpack-DWORD &buffer-length))))
        (when (< 0 bytes)
          (let ((&buffer (make-CSTR-buffer bytes)))
            (assert-BOOL
             (WinHttpQueryHeaders (request-handle request)
                                  info-level name
                                  &buffer &buffer-length
                                  &header-index))
            ;; NULL 文字を含まないサイズが返ってくる。
            (setf bytes (unpack-DWORD &buffer-length))
            ;; lpBuffer は WSTR だが lpdwBufferLength はバイト数で返ってくるので、
            ;; CSTR のまま操作して最後に WSTR に変換する。
            (convert-WSTR-to-internal (unpack-CSTR &buffer bytes)))
          )))))


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384092.aspx
;; BOOL WINAPI WinHttpCrackUrl(
;;   __in     LPCWSTR pwszUrl,
;;   __in     DWORD dwUrlLength,
;;   __in     DWORD dwFlags,
;;   __inout  LPURL_COMPONENTS lpUrlComponents
;; );
(defun crack-url (url &key flags)
  "Separates a URL into its component parts such as host name and path."
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
    (values (unpack-WSTR-pointer (URL_COMPONENTS-lpszScheme components)
                                 (URL_COMPONENTS-dwSchemeLength components))
            (unpack-WSTR-pointer (URL_COMPONENTS-lpszUserName components)
                                 (URL_COMPONENTS-dwUserNameLength components))
            (unpack-WSTR-pointer (URL_COMPONENTS-lpszPassword components)
                                 (URL_COMPONENTS-dwPasswordLength components))
            (unpack-WSTR-pointer (URL_COMPONENTS-lpszHostName components)
                                 (URL_COMPONENTS-dwHostNameLength components))
            (URL_COMPONENTS-nPort components)
            (unpack-WSTR-pointer (URL_COMPONENTS-lpszUrlPath components)
                                 (URL_COMPONENTS-dwUrlPathLength components))
            (unpack-WSTR-pointer (URL_COMPONENTS-lpszExtraInfo components)
                                 (URL_COMPONENTS-dwExtraInfoLength components))
            )
    ))


(defmacro define-with-macro (init-func)
  (let ((name (intern (format nil "with-~A" init-func))))
    `(progn
       (defmacro ,name ((var &rest args) &body body)
         `(let ((,var (,',init-func ,@args)))
            (unwind-protect
                (progn ,@body)
              (close-handle ,var))))
       (setf (get ',name 'ed:lisp-indent-hook) 1))))

(define-with-macro open)
(define-with-macro connect)
(define-with-macro open-request)


(provide "xl-winhttp/api")

;;; End
