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
  (require "xl-winhttp/internal/utils")
  )

(in-package :xl-winhttp.internal)

(export '(*option-autologon-policy-type*
          *option-configure-passport-auth-type*
          *option-disable-feature-flags*
          *option-enable-feature-type*
          *option-handle-type*
          *option-redirect-policy-type*
          *option-secure-protocol-flags*
          *option-security-flags*
          *option-spn-type*
          *option-list*
          check-option
          option-name
          option-const
          option-accept-session-handle-p
          option-accept-request-handle-p
          option-can-query-p
          option-can-set-p
          option-data-type
          option-data-subtype
          option-data-flags-alist
          find-option
          ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384066.aspx

(defvar *option-autologon-policy-type*
  `(:high                       ,WINHTTP_AUTOLOGON_SECURITY_LEVEL_HIGH
    :low                        ,WINHTTP_AUTOLOGON_SECURITY_LEVEL_LOW
    :medium                     ,WINHTTP_AUTOLOGON_SECURITY_LEVEL_MEDIUM
    ))

(defvar *option-configure-passport-auth-type*
  `(:disable-auth               ,WINHTTP_DISABLE_PASSPORT_AUTH
    :disable-keyring            ,WINHTTP_DISABLE_PASSPORT_KEYRING
    :enable-auth                ,WINHTTP_ENABLE_PASSPORT_AUTH
    :enable-keyring             ,WINHTTP_ENABLE_PASSPORT_KEYRING
    ))

(defvar *option-disable-feature-flags*
  `(:authentication             ,WINHTTP_DISABLE_AUTHENTICATION
    :cookies                    ,WINHTTP_DISABLE_COOKIES
    :keep-alive                 ,WINHTTP_DISABLE_KEEP_ALIVE
    :redirects                  ,WINHTTP_DISABLE_REDIRECTS
    ))

(defvar *option-enable-feature-type*
  `(:ssl-revert-impersonation   ,WINHTTP_ENABLE_SSL_REVERT_IMPERSONATION
    :ssl-revocation             ,WINHTTP_ENABLE_SSL_REVOCATION
    ))

(defvar *option-handle-type*
  `(:connection                 ,WINHTTP_HANDLE_TYPE_CONNECT
    :request                    ,WINHTTP_HANDLE_TYPE_REQUEST
    :session                    ,WINHTTP_HANDLE_TYPE_SESSION
    ))

(defvar *option-redirect-policy-type*
  `(:always                     ,WINHTTP_OPTION_REDIRECT_POLICY_ALWAYS
    :disallow-https-to-http     ,WINHTTP_OPTION_REDIRECT_POLICY_DISALLOW_HTTPS_TO_HTTP
    :never                      ,WINHTTP_OPTION_REDIRECT_POLICY_NEVER
    ))

(defvar *option-secure-protocol-flags*
  `(:all                        ,WINHTTP_FLAG_SECURE_PROTOCOL_ALL
    :ssl2                       ,WINHTTP_FLAG_SECURE_PROTOCOL_SSL2
    :ssl3                       ,WINHTTP_FLAG_SECURE_PROTOCOL_SSL3
    :tls1                       ,WINHTTP_FLAG_SECURE_PROTOCOL_TLS1
    ))

(defvar *option-security-flags*
  `(:ignore-cert-cn-invalid     ,SECURITY_FLAG_IGNORE_CERT_CN_INVALID
    :ignore-cert-date-invalid   ,SECURITY_FLAG_IGNORE_CERT_DATE_INVALID
    :ignore-unknown-ca          ,SECURITY_FLAG_IGNORE_UNKNOWN_CA
    :ignore-cert-wrong-usage    ,SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE
    :secure                     ,SECURITY_FLAG_SECURE
    :strength-medium            ,SECURITY_FLAG_STRENGTH_MEDIUM
    :strength-strong            ,SECURITY_FLAG_STRENGTH_STRONG
    :strength-weak              ,SECURITY_FLAG_STRENGTH_WEAK
    ))

(defvar *option-spn-type*
  `(:disable-spn-server-port    ,WINHTTP_DISABLE_SPN_SERVER_PORT
    :enable-spn-server-port     ,WINHTTP_ENABLE_SPN_SERVER_PORT
    ))

;; なにこれ?
;;
;; WINHTTP_OPTION_UNLOAD_NOTIFY_EVENT
;;
;;   WINHTTP_FLAG_SECURE_PROTOCOL_ALL
;;   ERROR_WINHTTP_INCORRECT_HANDLE_TYPE


(defvar *option-list*
  #| 凡例
    (:option-name
     ,option-const                                  Session? Request? Query? Set?  data-type
     [data-subtype [data-flags-alist]])
  |#
  `((:autologon-policy
     ,WINHTTP_OPTION_AUTOLOGON_POLICY               nil      t        nil    t     DWORD
     type ,*option-autologon-policy-type*)
    (:callback
     ,WINHTTP_OPTION_CALLBACK                       t        t        t      t     LPVOID)
    (:client-cert-context
     ,WINHTTP_OPTION_CLIENT_CERT_CONTEXT            nil      t        nil    t     CERT_CONTEXT)
    (:client-cert-issuer-list
     ,WINHTTP_OPTION_CLIENT_CERT_ISSUER_LIST        nil      t        t      nil   SecPkgContext_IssuerListInfoEx*)
    (:codepage
     ,WINHTTP_OPTION_CODEPAGE                       t        nil      nil    t     DWORD)
    (:configure-passport-auth
     ,WINHTTP_OPTION_CONFIGURE_PASSPORT_AUTH        t        nil      nil    t     DWORD
     type ,*option-configure-passport-auth-type*)
;    (:connect-info
;     ,WINHTTP_OPTION_CONNECT_INFO                   nil      t        t      nil   WINHTTP_CONNECTION_INFO)
    (:connect-retries
     ,WINHTTP_OPTION_CONNECT_RETRIES                t        t        t      t     DWORD)
    (:connect-timeout
     ,WINHTTP_OPTION_CONNECT_TIMEOUT                t        t        t      t     DWORD)
    (:context-value
     ,WINHTTP_OPTION_CONTEXT_VALUE                  t        t        t      t     DWORD_PTR)
    (:disable-feature
     ,WINHTTP_OPTION_DISABLE_FEATURE                nil      t        nil    t     DWORD
     types ,*option-disable-feature-flags*)
    (:enable-feature
     ,WINHTTP_OPTION_ENABLE_FEATURE                 t        t        nil    t     DWORD
     type ,*option-enable-feature-type*)
    (:enable-tracing
     ,WINHTTP_OPTION_ENABLETRACING                  nil      nil      t      t     BOOL)
    (:extended-error
     ,WINHTTP_OPTION_EXTENDED_ERROR                 t        t        t      nil   DWORD)
    (:global-proxy-creds
     ,WINHTTP_OPTION_GLOBAL_PROXY_CREDS             t        t        nil    t     WINHTTP_CREDS)
    (:global-server-creds
     ,WINHTTP_OPTION_GLOBAL_SERVER_CREDS            t        t        nil    t     WINHTTP_CREDS_EX)
    (:handle-type
     ,WINHTTP_OPTION_HANDLE_TYPE                    t        t        t      nil   DWORD
     type ,*option-handle-type*)
    (:http-version
     ,WINHTTP_OPTION_HTTP_VERSION                   t        t        t      t     HTTP_VERSION_INFO)
;    (:is-proxy-connect-response
;     ,WINHTTP_OPTION_IS_PROXY_CONNECT_RESPONSE      t        t        t      nil   BOOL)
    (:max-conns-per-1_0-server
     ,WINHTTP_OPTION_MAX_CONNS_PER_1_0_SERVER       t        nil      t      t     DWORD)
    (:max-conns-per-server
     ,WINHTTP_OPTION_MAX_CONNS_PER_SERVER           t        nil      t      t     DWORD)
    (:max-http-automatic-redirects
     ,WINHTTP_OPTION_MAX_HTTP_AUTOMATIC_REDIRECTS   t        t        t      t     DWORD)
    (:max-http-status-continue
     ,WINHTTP_OPTION_MAX_HTTP_STATUS_CONTINUE       t        t        t      t     DWORD)
    (:max-response-drain-size
     ,WINHTTP_OPTION_MAX_RESPONSE_DRAIN_SIZE        t        t        t      t     DWORD)
    (:max-response-header-size
     ,WINHTTP_OPTION_MAX_RESPONSE_HEADER_SIZE       t        t        t      t     DWORD)
    (:parent-handle
     ,WINHTTP_OPTION_PARENT_HANDLE                  t        t        t      nil   HINTERNET)
    (:passport-cobranding-text
     ,WINHTTP_OPTION_PASSPORT_COBRANDING_TEXT       nil      t        t      nil   LPWSTR)
    (:passport-cobranding-url
     ,WINHTTP_OPTION_PASSPORT_COBRANDING_URL        nil      t        t      nil   LPWSTR)
    (:passport-return-url
     ,WINHTTP_OPTION_PASSPORT_RETURN_URL            nil      t        t      nil   LPVOID)
    (:passport-sign-out
     ,WINHTTP_OPTION_PASSPORT_SIGN_OUT              t        nil      nil    t     LPVOID)
    (:password
     ,WINHTTP_OPTION_PASSWORD                       nil      t        t      t     LPWSTR)
    (:proxy
     ,WINHTTP_OPTION_PROXY                          t        t        t      t     WINHTTP_PROXY_INFO)
    (:proxy-password
     ,WINHTTP_OPTION_PROXY_PASSWORD                 nil      t        t      t     LPWSTR)
;    (:proxy-spn-used
;     ,WINHTTP_OPTION_PROXY_SPN_USED                 nil      t        t      nil   LPWSTR)
    (:proxy-username
     ,WINHTTP_OPTION_PROXY_USERNAME                 nil      t        t      t     LPWSTR)
    (:read-buffer-size
     ,WINHTTP_OPTION_READ_BUFFER_SIZE               nil      t        t      t     DWORD)
;    (:receive-proxy-connect-response
;     ,WINHTTP_OPTION_RECEIVE_PROXY_CONNECT_RESPONSE t        t        nil    t     BOOL)
    (:receive-timeout
     ,WINHTTP_OPTION_RECEIVE_TIMEOUT                t        t        t      t     DWORD)
    (:receive-response-timeout
     ,WINHTTP_OPTION_RECEIVE_RESPONSE_TIMEOUT       t        t        t      t     DWORD)
    (:redirect-policy
     ,WINHTTP_OPTION_REDIRECT_POLICY                t        t        t      t     DWORD
     type ,*option-redirect-policy-type*)
    (:reject-userpwd-in-url
     ,WINHTTP_OPTION_REJECT_USERPWD_IN_URL          nil      t        nil    t     BOOL)
    (:request-priority
     ,WINHTTP_OPTION_REQUEST_PRIORITY               nil      t        t      t     DWORD)
    (:resolve-timeout
     ,WINHTTP_OPTION_RESOLVE_TIMEOUT                t        t        t      t     DWORD)
    (:secure-protocols
     ,WINHTTP_OPTION_SECURE_PROTOCOLS               t        nil      nil    t     DWORD
     flags ,*option-secure-protocol-flags*)
    (:security-certificate-struct
     ,WINHTTP_OPTION_SECURITY_CERTIFICATE_STRUCT    nil      t        t      nil   WINHTTP_CERTIFICATE_INFO)
    (:security-flags
     ,WINHTTP_OPTION_SECURITY_FLAGS                 nil      t        t      t     DWORD
     flags ,*option-security-flags*)
    (:security-key-bitness
     ,WINHTTP_OPTION_SECURITY_KEY_BITNESS           nil      t        t      nil   DWORD)
    (:send-timeout
     ,WINHTTP_OPTION_SEND_TIMEOUT                   t        t        t      t     DWORD)
;    (:server-cbt
;     ,WINHTTP_OPTION_SERVER_CBT                     nil      t        t      nil   SecPkgContext_Bindings*)
    (:server-cert-context
     ,WINHTTP_OPTION_SERVER_CERT_CONTEXT            nil      t        t      nil   CERT_CONTEXT)
;    (:server-spn-used
;     ,WINHTTP_OPTION_SERVER_SPN_USED                nil      t        t      nil   LPWSTR)
    (:spn
     ,WINHTTP_OPTION_SPN                            nil      t        nil    t     DWORD
     type ,*option-spn-type*)
;    (:unload-notify-even
;     ,WINHTTP_OPTION_UNLOAD_NOTIFY_EVEN             t        nil      nil    t     HINTERNET)
    (:url
     ,WINHTTP_OPTION_URL                            nil      t        t      nil   LPWSTR)
    (:use-global-server-credentials
     ,WINHTTP_OPTION_USE_GLOBAL_SERVER_CREDENTIALS  t        t        nil    t     BOOL)
    (:user-agent
     ,WINHTTP_OPTION_USER_AGENT                     t        nil      t      t     LPWSTR)
    (:username
     ,WINHTTP_OPTION_USERNAME                       nil      t        t      t     LPWSTR)
    (:worker-thread-count
     ,WINHTTP_OPTION_WORKER_THREAD_COUNT            nil      nil      nil    t     DWORD)
    (:write-buffer-size
     ,WINHTTP_OPTION_WRITE_BUFFER_SIZE              nil      t        t      t     DWORD)
    ))


(defun option-name (option)
  (nth 0 option))

(defun option-const (option)
  (nth 1 option))

(defun option-accept-session-handle-p (option)
  (nth 2 option))

(defun option-accept-request-handle-p (option)
  (nth 3 option))

(defun option-can-query-p (option)
  (nth 4 option))

(defun option-can-set-p (option)
  (nth 5 option))

(defun option-data-type (option)
  (nth 6 option))

(defun option-data-subtype (option)
  (nth 7 option))

(defun option-data-flags-alist (option)
  (nth 8 option))

(defun find-option (option-name-or-const)
  (let ((search-key (etypecase option-name-or-const
                      (keyword #'option-name)
                      (integer #'option-const))))
    (or (find option-name-or-const *option-list* :key search-key)
        (error (format nil "未定義のオプションです: ~S~%有効な値: ~S"
                       option-name-or-const
                       (mapcar #'car *option-list*)
                       )))))


(provide "xl-winhttp/internal/options")

;;; End
