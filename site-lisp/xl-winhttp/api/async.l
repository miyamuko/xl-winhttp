; -*- mode: lisp; package: xl-winhttp.api; encoding: shift_jis -*-

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
  (require "xl-winhttp/api/package")
  (require "xl-winhttp/api/api")
  )

(in-package :xl-winhttp.api)

(export '(set-status-callback
          ))

(defparameter *event-dispatch-interval* 0.1)

;; Key:   handle
;; Value: (hinternet . callback)
(defparameter *callbacks* (make-hash-table))
(defparameter *callback-info* (make-WINHTTP_STATUS_CALLBACK_INFO))

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
  (check-type callback callable)
  (let ((handle (hinternet-handle hinternet)))
    (setf (gethash handle *callbacks*) (list hinternet callback))
    (WinHttpSetStatusCallback handle
                              (GetWinHttpStatusCallbackAddress)
                              (expand-flags *notification-flags*
                                            :default WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS)
                              0)
    (dispatch-later)
    ))

(defun dispatch-later (&optional (interval *event-dispatch-interval*))
  (when (< 0 (hash-table-count *callbacks*))
    (message "~S" interval)
    (start-timer interval 'event-dispatch t)))

(defun event-dispatch ()
  (when (< 0 (hash-table-count *callbacks*))
    (while (callback-info-available-p)
      (message "fire")
      (let ((info (take-callback-info)))
        (when info
          (ignore-errors
           (apply #'fire-event info)))))
    (dispatch-later)))

(defun fire-event (handle context status info size need-free-p)
  (let ((entry (gethash handle *callbacks*)))
    (when entry
      (destructuring-bind (hinternet callback) entry
        (let* ((status (unpack-flags status *internet-status-type* :flags nil))
               (info (unpack-info status info size need-free-p)))
          (when (and info (atom info))
            (setf info (list info)))
          (apply callback hinternet status info)
          )))))

(defun unpack-info (status info size need-free-p)
  (flet ((CSTR ()
           (unpack-CSTR-pointer info size :free need-free-p))
         (WSTR ()
           (unpack-WSTR-pointer info (1- size) :free need-free-p))
         (DWORD ()
           (unpack-DWORD-pointer info size :free need-free-p)))
    (ecase status
      ;; Closing the connection to the server. The lpvStatusInformation parameter
      ;; is NULL. This flag has been deprecated.
      (:closing-connection nil)

      ;; Successfully connected to the server. The lpvStatusInformation parameter
      ;; contains a pointer to an LPWSTR that indicates the IP address of the
      ;; server in dotted notation. This flag has been deprecated.
      (:connected-to-server (WSTR))

      ;; Connecting to the server. The lpvStatusInformation parameter contains a
      ;; pointer to an LPWSTR that indicates the IP address of the server in
      ;; dotted notation. This flag has been deprecated.
      (:connecting-to-server (WSTR))

      ;; Successfully closed the connection to the server. The
      ;; lpvStatusInformation parameter is NULL. This flag has been deprecated.
      (:connection-closed nil)

      ;; Data is available to be retrieved with WinHttpReadData. The
      ;; lpvStatusInformation parameter points to a DWORD that contains the
      ;; number of bytes of data available. The dwStatusInformationLength
      ;; parameter itself is 4 (the size of a DWORD).
      (:data-available (DWORD))

      ;; An HINTERNET handle has been created. The lpvStatusInformation parameter
      ;; contains a pointer to the HINTERNET handle.
      (:handle-created (DWORD))

      ;; This handle value has been terminated. The lpvStatusInformation
      ;; parameter contains a pointer to the HINTERNET handle. There will be no
      ;; more callbacks for this handle.
      (:handle-closing (DWORD))

      ;; The response header has been received and is available with
      ;; WinHttpQueryHeaders. The lpvStatusInformation parameter is NULL.
      (:headers-available nil)

      ;; Received an intermediate (100 level) status code message from the server.
      ;; The lpvStatusInformation parameter contains a pointer to a DWORD that
      ;; indicates the status code.
      (:intermediate-response (DWORD))

      ;; Successfully found the IP address of the server. The
      ;; lpvStatusInformation parameter contains a pointer to a LPWSTR that
      ;; indicates the name that was resolved. This flag has been deprecated.
      (:name-resolved (WSTR))

      ;; Data was successfully read from the server. The lpvStatusInformation
      ;; parameter contains a pointer to the buffer specified in the call to
      ;; WinHttpReadData. The dwStatusInformationLength parameter contains the
      ;; number of bytes read.
      (:read-complete (CSTR))

      ;; Waiting for the server to respond to a request. The lpvStatusInformation
      ;; parameter is NULL. This flag has been deprecated.
      (:receiving-response nil)

      ;; An HTTP request is about to automatically redirect the request. The
      ;; lpvStatusInformation parameter contains a pointer to an LPWSTR
      ;; indicating the new URL. At this point, the application can read any data
      ;; returned by the server with the redirect response and can query the
      ;; response headers. It can also cancel the operation by closing the handle.
      (:redirect (WSTR))

      ;; An error occurred while sending an HTTP request. The
      ;; lpvStatusInformation parameter contains a pointer to a
      ;; WINHTTP_ASYNC_RESULT structure, of which the dwResult member indicates
      ;; the return value of the function and any error codes that apply.
      (:request-error
       (let ((&result (make-WINHTTP_ASYNC_RESULT nil info)))
         (cons (ecase (WINHTTP_ASYNC_RESULT-dwResult &result)
                 (API_RECEIVE_RESPONSE 'receive-response)
                 (API_QUERY_DATA_AVAILABLE 'query-data-available)
                 (API_READ_DATA 'read-data)
                 (API_WRITE_DATA 'write-data)
                 (API_SEND_REQUEST 'send-request))
               (multiple-value-list
                (get-last-error (WINHTTP_ASYNC_RESULT-dwError &result))))))
      ;; Successfully sent the information request to the server. The
      ;; lpvStatusInformation parameter contains a pointer to a DWORD indicating
      ;; the number of bytes sent. This flag has been deprecated.
      (:request-sent (DWORD))

      ;; Looking up the IP address of a server name. The lpvStatusInformation
      ;; parameter contains a pointer to the server name being resolved. This
      ;; flag has been deprecated.
      (:resolving-name (WSTR))

      ;; Successfully received a response from the server. The
      ;; lpvStatusInformation parameter contains a pointer to a DWORD indicating
      ;; the number of bytes received. This flag has been deprecated.
      (:response-received (DWORD))

      ;; One or more errors were encountered while retrieving a Secure Sockets
      ;; Layer (SSL) certificate from the server. The lpvStatusInformation
      ;; parameter contains a flag. For more information, see the description for
      ;; lpvStatusInformation.
      (:secure-failure (unpack-flags info *secure-failure-infomation-type*))

      ;; Sending the information request to the server. The lpvStatusInformation
      ;; parameter is NULL. This flag has been deprecated.
      (:sending-request nil)

      ;; The request completed successfully. The lpvStatusInformation parameter
      ;; is NULL.
      (:send-request-complete nil)

      ;; Data was successfully written to the server. The lpvStatusInformation
      ;; parameter contains a pointer to a DWORD that indicates the number of
      ;; bytes written.
      (:write-complete (DWORD))

;      (:getproxyforurl-complete)
      )))

(defun callback-info-available-p ()
  (unpack-BOOL (QueryWinHttpStatusCallbackInfoAvailable)))

(defun take-callback-info ()
  (when (unpack-BOOL (TakeWinHttpStatusCallbackInfo *callback-info*))
    (list (WINHTTP_STATUS_CALLBACK_INFO-hInternet *callback-info*)
          (WINHTTP_STATUS_CALLBACK_INFO-dwContext *callback-info*)
          (WINHTTP_STATUS_CALLBACK_INFO-dwInternetStatus *callback-info*)
          (WINHTTP_STATUS_CALLBACK_INFO-lpvStatusInformation *callback-info*)
          (WINHTTP_STATUS_CALLBACK_INFO-dwStatusInformationLength *callback-info*)
          (unpack-BOOL (WINHTTP_STATUS_CALLBACK_INFO-bNeedGlobalFree *callback-info*))
          )))


(provide "xl-winhttp/api/async")

;;; End
