; -*- mode: lisp; package: xl-winhttp.ffi; encoding: shift_jis -*-

;;; xl-winhttp/ffi/winhttp.l
;;
;; /*++
;;
;; Copyright (c) Microsoft Corporation. All rights reserved.
;;
;; Module Name:
;;
;;     winhttp.h
;;
;; Abstract:
;;
;;     Contains manifests, macros, types and prototypes for Windows HTTP Services
;;
;; --*/

;;; Code:

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "xl-winhttp/package")
  (require "xl-winhttp/ffi/winapi")
  )

(in-package :winhttp.ffi)

(defparameter *winhttp-dll* "winhttp.dll")


(c:*define-c-type LPVOID HINTERNET)
(c:*define-c-type (HINTERNET *) LPHINTERNET)

(c:*define-c-type WORD INTERNET_PORT)
(c:*define-c-type (INTERNET_PORT *) LPINTERNET_PORT)

;;
;; manifests
;;

(c:*define INTERNET_DEFAULT_PORT           0)           ;; use the protocol-specific default
(c:*define INTERNET_DEFAULT_HTTP_PORT      80)          ;;    "     "  HTTP   "
(c:*define INTERNET_DEFAULT_HTTPS_PORT     443)         ;;    "     "  HTTPS  "

;; flags for WinHttpOpen():
(c:*define WINHTTP_FLAG_ASYNC              #x10000000)  ;; this session is asynchronous (where supported)

;; flags for WinHttpOpenRequest():
(c:*define WINHTTP_FLAG_SECURE                #x00800000)  ;; use SSL if applicable (HTTPS)
(c:*define WINHTTP_FLAG_ESCAPE_PERCENT        #x00000004)  ;; if escaping enabled, escape percent as well
(c:*define WINHTTP_FLAG_NULL_CODEPAGE         #x00000008)  ;; assume all symbols are ASCII, use fast convertion
(c:*define WINHTTP_FLAG_BYPASS_PROXY_CACHE    #x00000100) ;; add "pragma: no-cache" request header
(c:*define WINHTTP_FLAG_REFRESH               WINHTTP_FLAG_BYPASS_PROXY_CACHE)
(c:*define WINHTTP_FLAG_ESCAPE_DISABLE        #x00000040)  ;; disable escaping
(c:*define WINHTTP_FLAG_ESCAPE_DISABLE_QUERY  #x00000080)  ;; if escaping enabled escape path part, but do not escape query


(c:*define SECURITY_FLAG_IGNORE_UNKNOWN_CA         #x00000100)
(c:*define SECURITY_FLAG_IGNORE_CERT_DATE_INVALID  #x00002000) ;; expired X509 Cert.
(c:*define SECURITY_FLAG_IGNORE_CERT_CN_INVALID    #x00001000) ;; bad common name in X509 Cert.
(c:*define SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE   #x00000200)


;;
;; WINHTTP_ASYNC_RESULT - this structure is returned to the application via
;; the callback with WINHTTP_CALLBACK_STATUS_REQUEST_COMPLETE. It is not sufficient to
;; just return the result of the async operation. If the API failed then the
;; app cannot call GetLastError() because the thread context will be incorrect.
;; Both the value returned by the async API and any resultant error code are
;; made available. The app need not check dwError if dwResult indicates that
;; the API succeeded (in this case dwError will be ERROR_SUCCESS)
;;

(c:*define-c-struct WINHTTP_ASYNC_RESULT
  (DWORD_PTR dwResult)  ;; indicates which async API has encountered an error
  (DWORD dwError)       ;; the error code if the API failed
  )
(c:*define-c-type (WINHTTP_ASYNC_RESULT *) LPWINHTTP_ASYNC_RESULT)

;;
;; HTTP_VERSION_INFO - query or set global HTTP version (1.0 or 1.1)
;;

(c:*define-c-struct HTTP_VERSION_INFO
  (DWORD dwMajorVersion)
  (DWORD dwMinorVersion)
  )
(c:*define-c-type (HTTP_VERSION_INFO *) LPHTTP_VERSION_INFO)

;;
;; INTERNET_SCHEME - URL scheme type
;;

(c:*define-c-type c:int INTERNET_SCHEME)
(c:*define-c-type (INTERNET_SCHEME *) LPINTERNET_SCHEME)

(c:*define INTERNET_SCHEME_HTTP        1)
(c:*define INTERNET_SCHEME_HTTPS       2)


;;
;; URL_COMPONENTS - the constituent parts of an URL. Used in WinHttpCrackUrl()
;; and WinHttpCreateUrl()
;;
;; For WinHttpCrackUrl(), if a pointer field and its corresponding length field
;; are both 0 then that component is not returned. If the pointer field is NULL
;; but the length field is not zero, then both the pointer and length fields are
;; returned if both pointer and corresponding length fields are non-zero then
;; the pointer field points to a buffer where the component is copied. The
;; component may be un-escaped, depending on dwFlags
;;
;; For WinHttpCreateUrl(), the pointer fields should be NULL if the component
;; is not required. If the corresponding length field is zero then the pointer
;; field is the address of a zero-terminated string. If the length field is not
;; zero then it is the string length of the corresponding pointer field
;;

;; #pragma warning( disable : 4121 )   ;; disable alignment warning

(c:*define-c-struct URL_COMPONENTS
  (DWORD   dwStructSize)       ;; size of this structure. Used in version check
  (LPWSTR  lpszScheme)         ;; pointer to scheme name
  (DWORD   dwSchemeLength)     ;; length of scheme name
  (INTERNET_SCHEME nScheme)    ;; enumerated scheme type (if known)
  (LPWSTR  lpszHostName)       ;; pointer to host name
  (DWORD   dwHostNameLength)   ;; length of host name
  (INTERNET_PORT nPort)        ;; converted port number
  (LPWSTR  lpszUserName)       ;; pointer to user name
  (DWORD   dwUserNameLength)   ;; length of user name
  (LPWSTR  lpszPassword)       ;; pointer to password
  (DWORD   dwPasswordLength)   ;; length of password
  (LPWSTR  lpszUrlPath)        ;; pointer to URL-path
  (DWORD   dwUrlPathLength)    ;; length of URL-path
  (LPWSTR  lpszExtraInfo)      ;; pointer to extra information (e.g. ?foo or #foo)
  (DWORD   dwExtraInfoLength)  ;; length of extra information
  )
(c:*define-c-type (URL_COMPONENTS *) LPURL_COMPONENTS)

; (c:*define-c-type URL_COMPONENTS URL_COMPONENTSW)
; (c:*define-c-type LPURL_COMPONENTS LPURL_COMPONENTSW)

;; #pragma warning( default : 4121 )   ;; restore alignment warning

;;
;; WINHTTP_PROXY_INFO - structure supplied with WINHTTP_OPTION_PROXY to get/
;; set proxy information on a WinHttpOpen() handle
;;

(c:*define-c-struct WINHTTP_PROXY_INFO
  (DWORD  dwAccessType)      ;; see WINHTTP_ACCESS_* types below
  (LPWSTR lpszProxy)         ;; proxy server list
  (LPWSTR lpszProxyBypass)   ;; proxy bypass list
  )
(c:*define-c-type (WINHTTP_PROXY_INFO *) LPWINHTTP_PROXY_INFO)

; (c:*define-c-type WINHTTP_PROXY_INFO WINHTTP_PROXY_INFOW)
; (c:*define-c-type LPWINHTTP_PROXY_INFO LPWINHTTP_PROXY_INFOW)


(c:*define-c-struct WINHTTP_AUTOPROXY_OPTIONS
  (DWORD   dwFlags)
  (DWORD   dwAutoDetectFlags)
  (LPCWSTR lpszAutoConfigUrl)
  (LPVOID  lpvReserved)
  (DWORD   dwReserved)
  (BOOL    fAutoLogonIfChallenged)
  )


(c:*define WINHTTP_AUTOPROXY_AUTO_DETECT           #x00000001)
(c:*define WINHTTP_AUTOPROXY_CONFIG_URL            #x00000002)
(c:*define WINHTTP_AUTOPROXY_RUN_INPROCESS         #x00010000)
(c:*define WINHTTP_AUTOPROXY_RUN_OUTPROCESS_ONLY   #x00020000)
;;
;; Flags for dwAutoDetectFlags
;;
(c:*define WINHTTP_AUTO_DETECT_TYPE_DHCP           #x00000001)
(c:*define WINHTTP_AUTO_DETECT_TYPE_DNS_A          #x00000002)


;;
;; WINHTTP_CERTIFICATE_INFO lpBuffer - contains the certificate returned from
;; the server
;;

(c:*define-c-struct WINHTTP_CERTIFICATE_INFO
  ;;
  ;; ftExpiry - date the certificate expires.
  ;;

  (FILETIME ftExpiry)

  ;;
  ;; ftStart - date the certificate becomes valid.
  ;;

  (FILETIME ftStart)

  ;;
  ;; lpszSubjectInfo - the name of organization, site, and server
  ;;   the cert. was issued for.
  ;;

  (LPWSTR lpszSubjectInfo)

  ;;
  ;; lpszIssuerInfo - the name of orgainzation, site, and server
  ;;   the cert was issues by.
  ;;

  (LPWSTR lpszIssuerInfo)

  ;;
  ;; lpszProtocolName - the name of the protocol used to provide the secure
  ;;   connection.
  ;;

  (LPWSTR lpszProtocolName)

  ;;
  ;; lpszSignatureAlgName - the name of the algorithm used for signing
  ;;  the certificate.
  ;;

  (LPWSTR lpszSignatureAlgName)

  ;;
  ;; lpszEncryptionAlgName - the name of the algorithm used for
  ;;  doing encryption over the secure channel (SSL) connection.
  ;;

  (LPWSTR lpszEncryptionAlgName)

  ;;
  ;; dwKeySize - size of the key.
  ;;

  (DWORD dwKeySize)
  )

;; #ifdef _WS2DEF_

;; (c:*define-c-struct WINHTTP_CONNECTION_INFO
;;   (DWORD cbSize)
;;   (SOCKADDR_STORAGE LocalAddress)  ;; local ip, local port
;;   (SOCKADDR_STORAGE RemoteAddress) ;; remote ip, remote port
;;   )

;; #endif

;;
;; prototypes
;;

;;
;; constants for WinHttpTimeFromSystemTime
;;

(c:*define WINHTTP_TIME_FORMAT_BUFSIZE   62)

#|
(c:*define-dll-entry
  BOOL
  WinHttpTimeFromSystemTime
  (
   (SYSTEMTIME *) ; pst,  ;; input GMT time
   LPWSTR ; pwszTime ;; output string buffer
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpTimeToSystemTime
  (
   LPCWSTR ; pwszTime,        ;; NULL terminated string
   (SYSTEMTIME *) ; pst         ;; output in GMT time
   )
  *winhttp-dll*)
|#

;;
;; flags for CrackUrl() and CombineUrl()
;;

(c:*define ICU_NO_ENCODE           #x20000000)  ;; Don't convert unsafe characters to escape sequence
(c:*define ICU_DECODE              #x10000000)  ;; Convert %XX escape sequences to characters
(c:*define ICU_NO_META             #x08000000)  ;; Don't convert .. etc. meta path sequences
(c:*define ICU_ENCODE_SPACES_ONLY  #x04000000)  ;; Encode spaces only
(c:*define ICU_BROWSER_MODE        #x02000000)  ;; Special encode/decode rules for browser
(c:*define ICU_ENCODE_PERCENT      #x00001000)  ;; Encode any percent (ASCII25)
                                                ;; signs encountered, default is to not encode percent.

(c:*define-dll-entry
  BOOL
  WinHttpCrackUrl
  (
   LPCWSTR ; pwszUrl,
   DWORD ; dwUrlLength,
   DWORD ; dwFlags,
   LPURL_COMPONENTS ; lpUrlComponents
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpCreateUrl
  (
   LPURL_COMPONENTS ; lpUrlComponents,
   DWORD ; dwFlags,
   LPWSTR ; pwszUrl,
   LPDWORD ; lpdwUrlLength
   )
  *winhttp-dll*)

;;
;; flags for WinHttpCrackUrl() and WinHttpCreateUrl()
;;
(c:*define ICU_ESCAPE           #x80000000)  ;; (un)escape URL characters
(c:*define ICU_ESCAPE_AUTHORITY #x00002000)  ;; causes InternetCreateUrlA to escape chars in authority components (user, pwd, host)
(c:*define ICU_REJECT_USERPWD   #x00004000)  ;; rejects usrls whick have username/pwd sections

(c:*define-dll-entry
  BOOL
  WinHttpCheckPlatform ()
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpGetDefaultProxyConfiguration
  (
   (WINHTTP_PROXY_INFO *) ; pProxyInfo
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpSetDefaultProxyConfiguration
  (
   (WINHTTP_PROXY_INFO *) ; pProxyInfo
   )
  *winhttp-dll*)

(c:*define-dll-entry
  HINTERNET
  WinHttpOpen
  (
   LPCWSTR ; pszAgentW,
   DWORD ; dwAccessType,
   LPCWSTR ; pszProxyW,
   LPCWSTR ; pszProxyBypassW,
   DWORD ; dwFlags
   )
  *winhttp-dll*)

;; WinHttpOpen dwAccessType values (also for WINHTTP_PROXY_INFO::dwAccessType)
(c:*define WINHTTP_ACCESS_TYPE_DEFAULT_PROXY               0)
(c:*define WINHTTP_ACCESS_TYPE_NO_PROXY                    1)
(c:*define WINHTTP_ACCESS_TYPE_NAMED_PROXY                 3)

;; WinHttpOpen prettifiers for optional parameters
(c:*define WINHTTP_NO_PROXY_NAME     NULL)
(c:*define WINHTTP_NO_PROXY_BYPASS   NULL)

(c:*define-dll-entry
  BOOL
  WinHttpCloseHandle
  (
   HINTERNET ; hInternet
   )
  *winhttp-dll*)

(c:*define-dll-entry
  HINTERNET
  WinHttpConnect
  (
   HINTERNET ; hSession,
   LPCWSTR ; pswzServerName,
   INTERNET_PORT ; nServerPort,
   DWORD ; dwReserved
   )
  *winhttp-dll*)


(c:*define-dll-entry
  BOOL
  WinHttpReadData
  (
   HINTERNET ; hRequest,
   LPVOID ; lpBuffer,
   DWORD ; dwNumberOfBytesToRead,
   LPDWORD ; lpdwNumberOfBytesRead
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpWriteData
  (
   HINTERNET ; hRequest,
   LPCVOID ; lpBuffer,
   DWORD ; dwNumberOfBytesToWrite,
   LPDWORD ; lpdwNumberOfBytesWritten
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpQueryDataAvailable
  (
   HINTERNET ; hRequest,
   LPDWORD ; lpdwNumberOfBytesAvailable OPTIONAL
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpQueryOption
  (
   HINTERNET ; hInternet,
   DWORD ; dwOption,
   LPVOID ; lpBuffer OPTIONAL,
   LPDWORD ; lpdwBufferLength
   )
  *winhttp-dll*)

(c:*define WINHTTP_NO_CLIENT_CERT_CONTEXT NULL)

(c:*define-dll-entry
  BOOL
  WinHttpSetOption
  (
   HINTERNET ; hInternet,
   DWORD ; dwOption,
   LPVOID ; lpBuffer,
   DWORD ; dwBufferLength
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpSetTimeouts
  (
   HINTERNET ;    hInternet,           ;; Session/Request handle.
   c:int ;          nResolveTimeout,
   c:int ;          nConnectTimeout,
   c:int ;          nSendTimeout,
   c:int ;          nReceiveTimeout
   )
  *winhttp-dll*)

;;
;; options manifests for WinHttp{Query|Set}Option
;;

(c:*define WINHTTP_OPTION_CALLBACK                       1)
(c:*define WINHTTP_OPTION_RESOLVE_TIMEOUT                2)
(c:*define WINHTTP_OPTION_CONNECT_TIMEOUT                3)
(c:*define WINHTTP_OPTION_CONNECT_RETRIES                4)
(c:*define WINHTTP_OPTION_SEND_TIMEOUT                   5)
(c:*define WINHTTP_OPTION_RECEIVE_TIMEOUT                6)
(c:*define WINHTTP_OPTION_RECEIVE_RESPONSE_TIMEOUT       7)
(c:*define WINHTTP_OPTION_HANDLE_TYPE                    9)
(c:*define WINHTTP_OPTION_READ_BUFFER_SIZE              12)
(c:*define WINHTTP_OPTION_WRITE_BUFFER_SIZE             13)
(c:*define WINHTTP_OPTION_PARENT_HANDLE                 21)
(c:*define WINHTTP_OPTION_EXTENDED_ERROR                24)
(c:*define WINHTTP_OPTION_SECURITY_FLAGS                31)
(c:*define WINHTTP_OPTION_SECURITY_CERTIFICATE_STRUCT   32)
(c:*define WINHTTP_OPTION_URL                           34)
(c:*define WINHTTP_OPTION_SECURITY_KEY_BITNESS          36)
(c:*define WINHTTP_OPTION_PROXY                         38)


(c:*define WINHTTP_OPTION_USER_AGENT                    41)
(c:*define WINHTTP_OPTION_CONTEXT_VALUE                 45)
(c:*define WINHTTP_OPTION_CLIENT_CERT_CONTEXT           47)
(c:*define WINHTTP_OPTION_REQUEST_PRIORITY              58)
(c:*define WINHTTP_OPTION_HTTP_VERSION                  59)
(c:*define WINHTTP_OPTION_DISABLE_FEATURE               63)

(c:*define WINHTTP_OPTION_CODEPAGE                      68)
(c:*define WINHTTP_OPTION_MAX_CONNS_PER_SERVER          73)
(c:*define WINHTTP_OPTION_MAX_CONNS_PER_1_0_SERVER      74)
(c:*define WINHTTP_OPTION_AUTOLOGON_POLICY              77)
(c:*define WINHTTP_OPTION_SERVER_CERT_CONTEXT           78)
(c:*define WINHTTP_OPTION_ENABLE_FEATURE                79)
(c:*define WINHTTP_OPTION_WORKER_THREAD_COUNT           80)
(c:*define WINHTTP_OPTION_PASSPORT_COBRANDING_TEXT      81)
(c:*define WINHTTP_OPTION_PASSPORT_COBRANDING_URL       82)
(c:*define WINHTTP_OPTION_CONFIGURE_PASSPORT_AUTH       83)
(c:*define WINHTTP_OPTION_SECURE_PROTOCOLS              84)
(c:*define WINHTTP_OPTION_ENABLETRACING                 85)
(c:*define WINHTTP_OPTION_PASSPORT_SIGN_OUT             86)
(c:*define WINHTTP_OPTION_PASSPORT_RETURN_URL           87)
(c:*define WINHTTP_OPTION_REDIRECT_POLICY               88)
(c:*define WINHTTP_OPTION_MAX_HTTP_AUTOMATIC_REDIRECTS  89)
(c:*define WINHTTP_OPTION_MAX_HTTP_STATUS_CONTINUE      90)
(c:*define WINHTTP_OPTION_MAX_RESPONSE_HEADER_SIZE      91)
(c:*define WINHTTP_OPTION_MAX_RESPONSE_DRAIN_SIZE       92)
(c:*define WINHTTP_OPTION_CONNECTION_INFO               93)
(c:*define WINHTTP_OPTION_CLIENT_CERT_ISSUER_LIST       94)
(c:*define WINHTTP_OPTION_SPN                           96)

(c:*define WINHTTP_OPTION_GLOBAL_PROXY_CREDS            97)
(c:*define WINHTTP_OPTION_GLOBAL_SERVER_CREDS           98)

(c:*define WINHTTP_OPTION_UNLOAD_NOTIFY_EVENT           99)
(c:*define WINHTTP_OPTION_REJECT_USERPWD_IN_URL         100)
(c:*define WINHTTP_OPTION_USE_GLOBAL_SERVER_CREDENTIALS 101)


(c:*define WINHTTP_FIRST_OPTION                         WINHTTP_OPTION_CALLBACK)
(c:*define WINHTTP_LAST_OPTION                          WINHTTP_OPTION_USE_GLOBAL_SERVER_CREDENTIALS)

(c:*define WINHTTP_OPTION_USERNAME                      #x1000)
(c:*define WINHTTP_OPTION_PASSWORD                      #x1001)
(c:*define WINHTTP_OPTION_PROXY_USERNAME                #x1002)
(c:*define WINHTTP_OPTION_PROXY_PASSWORD                #x1003)


;; manifest value for WINHTTP_OPTION_MAX_CONNS_PER_SERVER and WINHTTP_OPTION_MAX_CONNS_PER_1_0_SERVER
(c:*define WINHTTP_CONNS_PER_SERVER_UNLIMITED    #xFFFFFFFF)


;; values for WINHTTP_OPTION_AUTOLOGON_POLICY
(c:*define WINHTTP_AUTOLOGON_SECURITY_LEVEL_MEDIUM   0)
(c:*define WINHTTP_AUTOLOGON_SECURITY_LEVEL_LOW      1)
(c:*define WINHTTP_AUTOLOGON_SECURITY_LEVEL_HIGH     2)

(c:*define WINHTTP_AUTOLOGON_SECURITY_LEVEL_DEFAULT        WINHTTP_AUTOLOGON_SECURITY_LEVEL_MEDIUM)

;; values for WINHTTP_OPTION_REDIRECT_POLICY
(c:*define WINHTTP_OPTION_REDIRECT_POLICY_NEVER                        0)
(c:*define WINHTTP_OPTION_REDIRECT_POLICY_DISALLOW_HTTPS_TO_HTTP       1)
(c:*define WINHTTP_OPTION_REDIRECT_POLICY_ALWAYS                       2)

(c:*define WINHTTP_OPTION_REDIRECT_POLICY_LAST            WINHTTP_OPTION_REDIRECT_POLICY_ALWAYS)
(c:*define WINHTTP_OPTION_REDIRECT_POLICY_DEFAULT         WINHTTP_OPTION_REDIRECT_POLICY_DISALLOW_HTTPS_TO_HTTP)

(c:*define WINHTTP_DISABLE_PASSPORT_AUTH    #x00000000)
(c:*define WINHTTP_ENABLE_PASSPORT_AUTH     #x10000000)
(c:*define WINHTTP_DISABLE_PASSPORT_KEYRING #x20000000)
(c:*define WINHTTP_ENABLE_PASSPORT_KEYRING  #x40000000)


;; values for WINHTTP_OPTION_DISABLE_FEATURE
(c:*define WINHTTP_DISABLE_COOKIES                   #x00000001)
(c:*define WINHTTP_DISABLE_REDIRECTS                 #x00000002)
(c:*define WINHTTP_DISABLE_AUTHENTICATION            #x00000004)
(c:*define WINHTTP_DISABLE_KEEP_ALIVE                #x00000008)

;; values for WINHTTP_OPTION_ENABLE_FEATURE
(c:*define WINHTTP_ENABLE_SSL_REVOCATION             #x00000001)
(c:*define WINHTTP_ENABLE_SSL_REVERT_IMPERSONATION   #x00000002)

;; values for WINHTTP_OPTION_SPN
(c:*define WINHTTP_DISABLE_SPN_SERVER_PORT           #x00000000)
(c:*define WINHTTP_ENABLE_SPN_SERVER_PORT            #x00000001)
(c:*define WINHTTP_OPTION_SPN_MASK                   WINHTTP_ENABLE_SPN_SERVER_PORT)

(c:*define-c-struct WINHTTP_CREDS
  (LPSTR lpszUserName)
  (LPSTR lpszPassword)
  (LPSTR lpszRealm)
  (DWORD dwAuthScheme)
  (LPSTR lpszHostName)
  (DWORD dwPort)
  )
(c:*define-c-type (WINHTTP_CREDS *) PWINHTTP_CREDS)

;; structure for WINHTTP_OPTION_GLOBAL_SERVER_CREDS and
;; WINHTTP_OPTION_GLOBAL_PROXY_CREDS
(c:*define-c-struct WINHTTP_CREDS_EX
  (LPSTR lpszUserName)
  (LPSTR lpszPassword)
  (LPSTR lpszRealm)
  (DWORD dwAuthScheme)
  (LPSTR lpszHostName)
  (DWORD dwPort)
  (LPSTR lpszUrl)
  )
(c:*define-c-type (WINHTTP_CREDS_EX *) PWINHTTP_CREDS_EX)

;;
;; winhttp handle types
;;
(c:*define WINHTTP_HANDLE_TYPE_SESSION                  1)
(c:*define WINHTTP_HANDLE_TYPE_CONNECT                  2)
(c:*define WINHTTP_HANDLE_TYPE_REQUEST                  3)

;;
;; values for auth schemes
;;
(c:*define WINHTTP_AUTH_SCHEME_BASIC      #x00000001)
(c:*define WINHTTP_AUTH_SCHEME_NTLM       #x00000002)
(c:*define WINHTTP_AUTH_SCHEME_PASSPORT   #x00000004)
(c:*define WINHTTP_AUTH_SCHEME_DIGEST     #x00000008)
(c:*define WINHTTP_AUTH_SCHEME_NEGOTIATE  #x00000010)

;; WinHttp supported Authentication Targets

(c:*define WINHTTP_AUTH_TARGET_SERVER #x00000000)
(c:*define WINHTTP_AUTH_TARGET_PROXY  #x00000001)

;;
;; values for WINHTTP_OPTION_SECURITY_FLAGS
;;

;; query only
(c:*define SECURITY_FLAG_SECURE                    #x00000001) ;; can query only
(c:*define SECURITY_FLAG_STRENGTH_WEAK             #x10000000)
(c:*define SECURITY_FLAG_STRENGTH_MEDIUM           #x40000000)
(c:*define SECURITY_FLAG_STRENGTH_STRONG           #x20000000)



;; Secure connection error status flags
(c:*define WINHTTP_CALLBACK_STATUS_FLAG_CERT_REV_FAILED         #x00000001)
(c:*define WINHTTP_CALLBACK_STATUS_FLAG_INVALID_CERT            #x00000002)
(c:*define WINHTTP_CALLBACK_STATUS_FLAG_CERT_REVOKED            #x00000004)
(c:*define WINHTTP_CALLBACK_STATUS_FLAG_INVALID_CA              #x00000008)
(c:*define WINHTTP_CALLBACK_STATUS_FLAG_CERT_CN_INVALID         #x00000010)
(c:*define WINHTTP_CALLBACK_STATUS_FLAG_CERT_DATE_INVALID       #x00000020)
(c:*define WINHTTP_CALLBACK_STATUS_FLAG_CERT_WRONG_USAGE        #x00000040)
(c:*define WINHTTP_CALLBACK_STATUS_FLAG_SECURITY_CHANNEL_ERROR  #x80000000)


(c:*define WINHTTP_FLAG_SECURE_PROTOCOL_SSL2   #x00000008)
(c:*define WINHTTP_FLAG_SECURE_PROTOCOL_SSL3   #x00000020)
(c:*define WINHTTP_FLAG_SECURE_PROTOCOL_TLS1   #x00000080)
(c:*define WINHTTP_FLAG_SECURE_PROTOCOL_ALL    (logior WINHTTP_FLAG_SECURE_PROTOCOL_SSL2
                                                       WINHTTP_FLAG_SECURE_PROTOCOL_SSL3
                                                       WINHTTP_FLAG_SECURE_PROTOCOL_TLS1))


;;
;; callback function for WinHttpSetStatusCallback
;;

;; typedef
;; VOID
;; (CALLBACK * WINHTTP_STATUS_CALLBACK)(
;;     IN HINTERNET hInternet,
;;     IN DWORD_PTR dwContext,
;;     IN DWORD dwInternetStatus,
;;     IN LPVOID lpvStatusInformation OPTIONAL,
;;     IN DWORD dwStatusInformationLength
;;     );

(c:*define-c-type (c:void *) WINHTTP_STATUS_CALLBACK)
(c:*define-c-type (WINHTTP_STATUS_CALLBACK *) LPWINHTTP_STATUS_CALLBACK)

(c:*define-dll-entry
  WINHTTP_STATUS_CALLBACK
  WinHttpSetStatusCallback
  (
   HINTERNET ; hInternet,
   WINHTTP_STATUS_CALLBACK ; lpfnInternetCallback,
   DWORD ; dwNotificationFlags,
   DWORD_PTR ; dwReserved
   )
  *winhttp-dll*)


;;
;; status manifests for WinHttp status callback
;;

(c:*define WINHTTP_CALLBACK_STATUS_RESOLVING_NAME          #x00000001)
(c:*define WINHTTP_CALLBACK_STATUS_NAME_RESOLVED           #x00000002)
(c:*define WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER    #x00000004)
(c:*define WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER     #x00000008)
(c:*define WINHTTP_CALLBACK_STATUS_SENDING_REQUEST         #x00000010)
(c:*define WINHTTP_CALLBACK_STATUS_REQUEST_SENT            #x00000020)
(c:*define WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE      #x00000040)
(c:*define WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED       #x00000080)
(c:*define WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION      #x00000100)
(c:*define WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED       #x00000200)
(c:*define WINHTTP_CALLBACK_STATUS_HANDLE_CREATED          #x00000400)
(c:*define WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING          #x00000800)
(c:*define WINHTTP_CALLBACK_STATUS_DETECTING_PROXY         #x00001000)
(c:*define WINHTTP_CALLBACK_STATUS_REDIRECT                #x00004000)
(c:*define WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE   #x00008000)
(c:*define WINHTTP_CALLBACK_STATUS_SECURE_FAILURE          #x00010000)
(c:*define WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE       #x00020000)
(c:*define WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE          #x00040000)
(c:*define WINHTTP_CALLBACK_STATUS_READ_COMPLETE           #x00080000)
(c:*define WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE          #x00100000)
(c:*define WINHTTP_CALLBACK_STATUS_REQUEST_ERROR           #x00200000)
(c:*define WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE    #x00400000)


;; API Enums for WINHTTP_CALLBACK_STATUS_REQUEST_ERROR:
(c:*define API_RECEIVE_RESPONSE          1)
(c:*define API_QUERY_DATA_AVAILABLE      2)
(c:*define API_READ_DATA                 3)
(c:*define API_WRITE_DATA                4)
(c:*define API_SEND_REQUEST              5)


(c:*define WINHTTP_CALLBACK_FLAG_RESOLVE_NAME              (logior WINHTTP_CALLBACK_STATUS_RESOLVING_NAME WINHTTP_CALLBACK_STATUS_NAME_RESOLVED))
(c:*define WINHTTP_CALLBACK_FLAG_CONNECT_TO_SERVER         (logior WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER))
(c:*define WINHTTP_CALLBACK_FLAG_SEND_REQUEST              (logior WINHTTP_CALLBACK_STATUS_SENDING_REQUEST WINHTTP_CALLBACK_STATUS_REQUEST_SENT))
(c:*define WINHTTP_CALLBACK_FLAG_RECEIVE_RESPONSE          (logior WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED))
(c:*define WINHTTP_CALLBACK_FLAG_CLOSE_CONNECTION          (logior WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED))
(c:*define WINHTTP_CALLBACK_FLAG_HANDLES                   (logior WINHTTP_CALLBACK_STATUS_HANDLE_CREATED WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING))
(c:*define WINHTTP_CALLBACK_FLAG_DETECTING_PROXY           WINHTTP_CALLBACK_STATUS_DETECTING_PROXY)
(c:*define WINHTTP_CALLBACK_FLAG_REDIRECT                  WINHTTP_CALLBACK_STATUS_REDIRECT)
(c:*define WINHTTP_CALLBACK_FLAG_INTERMEDIATE_RESPONSE     WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE)
(c:*define WINHTTP_CALLBACK_FLAG_SECURE_FAILURE            WINHTTP_CALLBACK_STATUS_SECURE_FAILURE)
(c:*define WINHTTP_CALLBACK_FLAG_SENDREQUEST_COMPLETE      WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE)
(c:*define WINHTTP_CALLBACK_FLAG_HEADERS_AVAILABLE         WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE)
(c:*define WINHTTP_CALLBACK_FLAG_DATA_AVAILABLE            WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE)
(c:*define WINHTTP_CALLBACK_FLAG_READ_COMPLETE             WINHTTP_CALLBACK_STATUS_READ_COMPLETE)
(c:*define WINHTTP_CALLBACK_FLAG_WRITE_COMPLETE            WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE)
(c:*define WINHTTP_CALLBACK_FLAG_REQUEST_ERROR             WINHTTP_CALLBACK_STATUS_REQUEST_ERROR)


(c:*define WINHTTP_CALLBACK_FLAG_ALL_COMPLETIONS           (logior WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE
                                                                   WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE
                                                                   WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE
                                                                   WINHTTP_CALLBACK_STATUS_READ_COMPLETE
                                                                   WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE
                                                                   WINHTTP_CALLBACK_STATUS_REQUEST_ERROR))
(c:*define WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS         #xffffffff)

;;
;; if the following value is returned by WinHttpSetStatusCallback, then
;; probably an invalid (non-code) address was supplied for the callback
;;

(c:*define WINHTTP_INVALID_STATUS_CALLBACK        -1)


;;
;; WinHttpQueryHeaders info levels. Generally, there is one info level
;; for each potential RFC822/HTTP/MIME header that an HTTP server
;; may send as part of a request response.
;;
;; The WINHTTP_QUERY_RAW_HEADERS info level is provided for clients
;; that choose to perform their own header parsing.
;;


(c:*define WINHTTP_QUERY_MIME_VERSION                 0)
(c:*define WINHTTP_QUERY_CONTENT_TYPE                 1)
(c:*define WINHTTP_QUERY_CONTENT_TRANSFER_ENCODING    2)
(c:*define WINHTTP_QUERY_CONTENT_ID                   3)
(c:*define WINHTTP_QUERY_CONTENT_DESCRIPTION          4)
(c:*define WINHTTP_QUERY_CONTENT_LENGTH               5)
(c:*define WINHTTP_QUERY_CONTENT_LANGUAGE             6)
(c:*define WINHTTP_QUERY_ALLOW                        7)
(c:*define WINHTTP_QUERY_PUBLIC                       8)
(c:*define WINHTTP_QUERY_DATE                         9)
(c:*define WINHTTP_QUERY_EXPIRES                      10)
(c:*define WINHTTP_QUERY_LAST_MODIFIED                11)
(c:*define WINHTTP_QUERY_MESSAGE_ID                   12)
(c:*define WINHTTP_QUERY_URI                          13)
(c:*define WINHTTP_QUERY_DERIVED_FROM                 14)
(c:*define WINHTTP_QUERY_COST                         15)
(c:*define WINHTTP_QUERY_LINK                         16)
(c:*define WINHTTP_QUERY_PRAGMA                       17)
(c:*define WINHTTP_QUERY_VERSION                      18)  ;; special: part of status line
(c:*define WINHTTP_QUERY_STATUS_CODE                  19)  ;; special: part of status line
(c:*define WINHTTP_QUERY_STATUS_TEXT                  20)  ;; special: part of status line
(c:*define WINHTTP_QUERY_RAW_HEADERS                  21)  ;; special: all headers as ASCIIZ
(c:*define WINHTTP_QUERY_RAW_HEADERS_CRLF             22)  ;; special: all headers
(c:*define WINHTTP_QUERY_CONNECTION                   23)
(c:*define WINHTTP_QUERY_ACCEPT                       24)
(c:*define WINHTTP_QUERY_ACCEPT_CHARSET               25)
(c:*define WINHTTP_QUERY_ACCEPT_ENCODING              26)
(c:*define WINHTTP_QUERY_ACCEPT_LANGUAGE              27)
(c:*define WINHTTP_QUERY_AUTHORIZATION                28)
(c:*define WINHTTP_QUERY_CONTENT_ENCODING             29)
(c:*define WINHTTP_QUERY_FORWARDED                    30)
(c:*define WINHTTP_QUERY_FROM                         31)
(c:*define WINHTTP_QUERY_IF_MODIFIED_SINCE            32)
(c:*define WINHTTP_QUERY_LOCATION                     33)
(c:*define WINHTTP_QUERY_ORIG_URI                     34)
(c:*define WINHTTP_QUERY_REFERER                      35)
(c:*define WINHTTP_QUERY_RETRY_AFTER                  36)
(c:*define WINHTTP_QUERY_SERVER                       37)
(c:*define WINHTTP_QUERY_TITLE                        38)
(c:*define WINHTTP_QUERY_USER_AGENT                   39)
(c:*define WINHTTP_QUERY_WWW_AUTHENTICATE             40)
(c:*define WINHTTP_QUERY_PROXY_AUTHENTICATE           41)
(c:*define WINHTTP_QUERY_ACCEPT_RANGES                42)
(c:*define WINHTTP_QUERY_SET_COOKIE                   43)
(c:*define WINHTTP_QUERY_COOKIE                       44)
(c:*define WINHTTP_QUERY_REQUEST_METHOD               45)  ;; special: GET/POST etc.
(c:*define WINHTTP_QUERY_REFRESH                      46)
(c:*define WINHTTP_QUERY_CONTENT_DISPOSITION          47)

;;
;; HTTP 1.1 defined headers
;;

(c:*define WINHTTP_QUERY_AGE                          48)
(c:*define WINHTTP_QUERY_CACHE_CONTROL                49)
(c:*define WINHTTP_QUERY_CONTENT_BASE                 50)
(c:*define WINHTTP_QUERY_CONTENT_LOCATION             51)
(c:*define WINHTTP_QUERY_CONTENT_MD5                  52)
(c:*define WINHTTP_QUERY_CONTENT_RANGE                53)
(c:*define WINHTTP_QUERY_ETAG                         54)
(c:*define WINHTTP_QUERY_HOST                         55)
(c:*define WINHTTP_QUERY_IF_MATCH                     56)
(c:*define WINHTTP_QUERY_IF_NONE_MATCH                57)
(c:*define WINHTTP_QUERY_IF_RANGE                     58)
(c:*define WINHTTP_QUERY_IF_UNMODIFIED_SINCE          59)
(c:*define WINHTTP_QUERY_MAX_FORWARDS                 60)
(c:*define WINHTTP_QUERY_PROXY_AUTHORIZATION          61)
(c:*define WINHTTP_QUERY_RANGE                        62)
(c:*define WINHTTP_QUERY_TRANSFER_ENCODING            63)
(c:*define WINHTTP_QUERY_UPGRADE                      64)
(c:*define WINHTTP_QUERY_VARY                         65)
(c:*define WINHTTP_QUERY_VIA                          66)
(c:*define WINHTTP_QUERY_WARNING                      67)
(c:*define WINHTTP_QUERY_EXPECT                       68)
(c:*define WINHTTP_QUERY_PROXY_CONNECTION             69)
(c:*define WINHTTP_QUERY_UNLESS_MODIFIED_SINCE        70)



(c:*define WINHTTP_QUERY_PROXY_SUPPORT                75)
(c:*define WINHTTP_QUERY_AUTHENTICATION_INFO          76)
(c:*define WINHTTP_QUERY_PASSPORT_URLS                77)
(c:*define WINHTTP_QUERY_PASSPORT_CONFIG              78)

(c:*define WINHTTP_QUERY_MAX                          78)

;;
;; WINHTTP_QUERY_CUSTOM - if this special value is supplied as the dwInfoLevel
;; parameter of WinHttpQueryHeaders() then the lpBuffer parameter contains the name
;; of the header we are to query
;;

(c:*define WINHTTP_QUERY_CUSTOM                       65535)

;;
;; WINHTTP_QUERY_FLAG_REQUEST_HEADERS - if this bit is set in the dwInfoLevel
;; parameter of WinHttpQueryHeaders() then the request headers will be queried for the
;; request information
;;

(c:*define WINHTTP_QUERY_FLAG_REQUEST_HEADERS         #x80000000)

;;
;; WINHTTP_QUERY_FLAG_SYSTEMTIME - if this bit is set in the dwInfoLevel parameter
;; of WinHttpQueryHeaders() AND the header being queried contains date information,
;; e.g. the "Expires:" header then lpBuffer will contain a SYSTEMTIME structure
;; containing the date and time information converted from the header string
;;

(c:*define WINHTTP_QUERY_FLAG_SYSTEMTIME              #x40000000)

;;
;; WINHTTP_QUERY_FLAG_NUMBER - if this bit is set in the dwInfoLevel parameter of
;; HttpQueryHeader(), then the value of the header will be converted to a number
;; before being returned to the caller, if applicable
;;

(c:*define WINHTTP_QUERY_FLAG_NUMBER                  #x20000000)



;;
;; HTTP Response Status Codes:
;;

(c:*define HTTP_STATUS_CONTINUE            100) ;; OK to continue with request
(c:*define HTTP_STATUS_SWITCH_PROTOCOLS    101) ;; server has switched protocols in upgrade header

(c:*define HTTP_STATUS_OK                  200) ;; request completed
(c:*define HTTP_STATUS_CREATED             201) ;; object created, reason = new URI
(c:*define HTTP_STATUS_ACCEPTED            202) ;; async completion (TBS)
(c:*define HTTP_STATUS_PARTIAL             203) ;; partial completion
(c:*define HTTP_STATUS_NO_CONTENT          204) ;; no info to return
(c:*define HTTP_STATUS_RESET_CONTENT       205) ;; request completed, but clear form
(c:*define HTTP_STATUS_PARTIAL_CONTENT     206) ;; partial GET fulfilled
(c:*define HTTP_STATUS_WEBDAV_MULTI_STATUS 207) ;; WebDAV Multi-Status

(c:*define HTTP_STATUS_AMBIGUOUS           300) ;; server couldn't decide what to return
(c:*define HTTP_STATUS_MOVED               301) ;; object permanently moved
(c:*define HTTP_STATUS_REDIRECT            302) ;; object temporarily moved
(c:*define HTTP_STATUS_REDIRECT_METHOD     303) ;; redirection w/ new access method
(c:*define HTTP_STATUS_NOT_MODIFIED        304) ;; if-modified-since was not modified
(c:*define HTTP_STATUS_USE_PROXY           305) ;; redirection to proxy, location header specifies proxy to use
(c:*define HTTP_STATUS_REDIRECT_KEEP_VERB  307) ;; HTTP/1.1: keep same verb

(c:*define HTTP_STATUS_BAD_REQUEST         400) ;; invalid syntax
(c:*define HTTP_STATUS_DENIED              401) ;; access denied
(c:*define HTTP_STATUS_PAYMENT_REQ         402) ;; payment required
(c:*define HTTP_STATUS_FORBIDDEN           403) ;; request forbidden
(c:*define HTTP_STATUS_NOT_FOUND           404) ;; object not found
(c:*define HTTP_STATUS_BAD_METHOD          405) ;; method is not allowed
(c:*define HTTP_STATUS_NONE_ACCEPTABLE     406) ;; no response acceptable to client found
(c:*define HTTP_STATUS_PROXY_AUTH_REQ      407) ;; proxy authentication required
(c:*define HTTP_STATUS_REQUEST_TIMEOUT     408) ;; server timed out waiting for request
(c:*define HTTP_STATUS_CONFLICT            409) ;; user should resubmit with more info
(c:*define HTTP_STATUS_GONE                410) ;; the resource is no longer available
(c:*define HTTP_STATUS_LENGTH_REQUIRED     411) ;; the server refused to accept request w/o a length
(c:*define HTTP_STATUS_PRECOND_FAILED      412) ;; precondition given in request failed
(c:*define HTTP_STATUS_REQUEST_TOO_LARGE   413) ;; request entity was too large
(c:*define HTTP_STATUS_URI_TOO_LONG        414) ;; request URI too long
(c:*define HTTP_STATUS_UNSUPPORTED_MEDIA   415) ;; unsupported media type
(c:*define HTTP_STATUS_RETRY_WITH          449) ;; retry after doing the appropriate action.

(c:*define HTTP_STATUS_SERVER_ERROR        500) ;; internal server error
(c:*define HTTP_STATUS_NOT_SUPPORTED       501) ;; required not supported
(c:*define HTTP_STATUS_BAD_GATEWAY         502) ;; error response received from gateway
(c:*define HTTP_STATUS_SERVICE_UNAVAIL     503) ;; temporarily overloaded
(c:*define HTTP_STATUS_GATEWAY_TIMEOUT     504) ;; timed out waiting for gateway
(c:*define HTTP_STATUS_VERSION_NOT_SUP     505) ;; HTTP version not supported

(c:*define HTTP_STATUS_FIRST               HTTP_STATUS_CONTINUE)
(c:*define HTTP_STATUS_LAST                HTTP_STATUS_VERSION_NOT_SUP)

;;
;; prototypes
;;

(c:*define-dll-entry
  HINTERNET
  WinHttpOpenRequest
  (
   HINTERNET ; hConnect,
   LPCWSTR ; pwszVerb,
   LPCWSTR ; pwszObjectName,
   LPCWSTR ; pwszVersion,
   LPCWSTR ; pwszReferrer OPTIONAL,
   LPCWSTR ; FAR * ppwszAcceptTypes OPTIONAL,
   DWORD ; dwFlags
   )
  *winhttp-dll*)

;; WinHttpOpenRequest prettifers for optional parameters
(c:*define WINHTTP_NO_REFERER             NULL)
(c:*define WINHTTP_DEFAULT_ACCEPT_TYPES   NULL)

(c:*define-dll-entry
  BOOL
  WinHttpAddRequestHeaders
  (
   HINTERNET ; hRequest,
   LPCWSTR ; pwszHeaders,
   DWORD ; dwHeadersLength,
   DWORD ; dwModifiers
   )
  *winhttp-dll*)

;;
;; values for dwModifiers parameter of WinHttpAddRequestHeaders()
;;

(c:*define WINHTTP_ADDREQ_INDEX_MASK      #x0000FFFF)
(c:*define WINHTTP_ADDREQ_FLAGS_MASK      #xFFFF0000)

;;
;; WINHTTP_ADDREQ_FLAG_ADD_IF_NEW - the header will only be added if it doesn't
;; already exist
;;

(c:*define WINHTTP_ADDREQ_FLAG_ADD_IF_NEW #x10000000)

;;
;; WINHTTP_ADDREQ_FLAG_ADD - if WINHTTP_ADDREQ_FLAG_REPLACE is set but the header is
;; not found then if this flag is set, the header is added anyway, so long as
;; there is a valid header-value
;;

(c:*define WINHTTP_ADDREQ_FLAG_ADD        #x20000000)

;;
;; WINHTTP_ADDREQ_FLAG_COALESCE - coalesce headers with same name. e.g.
;; "Accept: text/*" and "Accept: audio/*" with this flag results in a single
;; header: "Accept: text/*, audio/*"
;;

(c:*define WINHTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA       #x40000000)
(c:*define WINHTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON   #x01000000)
(c:*define WINHTTP_ADDREQ_FLAG_COALESCE                  WINHTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA)

;;
;; WINHTTP_ADDREQ_FLAG_REPLACE - replaces the specified header. Only one header can
;; be supplied in the buffer. If the header to be replaced is not the first
;; in a list of headers with the same name, then the relative index should be
;; supplied in the low 8 bits of the dwModifiers parameter. If the header-value
;; part is missing, then the header is removed
;;

(c:*define WINHTTP_ADDREQ_FLAG_REPLACE    #x80000000)

(c:*define WINHTTP_IGNORE_REQUEST_TOTAL_LENGTH 0)

(c:*define-dll-entry
  BOOL
  WinHttpSendRequest
  (
   HINTERNET ; hRequest,
   LPCWSTR ; pwszHeaders OPTIONAL,
   DWORD ; dwHeadersLength,
   LPVOID ; lpOptional OPTIONAL,
   DWORD ; dwOptionalLength,
   DWORD ; dwTotalLength,
   DWORD_PTR ; dwContext
   )
  *winhttp-dll*)

;; WinHttpSendRequest prettifiers for optional parameters.
(c:*define WINHTTP_NO_ADDITIONAL_HEADERS   NULL)
(c:*define WINHTTP_NO_REQUEST_DATA         NULL)


(c:*define-dll-entry
  BOOL WinHttpSetCredentials
  (

   HINTERNET ;   hRequest,        ;; HINTERNET handle returned by WinHttpOpenRequest.

   DWORD ;       AuthTargets,      ;; Only WINHTTP_AUTH_TARGET_SERVER and
                                   ;; WINHTTP_AUTH_TARGET_PROXY are supported
                                   ;; in this version and they are mutually
                                   ;; exclusive

   DWORD ;       AuthScheme,      ;; must be one of the supported Auth Schemes
                                  ;; returned from WinHttpQueryAuthSchemes()

   LPCWSTR ;     pwszUserName,    ;; 1) NULL if default creds is to be used, in
                                  ;; which case pszPassword will be ignored

   LPCWSTR ;     pwszPassword,    ;; 1) "" == Blank Password; 2)Parameter ignored
                                  ;; if pszUserName is NULL; 3) Invalid to pass in
                                  ;; NULL if pszUserName is not NULL
   LPVOID ;      pAuthParams
   )
  *winhttp-dll*)


(c:*define-dll-entry
  BOOL
  WinHttpQueryAuthSchemes
  (
   HINTERNET ;   hRequest,             ;; HINTERNET handle returned by WinHttpOpenRequest
   LPDWORD ;     lpdwSupportedSchemes, ;; a bitmap of available Authentication Schemes
   LPDWORD ;     lpdwFirstScheme,      ;; returns the first auth scheme returned by the server
   LPDWORD ;     pdwAuthTarget
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpQueryAuthParams
  (
   HINTERNET ;   hRequest,        ;; HINTERNET handle returned by WinHttpOpenRequest
   DWORD ;       AuthScheme,
   (LPVOID *) ;     pAuthParams      ;; Scheme-specific Advanced auth parameters
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpReceiveResponse
  (
   HINTERNET ; hRequest,
   LPVOID ; lpReserved
   )
  *winhttp-dll*)


(c:*define-dll-entry
  BOOL
  WinHttpQueryHeaders
  (
   HINTERNET ; hRequest,
   DWORD ;     dwInfoLevel,
   LPCWSTR ;   pwszName OPTIONAL,
   LPVOID ;    lpBuffer OPTIONAL,
   LPDWORD ;   lpdwBufferLength,
   LPDWORD ;   lpdwIndex OPTIONAL
   )
  *winhttp-dll*)

;; WinHttpQueryHeaders prettifiers for optional parameters.
(c:*define WINHTTP_HEADER_NAME_BY_INDEX           NULL)
(c:*define WINHTTP_NO_OUTPUT_BUFFER               NULL)
(c:*define WINHTTP_NO_HEADER_INDEX                NULL)


(c:*define-dll-entry
  BOOL
  WinHttpDetectAutoProxyConfigUrl
  (
   DWORD ;     dwAutoDetectFlags,
   (LPWSTR *) ;  ppwszAutoConfigUrl
   )
  *winhttp-dll*)

(c:*define-dll-entry
  BOOL
  WinHttpGetProxyForUrl
  (
   HINTERNET ;                   hSession,
   LPCWSTR ;                     lpcwszUrl,
   (WINHTTP_AUTOPROXY_OPTIONS *) ; pAutoProxyOptions,
   (WINHTTP_PROXY_INFO *) ;        pProxyInfo
   )
  *winhttp-dll*)


(c:*define-c-struct WINHTTP_CURRENT_USER_IE_PROXY_CONFIG
  (BOOL    fAutoDetect)
  (LPWSTR  lpszAutoConfigUrl)
  (LPWSTR  lpszProxy)
  (LPWSTR  lpszProxyBypass)
  )

(c:*define-dll-entry
  BOOL
  WinHttpGetIEProxyConfigForCurrentUser
  (
   (WINHTTP_CURRENT_USER_IE_PROXY_CONFIG *) ; pProxyConfig
   )
  *winhttp-dll*)


;;#if !defined(_WINERROR_)

;;
;; WinHttp API error returns
;;

(c:*define WINHTTP_ERROR_BASE                     12000)

(c:*define ERROR_WINHTTP_OUT_OF_HANDLES           (+ WINHTTP_ERROR_BASE 1))
(c:*define ERROR_WINHTTP_TIMEOUT                  (+ WINHTTP_ERROR_BASE 2))
(c:*define ERROR_WINHTTP_INTERNAL_ERROR           (+ WINHTTP_ERROR_BASE 4))
(c:*define ERROR_WINHTTP_INVALID_URL              (+ WINHTTP_ERROR_BASE 5))
(c:*define ERROR_WINHTTP_UNRECOGNIZED_SCHEME      (+ WINHTTP_ERROR_BASE 6))
(c:*define ERROR_WINHTTP_NAME_NOT_RESOLVED        (+ WINHTTP_ERROR_BASE 7))
(c:*define ERROR_WINHTTP_INVALID_OPTION           (+ WINHTTP_ERROR_BASE 9))
(c:*define ERROR_WINHTTP_OPTION_NOT_SETTABLE      (+ WINHTTP_ERROR_BASE 11))
(c:*define ERROR_WINHTTP_SHUTDOWN                 (+ WINHTTP_ERROR_BASE 12))


(c:*define ERROR_WINHTTP_LOGIN_FAILURE            (+ WINHTTP_ERROR_BASE 15))
(c:*define ERROR_WINHTTP_OPERATION_CANCELLED      (+ WINHTTP_ERROR_BASE 17))
(c:*define ERROR_WINHTTP_INCORRECT_HANDLE_TYPE    (+ WINHTTP_ERROR_BASE 18))
(c:*define ERROR_WINHTTP_INCORRECT_HANDLE_STATE   (+ WINHTTP_ERROR_BASE 19))
(c:*define ERROR_WINHTTP_CANNOT_CONNECT           (+ WINHTTP_ERROR_BASE 29))
(c:*define ERROR_WINHTTP_CONNECTION_ERROR         (+ WINHTTP_ERROR_BASE 30))
(c:*define ERROR_WINHTTP_RESEND_REQUEST           (+ WINHTTP_ERROR_BASE 32))

(c:*define ERROR_WINHTTP_CLIENT_AUTH_CERT_NEEDED  (+ WINHTTP_ERROR_BASE 44))

;;
;; WinHttpRequest Component errors
;;
(c:*define ERROR_WINHTTP_CANNOT_CALL_BEFORE_OPEN        (+ WINHTTP_ERROR_BASE 100))
(c:*define ERROR_WINHTTP_CANNOT_CALL_BEFORE_SEND        (+ WINHTTP_ERROR_BASE 101))
(c:*define ERROR_WINHTTP_CANNOT_CALL_AFTER_SEND         (+ WINHTTP_ERROR_BASE 102))
(c:*define ERROR_WINHTTP_CANNOT_CALL_AFTER_OPEN         (+ WINHTTP_ERROR_BASE 103))


;;
;; HTTP API errors
;;

(c:*define ERROR_WINHTTP_HEADER_NOT_FOUND             (+ WINHTTP_ERROR_BASE 150))
(c:*define ERROR_WINHTTP_INVALID_SERVER_RESPONSE      (+ WINHTTP_ERROR_BASE 152))
(c:*define ERROR_WINHTTP_INVALID_HEADER               (+ WINHTTP_ERROR_BASE 153))
(c:*define ERROR_WINHTTP_INVALID_QUERY_REQUEST        (+ WINHTTP_ERROR_BASE 154))
(c:*define ERROR_WINHTTP_HEADER_ALREADY_EXISTS        (+ WINHTTP_ERROR_BASE 155))
(c:*define ERROR_WINHTTP_REDIRECT_FAILED              (+ WINHTTP_ERROR_BASE 156))



;;
;; additional WinHttp API error codes
;;

;;
;; additional WinHttp API error codes
;;
(c:*define ERROR_WINHTTP_AUTO_PROXY_SERVICE_ERROR  (+ WINHTTP_ERROR_BASE 178))
(c:*define ERROR_WINHTTP_BAD_AUTO_PROXY_SCRIPT     (+ WINHTTP_ERROR_BASE 166))
(c:*define ERROR_WINHTTP_UNABLE_TO_DOWNLOAD_SCRIPT (+ WINHTTP_ERROR_BASE 167))

(c:*define ERROR_WINHTTP_NOT_INITIALIZED          (+ WINHTTP_ERROR_BASE 172))
(c:*define ERROR_WINHTTP_SECURE_FAILURE           (+ WINHTTP_ERROR_BASE 175))


;;
;; Certificate security errors. These are raised only by the WinHttpRequest
;; component. The WinHTTP Win32 API will return ERROR_WINHTTP_SECURE_FAILE and
;; provide additional information via the WINHTTP_CALLBACK_STATUS_SECURE_FAILURE
;; callback notification.
;;
(c:*define ERROR_WINHTTP_SECURE_CERT_DATE_INVALID    (+ WINHTTP_ERROR_BASE 37))
(c:*define ERROR_WINHTTP_SECURE_CERT_CN_INVALID      (+ WINHTTP_ERROR_BASE 38))
(c:*define ERROR_WINHTTP_SECURE_INVALID_CA           (+ WINHTTP_ERROR_BASE 45))
(c:*define ERROR_WINHTTP_SECURE_CERT_REV_FAILED      (+ WINHTTP_ERROR_BASE 57))
(c:*define ERROR_WINHTTP_SECURE_CHANNEL_ERROR        (+ WINHTTP_ERROR_BASE 157))
(c:*define ERROR_WINHTTP_SECURE_INVALID_CERT         (+ WINHTTP_ERROR_BASE 169))
(c:*define ERROR_WINHTTP_SECURE_CERT_REVOKED         (+ WINHTTP_ERROR_BASE 170))
(c:*define ERROR_WINHTTP_SECURE_CERT_WRONG_USAGE     (+ WINHTTP_ERROR_BASE 179))


(c:*define ERROR_WINHTTP_AUTODETECTION_FAILED                  (+ WINHTTP_ERROR_BASE 180))
(c:*define ERROR_WINHTTP_HEADER_COUNT_EXCEEDED                 (+ WINHTTP_ERROR_BASE 181))
(c:*define ERROR_WINHTTP_HEADER_SIZE_OVERFLOW                  (+ WINHTTP_ERROR_BASE 182))
(c:*define ERROR_WINHTTP_CHUNKED_ENCODING_HEADER_SIZE_OVERFLOW (+ WINHTTP_ERROR_BASE 183))
(c:*define ERROR_WINHTTP_RESPONSE_DRAIN_OVERFLOW               (+ WINHTTP_ERROR_BASE 184))
(c:*define ERROR_WINHTTP_CLIENT_CERT_NO_PRIVATE_KEY            (+ WINHTTP_ERROR_BASE 185))
(c:*define ERROR_WINHTTP_CLIENT_CERT_NO_ACCESS_PRIVATE_KEY     (+ WINHTTP_ERROR_BASE 186))

(c:*define WINHTTP_ERROR_LAST                                  (+ WINHTTP_ERROR_BASE 186))


(provide "xl-winhttp/ffi/winhttp")

;;; End
