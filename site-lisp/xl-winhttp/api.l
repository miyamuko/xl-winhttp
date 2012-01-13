; -*- mode: lisp; package: xl-winhttp; encoding: shift_jis -*-

;;; xl-winhttp/api.l
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
  (require "xl-winhttp/ffi")
  (require "xl-winhttp/types")
  (require "xl-winhttp/conditions")
  (require "xl-winhttp/utils")
  (require "xl-winhttp/flags")
  (require "xl-winhttp/options")
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
          set-timeouts
          read-data
          query-auth-schemes
          query-data-available
          query-request-header
          query-request-headers
          query-response-header
          query-response-headers

          crack-url
          create-url
          check-platform

          create-proxy-resolver
          detect-auto-proxy-config-url
          get-default-proxy-configuration
          get-ieproxy-config-for-current-user
          get-proxy-for-url
          get-proxy-for-url-ex
          reset-auto-proxy
          set-default-proxy-configuration

          time-from-system-time
          time-from-universal-time
          time-to-system-time
          time-to-universal-time

          set-option
          query-option

          set-status-callback
          ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384098.aspx
;; HINTERNET WINAPI WinHttpOpen(
;;   __in_opt  LPCWSTR pwszUserAgent,
;;   __in      DWORD dwAccessType,
;;   __in      LPCWSTR pwszProxyName,
;;   __in      LPCWSTR pwszProxyBypass,
;;   __in      DWORD dwFlags
;; );
(defun open (&key user-agent proxy-name proxy-bypass (access-type :default-proxy)
                  ;; *open-flags*
                  async)
  "Initializes, for an application, the use of WinHTTP functions and returns a WinHTTP-session handle."
  (wrap-session (:description (format nil "~@[~A~]~@[ ~A~]~@[ via ~A~]~@[ bypass ~A~]~@[ with async~]"
                                      (or user-agent "<no user-agent>") access-type proxy-name proxy-bypass async)
                 :async-p async)
   (WinHttpOpen (make-WSTR user-agent)
                (make-flag access-type *access-type* :flags nil)
                (make-WSTR proxy-name :default WINHTTP_NO_PROXY_NAME)
                (make-WSTR proxy-bypass :default WINHTTP_NO_PROXY_BYPASS)
                (expand-flags *open-flags*))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384091.aspx
;; HINTERNET WINAPI WinHttpConnect(
;;   __in        HINTERNET hSession,
;;   __in        LPCWSTR pswzServerName,
;;   __in        INTERNET_PORT nServerPort,
;;   __reserved  DWORD dwReserved
;; );
(defun connect (session server &optional (port INTERNET_DEFAULT_PORT))
  "Specifies the initial target server of an HTTP request and returns
an HINTERNET connection handle to an HTTP session for that initial target."
  (check-valid-handle session session)
  (check-type port port-number)
  (wrap-connection (:description (format nil "~A~@[:~A~]" server (if (= port INTERNET_DEFAULT_PORT) nil port))
                    :async-p (hinternet-async-p session)
                    :parent session)
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
(defun open-request (connection verb object-name &key version referrer accept
                                ;; *open-request-flags*
                                bypass-proxy-cache
                                escape-disable
                                escape-disable-query
                                escape-percent
                                null-codepage
                                refresh
                                secure)
  "Creates an HTTP request handle."
  (check-valid-handle connection connection)

  ;; Note: This string should be all uppercase. Many servers treat HTTP verbs as case-sensitive,
  ;; and the Internet Engineering Task Force (IETF) Requests for Comments (RFCs) spell these
  ;; verbs using uppercase characters only.
  (setf verb (string-upcase (string verb)))
  (when (and accept (atom accept))
    (setf accept (list accept)))
  (multiple-value-bind (&accept chunks)
      (make-WSTR-array accept :default WINHTTP_DEFAULT_ACCEPT_TYPES)
    (gc-guard connection chunks)
    (wrap-request (:description (format nil "~A ~A~@[ with secure~]" verb object-name secure)
                   :secure-p secure
                   :async-p (hinternet-async-p connection)
                   :parent connection)
     (WinHttpOpenRequest (connection-handle connection)
                         (make-WSTR verb)
                         (make-WSTR object-name)
                         (make-WSTR version)
                         (make-WSTR referrer :default WINHTTP_NO_REFERER)
                         &accept
                         (expand-flags *open-request-flags*)))))

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
    (gc-free hinternet)
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
  ;; TODO async
  ;; &data を以下のイベントが発生するまで保持
  ;; - WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE
  ;; - WINHTTP_CALLBACK_STATUS_REQUEST_ERROR
  (check-valid-handle request request)
  (check-type total-length (or null content-length))
  (check-type context (or null integer))
  (let ((&headers (make-WSTR (format-headers headers) :default WINHTTP_NO_ADDITIONAL_HEADERS))
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
  ;; TODO async
  ;; &written に NULL を指定する
  ;; &data を以下のイベントが発生するまで保持
  ;; - WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE
  ;; - WINHTTP_CALLBACK_STATUS_REQUEST_ERROR
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
(defun add-request-headers (request headers &optional (modifiers :add))
  "Adds one or more HTTP request headers to the HTTP request handle."
  (check-valid-handle request request)
  (let ((&headers (make-WSTR (format-headers headers))))
    (assert-BOOL
     (WinHttpAddRequestHeaders (request-handle request)
                               &headers
                               (WSTR-length &headers)
                               (make-flag modifiers *add-request-flags*)))))


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
                          (make-flag auth-targets *auth-target-flags*)
                          (make-flag auth-scheme *auth-scheme-flags*)
                          (make-WSTR username)
                          (make-WSTR password)
                          NULL)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384116.aspx
;; BOOL WINAPI WinHttpSetTimeouts(
;;   __in  HINTERNET hInternet,
;;   __in  int dwResolveTimeout,
;;   __in  int dwConnectTimeout,
;;   __in  int dwSendTimeout,
;;   __in  int dwReceiveTimeout
;; );
(defun set-timeouts (hinternet &key (resolve 0) (connect 60000) (send 30000) (receive 30000))
  "Sets time-outs involved with HTTP transactions."
  (check-valid-handle hinternet (or session request))
  (check-type resolve timeout)
  (check-type connect timeout)
  (check-type send timeout)
  (check-type receive timeout)
  (assert-BOOL
   (WinHttpSetTimeouts (hinternet-handle hinternet) resolve connect send receive)))


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384104.aspx
;; BOOL WINAPI WinHttpReadData(
;;   __in   HINTERNET hRequest,
;;   __out  LPVOID lpBuffer,
;;   __in   DWORD dwNumberOfBytesToRead,
;;   __out  LPDWORD lpdwNumberOfBytesRead
;; );
(defun read-data (request num-of-bytes-to-read)
  "Reads data from a handle opened by the winhttp:open-request function."
  ;; TODO async
  ;; &num-of-bytes-read に NULL を指定する
  ;; &buffer を以下のイベントが発生するまで保持
  ;; - WINHTTP_CALLBACK_STATUS_READ_COMPLETE
  ;; - WINHTTP_CALLBACK_STATUS_REQUEST_ERROR
  (check-valid-handle request request)
  (check-type num-of-bytes-to-read content-length)
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
    (values (unpack-flags (unpack-DWORD &supported-schemes) *auth-scheme-flags*)
            (unpack-flags (unpack-DWORD &first-scheme) *auth-scheme-flags*)
            (unpack-flags (unpack-DWORD &auth-target) *auth-target-flags*))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384101.aspx
;; BOOL WINAPI WinHttpQueryDataAvailable(
;;   __in   HINTERNET hRequest,
;;   __out  LPDWORD lpdwNumberOfBytesAvailable
;; );
(defun query-data-available (request)
  "Returns the amount of data, in bytes, available to be read with winhttp:read-data."
  ;; TODO async
  ;; &num-of-bytes-available に NULL を指定する
  (check-valid-handle request request)
  (let ((&num-of-bytes-available (make-DWORD)))
    (assert-BOOL
     (WinHttpQueryDataAvailable (request-handle request)
                                &num-of-bytes-available))
    (unpack-DWORD &num-of-bytes-available)))

(defun query-request-header (request header &key (type :string) (index 0))
  "Retrieves request header information associated with an HTTP request."
  (query-headers request header :direction :request :type type :index index))

(defun query-request-headers (request header &key (type :string))
  "Retrieves all request header information associated with an HTTP request."
  (query-headers request header :direction :request :type type :all t))

(defun query-response-header (request header &key (type :string) (index 0))
  "Retrieves response header information associated with an HTTP request."
  (query-headers request header :direction :response :type type :index index))

(defun query-response-headers (request header &key (type :string))
  "Retrieves all response header information associated with an HTTP request."
  (query-headers request header :direction :response :type type :all t))

(defun query-headers (request header &key direction all (type :string) (index 0))
  (check-valid-handle request request)
  (check-type header (or integer string symbol))
  (check-type index integer)
  (check-type type (member :string :number :system-time :universal-time))
  (multiple-value-bind (info-level name)
      (cond ((stringp header)
             (values WINHTTP_QUERY_CUSTOM
                     (make-WSTR (string header))))
            (t
             (values (make-flag header *query-type* :flags nil)
                     WINHTTP_HEADER_NAME_BY_INDEX)))
    (let ((flags (logior (ecase type
                           (:number WINHTTP_QUERY_FLAG_NUMBER)
                           (:system-time WINHTTP_QUERY_FLAG_SYSTEMTIME)
                           (:universal-time WINHTTP_QUERY_FLAG_SYSTEMTIME)
                           (:string 0))
                         (ecase direction
                           (:request WINHTTP_QUERY_FLAG_REQUEST_HEADERS)
                           (:response 0))))
          (impl (ecase type
                  (:number #'query-headers-DWORD)
                  (:system-time #'query-headers-SYSTEMTIME)
                  (:universal-time #'query-headers-universal-time)
                  (:string #'query-headers-LPWSTR))))
      (setf info-level (logior info-level flags))
      (flet ((query (index)
               (let ((r (funcall impl request info-level name (make-DWORD index))))
                 ;; (query-response-header ... :type :system-time) の場合は多値で返す
                 (if (and r (listp r) (not all))
                     (values-list r)
                   r))))
        (if all
            (loop for i from 0 below 100
                  for h = (query i)
                  while h
                  collect h)
          (query index))))))

(defun query-headers-DWORD (request info-level &name &index)
  (%query-headers request info-level &name &index
                  (make-DWORD) *size-of-DWORD*
                  #'unpack-DWORD))

(defun query-headers-universal-time (request info-level &name &index)
  (query-headers-SYSTEMTIME request info-level &name &index :universal-time t))

(defun query-headers-SYSTEMTIME (request info-level &name &index &key universal-time)
  (%query-headers request info-level &name &index
                  (make-SYSTEMTIME) (c:c-struct-size-of SYSTEMTIME)
                  #'(lambda (&systime)
                      (let ((u (SYSTEMTIME->universal-time &systime)))
                        (if universal-time
                            u
                          (multiple-value-list (decode-universal-time u)))))))

(defun query-headers-LPWSTR (request info-level &name &index)
  (let ((bytes (%query-headers-buffer-length request info-level &name &index)))
    (when (< 0 bytes)
      (%query-headers request info-level &name &index
                      (make-WSTR-buffer (bytes->WSTR-length bytes)) bytes
                      #'unpack-WSTR))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384102.aspx
;; BOOL WINAPI WinHttpQueryHeaders(
;;   __in      HINTERNET hRequest,
;;   __in      DWORD dwInfoLevel,
;;   __in_opt  LPCWSTR pwszName,
;;   __out     LPVOID lpBuffer,
;;   __inout   LPDWORD lpdwBufferLength,
;;   __inout   LPDWORD lpdwIndex
;; );
(defun %query-headers (request info-level &name &index &buffer buffer-length unpacker)
  (check-chunk &buffer)
  (check-chunk &index)
  (check-type info-level integer)
  (check-type buffer-length integer)
  (let ((&buffer-length (make-DWORD buffer-length)))
    (let ((result (WinHttpQueryHeaders (hinternet-handle request)
                                       info-level &name
                                       &buffer &buffer-length &index)))
      (if (nullp result)
          (unless (= ERROR_WINHTTP_HEADER_NOT_FOUND (get-last-error))
            (raise-winhttp-condition 'WinHttpQueryHeaders))
        (let ((bytes (unpack-DWORD &buffer-length)))
          (when (< 0 bytes)
            (funcall unpacker &buffer)))))))

(defun %query-headers-buffer-length (request info-level &name &index)
  (let ((&buffer-length (make-DWORD)))
    (WinHttpQueryHeaders (hinternet-handle request)
                         info-level &name
                         NULL &buffer-length &index)
    (unpack-DWORD &buffer-length)))


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384092.aspx
;; BOOL WINAPI WinHttpCrackUrl(
;;   __in     LPCWSTR pwszUrl,
;;   __in     DWORD dwUrlLength,
;;   __in     DWORD dwFlags,
;;   __inout  LPURL_COMPONENTS lpUrlComponents
;; );
(defun crack-url (url &key
                      ;; *crack-url-flags*
                      decode
                      escape
                      reject-userpwd)
  "Separates a URL into its component parts such as host name and path."
  (let ((&url (make-WSTR url))
        (&scheme (make-WSTR-buffer INTERNET_MAX_SCHEME_LENGTH))
        (&username (make-WSTR-buffer INTERNET_MAX_USER_NAME_LENGTH))
        (&password (make-WSTR-buffer INTERNET_MAX_PASSWORD_LENGTH))
        (&hostname (make-WSTR-buffer INTERNET_MAX_HOST_NAME_LENGTH))
        (&url-path (make-WSTR-buffer INTERNET_MAX_PATH_LENGTH))
        (&extra-info (make-WSTR-buffer INTERNET_MAX_PATH_LENGTH))
        (&components (make-URL_COMPONENTS)))
    (si:clear-chunk &components)
    ;; ICU_DECODE, ICU_ESCAPE 指定時は呼び出し元でバッファを用意する必要がある
    (setf (URL_COMPONENTS-dwStructSize &components) (c:c-struct-size-of URL_COMPONENTS)
          (URL_COMPONENTS-lpszScheme &components) &scheme
          (URL_COMPONENTS-dwSchemeLength &components) (WSTR-length &scheme)
          (URL_COMPONENTS-lpszUserName &components) &username
          (URL_COMPONENTS-dwUserNameLength &components) (WSTR-length &username)
          (URL_COMPONENTS-lpszPassword &components) &password
          (URL_COMPONENTS-dwPasswordLength &components) (WSTR-length &password)
          (URL_COMPONENTS-lpszHostName &components) &hostname
          (URL_COMPONENTS-dwHostNameLength &components) (WSTR-length &hostname)
          (URL_COMPONENTS-lpszUrlPath &components) &url-path
          (URL_COMPONENTS-dwUrlPathLength &components) (WSTR-length &url-path)
          (URL_COMPONENTS-lpszExtraInfo &components) &extra-info
          (URL_COMPONENTS-dwExtraInfoLength &components) (WSTR-length &extra-info)
          )
    (assert-BOOL
     (WinHttpCrackUrl &url
                      (WSTR-length &url)
                      (expand-flags *crack-url-flags*)
                      &components))
    (values (unpack-WSTR &scheme)
            (unpack-WSTR &username)
            (unpack-WSTR &password)
            (unpack-WSTR &hostname)
            (URL_COMPONENTS-nPort &components)
            (unpack-WSTR &url-path)
            (unpack-WSTR &extra-info)
            )
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384093.aspx
;; BOOL WINAPI WinHttpCreateUrl(
;;   __in     LPURL_COMPONENTS lpUrlComponents,
;;   __in     DWORD dwFlags,
;;   __out    LPWSTR pwszUrl,
;;   __inout  LPDWORD lpdwUrlLength
;; );
(defun create-url (scheme username password hostname port url-path extra-info
                          &key
                          ;; *create-url-flags*
                          escape
                          reject-userpwd)
  "Creates a URL from component parts such as the host name and path."
  (flet ((make-WSTR (str)
           ;; (make-WSTR "") は NULL 文字だけの chunk を返す (WSTR-length は 0)。
           ;; それを WinHttpCreateUrl に渡すとゴミが URL に設定されるので、
           ;; 空文字列の場合は chunk を作成しない。
           (if (equal str "")
               NULL
             (winhttp.ffi:make-WSTR str))))
    (let ((&components (make-URL_COMPONENTS))
          (&username (make-WSTR username))
          (&password (make-WSTR password))
          (&hostname (make-WSTR hostname))
          (&url-path (make-WSTR url-path))
          (&extra-info (make-WSTR extra-info)))
      (si:clear-chunk &components)
      (setf (URL_COMPONENTS-dwStructSize &components) (c:c-struct-size-of URL_COMPONENTS)
            (URL_COMPONENTS-lpszUserName &components) &username
            (URL_COMPONENTS-dwUserNameLength &components) (WSTR-length &username)
            (URL_COMPONENTS-lpszPassword &components) &password
            (URL_COMPONENTS-dwPasswordLength &components) (WSTR-length &password)
            (URL_COMPONENTS-lpszHostName &components) &hostname
            (URL_COMPONENTS-dwHostNameLength &components) (WSTR-length &hostname)
            (URL_COMPONENTS-lpszUrlPath &components) &url-path
            (URL_COMPONENTS-dwUrlPathLength &components) (WSTR-length &url-path)
            (URL_COMPONENTS-lpszExtraInfo &components) &extra-info
            (URL_COMPONENTS-dwExtraInfoLength &components) (WSTR-length &extra-info)
            (URL_COMPONENTS-nPort &components) port
            )
      (etypecase scheme
        (integer
         (setf (URL_COMPONENTS-nScheme &components) scheme))
        (string
         (let ((&scheme (make-WSTR scheme)))
           (setf (URL_COMPONENTS-dwSchemeLength &components) (WSTR-length &scheme)
                 (URL_COMPONENTS-lpszScheme &components) &scheme
                 ))))
      (setf flags (expand-flags *create-url-flags*))
      (let ((&len (make-DWORD)))
        (WinHttpCreateUrl &components flags NULL &len)
        (let ((&buffer (make-WSTR-buffer (unpack-DWORD &len))))
          (assert-BOOL
           (WinHttpCreateUrl &components flags &buffer &len))
          (unpack-WSTR &buffer (unpack-DWORD &len)))))))


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384089.aspx
;; BOOL WinHttpCheckPlatform(void);
(defun check-platform ()
  "Determines whether the current platform is supported by this version of Microsoft Windows HTTP Services (WinHTTP)."
  (assert-BOOL
   (WinHttpCheckPlatform)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/hh405355.aspx
;; DWORD WinHttpCreateProxyResolver(
;;   _In_   HINTERNET hSession,
;;   _Out_  HINTERNET *phResolver
;; );
(defun create-proxy-resolver (session)
  "Creates a handle for use by winhttp:get-proxy-for-url-ex."
  ;; Windows 8 から
  (error "Not implemented"))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384094.aspx
;; BOOL WINAPI WinHttpDetectAutoProxyConfigUrl(
;;   __in   DWORD dwAutoDetectFlags,
;;   __out  LPWSTR *ppwszAutoConfigUrl
;; );
(defun detect-auto-proxy-config-url (&key
                                     ;; *auto-detect-type-flags*
                                     dhcp
                                     dns_a)
  "Finds the URL for the Proxy Auto-Configuration (PAC) file.
This function reports the URL of the PAC file, but it does not download the file."
  (let ((&pointer (make-pointer)))
    (assert-BOOL
     (WinHttpDetectAutoProxyConfigUrl (expand-flags *auto-detect-type-flags*)
                                      &pointer))
    (unpack-WSTR-pointer (unpack-pointer &pointer) nil :free t)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384095.aspx
;; BOOL WINAPI WinHttpGetDefaultProxyConfiguration(
;;   __inout  WINHTTP_PROXY_INFO *pProxyInfo
;; );
(defun get-default-proxy-configuration ()
  "Retrieves the default WinHTTP proxy configuration from the registry."
  (let ((&proxy-info (make-WINHTTP_PROXY_INFO)))
    (si:clear-chunk &proxy-info)
    (assert-BOOL
     (WinHttpGetDefaultProxyConfiguration &proxy-info))
    (unpack-proxy-info &proxy-info)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384096.aspx
;; BOOL WINAPI WinHttpGetIEProxyConfigForCurrentUser(
;;   __inout  WINHTTP_CURRENT_USER_IE_PROXY_CONFIG *pProxyConfig
;; );
(defun get-ieproxy-config-for-current-user ()
  "Retrieves the Internet Explorer proxy configuration for the current user."
  (let ((&proxy-config (make-WINHTTP_CURRENT_USER_IE_PROXY_CONFIG)))
    (si:clear-chunk &proxy-config)
    (assert-BOOL
     (WinHttpGetIEProxyConfigForCurrentUser &proxy-config))
    (values (unpack-WSTR-pointer (WINHTTP_CURRENT_USER_IE_PROXY_CONFIG-lpszProxy &proxy-config) nil :free t)
            (unpack-WSTR-pointer (WINHTTP_CURRENT_USER_IE_PROXY_CONFIG-lpszProxyBypass &proxy-config)  nil :free t)
            (unpack-WSTR-pointer (WINHTTP_CURRENT_USER_IE_PROXY_CONFIG-lpszAutoConfigUrl &proxy-config)  nil :free t)
            (unpack-BOOL (WINHTTP_CURRENT_USER_IE_PROXY_CONFIG-fAutoDetect &proxy-config))
            )))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384097.aspx
;; BOOL WINAPI WinHttpGetProxyForUrl(
;;   __in   HINTERNET hSession,
;;   __in   LPCWSTR lpcwszUrl,
;;   __in   WINHTTP_AUTOPROXY_OPTIONS *pAutoProxyOptions,
;;   __out  WINHTTP_PROXY_INFO *pProxyInfo
;; );
(defun get-proxy-for-url (session url &key
                                  auto-config-url
                                  auto-logon-if-challenged
                                  ;; *auto-proxy-flags*
                                  auto-detect
                                  config-url
                                  run-inprocess
                                  run-outprocess-only
                                  ;; *auto-detect-type-flags*
                                  dhcp
                                  dns_a)
  "Retrieves the proxy data for the specified URL."
  (check-type session session)
  (check-type url string)
  (check-type auto-config-url string)
  (let ((&auto-proxy-opts (make-WINHTTP_AUTOPROXY_OPTIONS))
        (&proxy-info (make-WINHTTP_PROXY_INFO))
        (&url (make-WSTR url))
        (&auto-config-url (make-WSTR auto-config-url)))
    (si:clear-chunk &auto-proxy-opts)
    (si:clear-chunk &proxy-info)
    (setf (WINHTTP_AUTOPROXY_OPTIONS-dwFlags &auto-proxy-opts) (expand-flags *auto-proxy-flags*)
          (WINHTTP_AUTOPROXY_OPTIONS-dwAutoDetectFlags &auto-proxy-opts) (expand-flags *auto-detect-type-flags*)
          (WINHTTP_AUTOPROXY_OPTIONS-lpszAutoConfigUrl &auto-proxy-opts) &auto-config-url
          (WINHTTP_AUTOPROXY_OPTIONS-fAutoLogonIfChallenged &auto-proxy-opts) (pack-BOOL auto-logon-if-challenged)
          )
    (assert-BOOL
     (WinHttpGetProxyForUrl (session-handle session)
                            &url
                            &auto-proxy-opts
                            &proxy-info))
    (unpack-proxy-info &proxy-info)))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/hh405356.aspx
;; DWORD WINHTTPAPI WinHttpGetProxyForUrlEx(
;;   _In_      HINTERNET hResolver,
;;   _In_      PCWSTR pcwszUrl,
;;   _In_opt_  PCWSTR pcwszHost,
;;   _In_opt_  PCWSTR pcwszPath,
;;   _In_opt_  INTERNET_SCHEME isScheme,
;;   _In_opt_  INTERNET_PORT ipPort,
;;   _In_      WINHTTP_AUTOPROXY_OPTIONS *pAutoProxyOptions,
;;   _In_      DWORD_PTR pContext
;; );
(defun get-proxy-for-url-ex (resolver url)
  "Retrieves the proxy data for the specified URL."
  ;; Windows 8 から
  (error "Not implemented"))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/hh405357.aspx
;; DWORD WinHttpResetAutoProxy(
;;   _In_  HINTERNET hSession,
;;   _In_  DWORD dwFlags
;; );
(defun reset-auto-proxy (session &key flags)
  "Resets the auto-proxy."
  ;; Windows 8 から
  (error "Not implemented"))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384113.aspx
;; BOOL WINAPI WinHttpSetDefaultProxyConfiguration(
;;   __in  WINHTTP_PROXY_INFO *pProxyInfo
;; );
(defun set-default-proxy-configuration (&key proxy-name proxy-bypass (access-type :default-proxy))
  "Sets the default WinHTTP proxy configuration in the registry."
  (let ((&proxy-info (make-WINHTTP_PROXY_INFO))
        (&proxy-name (make-WSTR proxy-name :default WINHTTP_NO_PROXY_NAME))
        (&proxy-bypass (make-WSTR proxy-bypass :default WINHTTP_NO_PROXY_BYPASS)))
    (unless access-type
      (setf access-type (if (equal &proxy-name WINHTTP_NO_PROXY_NAME)
                            ;; MSDN にはプロキシを指定しない場合は、WINHTTP_ACCESS_TYPE_DEFAULT_PROXY
                            ;; を指定しろと書いてあるが NO_PROXY じゃないとエラーになる
                            WINHTTP_ACCESS_TYPE_NO_PROXY
                          WINHTTP_ACCESS_TYPE_NAMED_PROXY)))
    (si:clear-chunk &proxy-info)
    (setf (WINHTTP_PROXY_INFO-lpszProxy &proxy-info) &proxy-name
          (WINHTTP_PROXY_INFO-lpszProxyBypass &proxy-info) &proxy-bypass
          (WINHTTP_PROXY_INFO-dwAccessType &proxy-info) (make-flag access-type *access-type* :flags nil)
          )
    (assert-BOOL
     (WinHttpSetDefaultProxyConfiguration &proxy-info))))


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384117.aspx
;; BOOL WINAPI WinHttpTimeFromSystemTime(
;;   __in   const SYSTEMTIME *pst,
;;   __out  LPWSTR pwszTime
;; );
(defun time-from-system-time (second minute hour day month year &optional time-zone)
  "Formats a decoded time according to the HTTP version 1.0 specification."
  (time-from-universal-time (encode-universal-time second minute hour day month year time-zone)))

(defun time-from-universal-time (universal-time)
  "Formats a universal-time according to the HTTP version 1.0 specification."
  (check-type universal-time integer)
  (multiple-value-bind (second minute hour date month year day-of-week daylight-p zone)
      (decode-universal-time universal-time 0)
    (let ((&systime (make-SYSTEMTIME))
          (&time (make-WSTR-buffer (bytes->WSTR-length WINHTTP_TIME_FORMAT_BUFSIZE))))
      (si:clear-chunk &systime)
      (setf (SYSTEMTIME-wYear &systime) year
            (SYSTEMTIME-wMonth &systime) month
            (SYSTEMTIME-wDay &systime) date
            (SYSTEMTIME-wHour &systime) hour
            (SYSTEMTIME-wMinute &systime) minute
            (SYSTEMTIME-wSecond &systime) second
            )
      (assert-BOOL
       (WinHttpTimeFromSystemTime &systime &time))
      (unpack-WSTR &time))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384118.aspx
;; BOOL WINAPI WinHttpTimeToSystemTime(
;;   __in   LPCWSTR pwszTime,
;;   __out  SYSTEMTIME *pst
;; );
(defun time-to-system-time (time &optional time-zone)
  "Takes an HTTP time/date string and converts it to a decoded time."
  (decode-universal-time (time-to-universal-time time) time-zone))

(defun time-to-universal-time (time)
  "Takes an HTTP time/date string and converts it to a universal-time."
  (check-type time string)
  (let ((&systime (make-SYSTEMTIME)))
    (si:clear-chunk &systime)
    (assert-BOOL
     (WinHttpTimeToSystemTime (make-WSTR time) &systime))
    (SYSTEMTIME->universal-time &systime)))

(defun SYSTEMTIME->universal-time (&systime)
  (encode-universal-time (SYSTEMTIME-wSecond &systime)
                         (SYSTEMTIME-wMinute &systime)
                         (SYSTEMTIME-wHour &systime)
                         (SYSTEMTIME-wDay &systime)
                         (SYSTEMTIME-wMonth &systime)
                         (SYSTEMTIME-wYear &systime)
                         0))


(defun set-option (hinternet option value)
  "Sets an Internet option."
  (dispatch-option-handler :set-option hinternet option value))

(defun query-option (hinternet option)
  "Queries an Internet option on the specified handle."
  (dispatch-option-handler :query-option hinternet option))

(defun dispatch-option-handler (operation hinternet option &rest args)
  (let ((option (find-option option)))
    (check-option operation hinternet option)
    (let ((impl (intern (format nil "~A-~A~@[-~A~]"
                                operation
                                (option-data-type option)
                                (option-data-subtype option))
                        :winhttp)))
      (unless (fboundp impl)
        (error "Not implemented: ~S: ~S" impl option))
      (apply impl
             ;; WINHTTP_OPTION_ENABLETRACING など、ハンドルを指定しなくてもいいオプションがある
             (if hinternet (hinternet-handle hinternet) NULL)
             option
             args))))


;;; set-option handler

(defun set-option-BOOL (hinternet-handle option value)
  (set-option-DWORD hinternet-handle option (pack-BOOL value)))

(defun set-option-DWORD-type (hinternet-handle option value)
  (set-option-DWORD-flags hinternet-handle option value :flags nil))

(defun set-option-DWORD-flags (hinternet-handle option value &key (flags t))
  (set-option-DWORD hinternet-handle option
                    (make-flag value (option-data-flags-alist option)
                               :flags flags)))

(defun set-option-DWORD (hinternet-handle option value)
  (check-type value integer)
  (let ((&value (make-DWORD value)))
    (%set-option hinternet-handle option &value *size-of-DWORD*)))

(defun set-option-LPWSTR (hinternet-handle option value)
  (check-type value string)
  (let ((&value (make-WSTR value)))
    (%set-option hinternet-handle option &value (WSTR-length &value))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384114.aspx
;; BOOL WINAPI WinHttpSetOption(
;;   __in  HINTERNET hInternet,
;;   __in  DWORD dwOption,
;;   __in  LPVOID lpBuffer,
;;   __in  DWORD dwBufferLength
;; );
(defun %set-option (hinternet-handle option &buffer buffer-length)
  (check-chunk &buffer)
  (check-type buffer-length integer)
  (assert-BOOL
   (WinHttpSetOption hinternet-handle (option-const option) &buffer buffer-length)))

;; Not implemented option types.
;;   BOOL
;;   CERT_CONTEXT
;;   DWORD_PTR
;;   HTTP_VERSION_INFO
;;   LPVOID
;;   WINHTTP_CREDS
;;   WINHTTP_CREDS_EX
;;   WINHTTP_PROXY_INFO


;;; query-option handler

(defun query-option-BOOL (hinternet-handle option)
  (unpack-BOOL
   (query-option-DWORD hinternet-handle option)))

(defun query-option-DWORD-type (hinternet-handle option)
  (query-option-DWORD-flags hinternet-handle option :flags nil))

(defun query-option-DWORD-flags (hinternet-handle option &key (flags t))
  (unpack-flags (query-option-DWORD hinternet-handle option)
                (option-data-flags-alist option)
                :flags flags))

(defun query-option-DWORD (hinternet-handle option)
  (%query-option hinternet-handle option
                 (make-DWORD) *size-of-DWORD*
                 #'unpack-DWORD))

(defun query-option-LPWSTR (hinternet-handle option)
  (let ((bytes (%option-buffer-length hinternet-handle option)))
    (when (< 0 bytes)
      (%query-option hinternet-handle option
                     (make-WSTR-buffer (bytes->WSTR-length bytes)) bytes
                     #'unpack-WSTR))))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384103.aspx
;; BOOL WINAPI WinHttpQueryOption(
;;   __in     HINTERNET hInternet,
;;   __in     DWORD dwOption,
;;   __out    LPVOID lpBuffer,
;;   __inout  LPDWORD lpdwBufferLength
;; );
(defun %query-option (hinternet-handle option &buffer buffer-length unpacker)
  (check-chunk &buffer)
  (check-type buffer-length integer)
  (let ((&buffer-length (make-DWORD buffer-length)))
    (assert-BOOL
     (WinHttpQueryOption hinternet-handle (option-const option) &buffer &buffer-length))
    (let ((bytes (unpack-DWORD &buffer-length)))
      (when (< 0 bytes)
        (funcall unpacker &buffer)))))

(defun %option-buffer-length (hinternet-handle option)
  (let ((&buffer-length (make-DWORD)))
    (WinHttpQueryOption hinternet-handle (option-const option) NULL &buffer-length)
    (unpack-DWORD &buffer-length)))

;; Not implemented option types.
;;   CERT_CONTEXT
;;   DWORD_PTR
;;   HINTERNET
;;   HTTP_VERSION_INFO
;;   LPVOID
;;   SecPkgContext_IssuerListInfoEx*
;;   WINHTTP_CERTIFICATE_INFO
;;   WINHTTP_PROXY_INFO


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384115.aspx
;; WINHTTP_STATUS_CALLBACK WINAPI WinHttpSetStatusCallback(
;;   __in        HINTERNET hInternet,
;;   __in        WINHTTP_STATUS_CALLBACK lpfnInternetCallback,
;;   __in        DWORD dwNotificationFlags,
;;   __reserved  DWORD_PTR dwReserved
;; );
(defun set-status-callback (hinternet callback
                                      &key
                                      ;; *notification-flags*
                                      all-completions
                                      all-notifications
                                      resolve-name
                                      connect-to-server
                                      detecting-proxy
                                      data-available
                                      headers-available
                                      read-complete
                                      request-error
                                      send-request
                                      send-request-complete
                                      write-complete
                                      receive-response
                                      close-connection
                                      handles
                                      redirect
                                      intermediate-response
                                      secure-failure)
  (check-valid-handle hinternet (or session connection request))
  (check-type callback function-address)
  (WinHttpSetStatusCallback (hinternet-handle hinternet)
                            callback
                            (expand-flags *notification-flags*
                                          :default WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS)
                            0))

;;; private

(defun unpack-proxy-info (proxy-info)
  (values (unpack-WSTR-pointer (WINHTTP_PROXY_INFO-lpszProxy proxy-info) nil :free t)
          (unpack-WSTR-pointer (WINHTTP_PROXY_INFO-lpszProxyBypass proxy-info) nil :free t)
          (unpack-flags (WINHTTP_PROXY_INFO-dwAccessType proxy-info) *access-type* :flags nil)
          ))


(provide "xl-winhttp/api")

;;; End
