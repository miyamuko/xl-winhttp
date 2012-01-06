; -*- mode: lisp; package: xl-winhttp; encoding: shift_jis -*-

;;; xl-winhttp/flags.l
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

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384098.aspx
(defvar *open-flags*
  `(:async                      ,WINHTTP_FLAG_ASYNC
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384099.aspx
(defvar *open-request-flags*
  `(:bypass-proxy-cache         ,WINHTTP_FLAG_BYPASS_PROXY_CACHE
    :escape-disable             ,WINHTTP_FLAG_ESCAPE_DISABLE
    :escape-disable-query       ,WINHTTP_FLAG_ESCAPE_DISABLE_QUERY
    :escape-percent             ,WINHTTP_FLAG_ESCAPE_PERCENT
    :null-codepage              ,WINHTTP_FLAG_NULL_CODEPAGE
    :refresh                    ,WINHTTP_FLAG_REFRESH
    :secure                     ,WINHTTP_FLAG_SECURE
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384087.aspx
(defvar *add-request-flags*
  `(:add                        ,WINHTTP_ADDREQ_FLAG_ADD
    :add-if-new                 ,WINHTTP_ADDREQ_FLAG_ADD_IF_NEW
    :coalesce                   ,WINHTTP_ADDREQ_FLAG_COALESCE
    :coalesce-with-comma        ,WINHTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA
    :coalesce-with-semicolon    ,WINHTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON
    :replace                    ,WINHTTP_ADDREQ_FLAG_REPLACE
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384092.aspx
(defvar *crack-url-flags*
  `(:decode                     ,ICU_DECODE
    :escape                     ,ICU_ESCAPE
    :reject-userpwd             ,ICU_REJECT_USERPWD
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384093.aspx
(defvar *create-url-flags*
  `(:escape                     ,ICU_ESCAPE
    :reject-userpwd             ,ICU_REJECT_USERPWD
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384123.aspx
(defvar *auto-proxy-flags*
  `(:auto-detect                ,WINHTTP_AUTOPROXY_AUTO_DETECT
    :config-url                 ,WINHTTP_AUTOPROXY_CONFIG_URL
    :run-inprocess              ,WINHTTP_AUTOPROXY_RUN_INPROCESS
    :run-outprocess-only        ,WINHTTP_AUTOPROXY_RUN_OUTPROCESS_ONLY
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384094.aspx
;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384123.aspx
(defvar *auto-detect-type-flags*
  `(:dhcp                       ,WINHTTP_AUTO_DETECT_TYPE_DHCP
    :dns_a                      ,WINHTTP_AUTO_DETECT_TYPE_DNS_A
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384100.aspx
;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384112.aspx
(defvar *auth-target-flags*
  `(:server                     ,WINHTTP_AUTH_TARGET_SERVER
    :proxy                      ,WINHTTP_AUTH_TARGET_PROXY
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384100.aspx
;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384112.aspx
(defvar *auth-scheme-flags*
  `(:basic                      ,WINHTTP_AUTH_SCHEME_BASIC
    :ntlm                       ,WINHTTP_AUTH_SCHEME_NTLM
    :passport                   ,WINHTTP_AUTH_SCHEME_PASSPORT
    :digest                     ,WINHTTP_AUTH_SCHEME_DIGEST
    :negotiate                  ,WINHTTP_AUTH_SCHEME_NEGOTIATE
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384070.aspx
(defvar *query-flags*
  `(:number                     ,WINHTTP_QUERY_FLAG_NUMBER
    :request-headers            ,WINHTTP_QUERY_FLAG_REQUEST_HEADERS
    :systemtime                 ,WINHTTP_QUERY_FLAG_SYSTEMTIME
    ))


;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384098.aspx
;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa383912.aspx
(defvar *access-type*
  `(:no-proxy                   ,WINHTTP_ACCESS_TYPE_NO_PROXY
    :default-proxy              ,WINHTTP_ACCESS_TYPE_DEFAULT_PROXY
    :named-proxy                ,WINHTTP_ACCESS_TYPE_NAMED_PROXY
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384078.aspx
(defvar *scheme-type*
  `(:http                       ,INTERNET_SCHEME_HTTP
    :https                      ,INTERNET_SCHEME_HTTPS
    ))

;; http://msdn.microsoft.com/en-us/library/windows/desktop/aa384070.aspx
(defvar *query-type*
  `(:accept                     ,WINHTTP_QUERY_ACCEPT
    :accept-charset             ,WINHTTP_QUERY_ACCEPT_CHARSET
    :accept-encoding            ,WINHTTP_QUERY_ACCEPT_ENCODING
    :accept-language            ,WINHTTP_QUERY_ACCEPT_LANGUAGE
    :accept-ranges              ,WINHTTP_QUERY_ACCEPT_RANGES
    :age                        ,WINHTTP_QUERY_AGE
    :allow                      ,WINHTTP_QUERY_ALLOW
    :authentication-info        ,WINHTTP_QUERY_AUTHENTICATION_INFO
    :authorization              ,WINHTTP_QUERY_AUTHORIZATION
    :cache-control              ,WINHTTP_QUERY_CACHE_CONTROL
    :connection                 ,WINHTTP_QUERY_CONNECTION
    :content-base               ,WINHTTP_QUERY_CONTENT_BASE
    :content-description        ,WINHTTP_QUERY_CONTENT_DESCRIPTION
    :content-disposition        ,WINHTTP_QUERY_CONTENT_DISPOSITION
    :content-encoding           ,WINHTTP_QUERY_CONTENT_ENCODING
    :content-id                 ,WINHTTP_QUERY_CONTENT_ID
    :content-language           ,WINHTTP_QUERY_CONTENT_LANGUAGE
    :content-length             ,WINHTTP_QUERY_CONTENT_LENGTH
    :content-location           ,WINHTTP_QUERY_CONTENT_LOCATION
    :content-md5                ,WINHTTP_QUERY_CONTENT_MD5
    :content-range              ,WINHTTP_QUERY_CONTENT_RANGE
    :content-transfer-encoding  ,WINHTTP_QUERY_CONTENT_TRANSFER_ENCODING
    :content-type               ,WINHTTP_QUERY_CONTENT_TYPE
    :cookie                     ,WINHTTP_QUERY_COOKIE
    :cost                       ,WINHTTP_QUERY_COST
    :custom                     ,WINHTTP_QUERY_CUSTOM
    :date                       ,WINHTTP_QUERY_DATE
    :derived-from               ,WINHTTP_QUERY_DERIVED_FROM
    :etag                       ,WINHTTP_QUERY_ETAG
    :expect                     ,WINHTTP_QUERY_EXPECT
    :expires                    ,WINHTTP_QUERY_EXPIRES
    :forwarded                  ,WINHTTP_QUERY_FORWARDED
    :from                       ,WINHTTP_QUERY_FROM
    :host                       ,WINHTTP_QUERY_HOST
    :if-match                   ,WINHTTP_QUERY_IF_MATCH
    :if-modified-since          ,WINHTTP_QUERY_IF_MODIFIED_SINCE
    :if-none-match              ,WINHTTP_QUERY_IF_NONE_MATCH
    :if-range                   ,WINHTTP_QUERY_IF_RANGE
    :if-unmodified-since        ,WINHTTP_QUERY_IF_UNMODIFIED_SINCE
    :link                       ,WINHTTP_QUERY_LINK
    :last-modified              ,WINHTTP_QUERY_LAST_MODIFIED
    :location                   ,WINHTTP_QUERY_LOCATION
    :max                        ,WINHTTP_QUERY_MAX
    :max-forwards               ,WINHTTP_QUERY_MAX_FORWARDS
    :message-id                 ,WINHTTP_QUERY_MESSAGE_ID
    :mime-version               ,WINHTTP_QUERY_MIME_VERSION
    :orig-uri                   ,WINHTTP_QUERY_ORIG_URI
    :pragma                     ,WINHTTP_QUERY_PRAGMA
    :proxy-authenticate         ,WINHTTP_QUERY_PROXY_AUTHENTICATE
    :proxy-authorization        ,WINHTTP_QUERY_PROXY_AUTHORIZATION
    :proxy-connection           ,WINHTTP_QUERY_PROXY_CONNECTION
    :proxy-support              ,WINHTTP_QUERY_PROXY_SUPPORT
    :public                     ,WINHTTP_QUERY_PUBLIC
    :range                      ,WINHTTP_QUERY_RANGE
    :raw-headers                ,WINHTTP_QUERY_RAW_HEADERS
    :raw-headers-crlf           ,WINHTTP_QUERY_RAW_HEADERS_CRLF
    :referer                    ,WINHTTP_QUERY_REFERER
    :refresh                    ,WINHTTP_QUERY_REFRESH
    :request-method             ,WINHTTP_QUERY_REQUEST_METHOD
    :retry-after                ,WINHTTP_QUERY_RETRY_AFTER
    :server                     ,WINHTTP_QUERY_SERVER
    :set-cookie                 ,WINHTTP_QUERY_SET_COOKIE
    :status-code                ,WINHTTP_QUERY_STATUS_CODE
    :status-text                ,WINHTTP_QUERY_STATUS_TEXT
    :title                      ,WINHTTP_QUERY_TITLE
    :transfer-encoding          ,WINHTTP_QUERY_TRANSFER_ENCODING
    :unless-modified-since      ,WINHTTP_QUERY_UNLESS_MODIFIED_SINCE
    :upgrade                    ,WINHTTP_QUERY_UPGRADE
    :uri                        ,WINHTTP_QUERY_URI
    :user-agent                 ,WINHTTP_QUERY_USER_AGENT
    :vary                       ,WINHTTP_QUERY_VARY
    :version                    ,WINHTTP_QUERY_VERSION
    :via                        ,WINHTTP_QUERY_VIA
    :warning                    ,WINHTTP_QUERY_WARNING
    :www-authenticate           ,WINHTTP_QUERY_WWW_AUTHENTICATE
    ))



(defun make-flag (value keyword-flag-alist &key (default 0) (flags t))
  (typecase value
    (null default)
    (integer value)
    (list
     (when (and (not flags)
                (< 1 (length value)))
       (error "フラグは複数指定できません: ~S" value))
     (apply #'logior
            (mapcar #'(lambda (flag)
                        (typecase flag
                          (integer flag)
                          (otherwise
                           (or (getf keyword-flag-alist flag)
                               (error (format nil "未定義のオプションです: ~S~%有効な値: ~S"
                                              flag (loop for (k v) on keyword-flag-alist by #'cddr
                                                         collect k)
                                              ))))))
                    value)))
    (otherwise
     (make-flag (list value) keyword-flag-alist))))

(defun unpack-flags (value keyword-flag-alist &key (flags t))
  (check-type value integer)
  (if flags
      (loop for (k v) on keyword-flag-alist by #'cddr
            when (= v (logand value v))
            collect k)
    (loop for (k v) on keyword-flag-alist by #'cddr
          when (= v value)
          return k)))


(provide "xl-winhttp/flags")

;;; End
