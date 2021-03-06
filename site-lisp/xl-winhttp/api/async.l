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
  )

(in-package :xl-winhttp.api)

;;; hinternet の管理

(defvar *async-hinternet-registry* (make-hash-table)
  "handle から hinternet を取得するために作成した hinternet を保存する

Key: HINTERNET handle
Value: hinternet struct
")

(defun register-async-hinternet (hinternet callback)
  (setf (hinternet-callback hinternet) callback)
  (setf (gethash (hinternet-handle hinternet)
                 *async-hinternet-registry*)
        hinternet)
  (debug "register-async-hinternet: ~S" hinternet))

(defun unregister-async-hinternet (hinternet)
  (remhash (hinternet-handle hinternet)
           *async-hinternet-registry*)
  (debug "unregister-async-hinternet: ~S" hinternet))

(defun find-async-hinternet (handle)
  (gethash handle *async-hinternet-registry*))

(defun async-hinternet-available-p ()
  (< 0 (hash-table-count *async-hinternet-registry*)))


;;; イベント処理

(defparameter *event-dispatch-interval* 0.1)
(defparameter *event-dispatch-time-slice* 0.1)

(defun dispatch-event-later (&optional (interval *event-dispatch-interval*))
  (when (async-hinternet-available-p)
    (start-timer interval 'dispatch-event t)))

(defun dispatch-event ()
  (when (async-hinternet-available-p)
    (let ((start (get-internal-real-time)))
      (while (and (callback-info-available-p)
                  (< (/ (- (get-internal-real-time) start) 1000.0)
                     *event-dispatch-time-slice*))
        (handler-case
            (dispatch-event1)
          (error (c)
            (debug "Error in dispatcher: ~A" c)
            (message  "Error in dispatcher: ~A" c)))))
    (dispatch-event-later)))

(defun dispatch-event1 ()
  (when-let (cb (take-callback-info))
    (multiple-value-bind (event hinternet args)
        (apply #'unpack-callback-info cb)
      ;; trace log
      (if (eql event :read-complete)
          (trace "Event: ~A (<snip> ~A): ~S" event (cadr args) hinternet)
        (trace "Event: ~A ~S: ~S" event args hinternet))
      (unless hinternet
        (error (format nil "Unmanaged HINTERNET event received: ~S" cb)))
      (unwind-protect
          (let ((fn (hinternet-callback hinternet)))
            (handler-case
                (apply fn event hinternet args)
              (quit (c)
                (funcall fn :callback-quit hinternet c))
              (error (c)
                (funcall fn :callback-error hinternet c))
              ))
        (when (eq :handle-closing event)
         ;; see close-handle at api.l
          (setf (hinternet-closed-p hinternet) t)
          (unregister-async-hinternet hinternet)))
      )))


;;; WINHTTP_STATUS_CALLBACK_INFO

(defparameter *callback-info-buffer* (make-WINHTTP_STATUS_CALLBACK_INFO))

(defun callback-info-available-p ()
  (unpack-BOOL (QueryWinHttpStatusCallbackInfoAvailable)))

(defun take-callback-info (&optional (buffer *callback-info-buffer*))
  (when (unpack-BOOL (TakeWinHttpStatusCallbackInfo buffer))
    (list (WINHTTP_STATUS_CALLBACK_INFO-hInternet buffer)
          (WINHTTP_STATUS_CALLBACK_INFO-dwContext buffer)
          (WINHTTP_STATUS_CALLBACK_INFO-dwInternetStatus buffer)
          (WINHTTP_STATUS_CALLBACK_INFO-lpvStatusInformation buffer)
          (WINHTTP_STATUS_CALLBACK_INFO-dwStatusInformationLength buffer)
          (unpack-BOOL (WINHTTP_STATUS_CALLBACK_INFO-bNeedGlobalFree buffer))
          )))

(defun unpack-callback-info (handle context status info size need-free-p)
  (when-let ((hinternet (find-async-hinternet handle)))
    (let* ((event (unpack-flags status *internet-status-type* :flags nil))
           (args (unless (nullp info)
                   (unwind-protect
                       (ensure-list
                        (unpack-status-infomation event info size))
                     (when need-free-p
                       (global-free info))))))
      (values event hinternet args)
      )))

(defun unpack-status-infomation (status info size)
  (labels ((LPCSTR ()
             (list (unpack-CSTR-pointer info size) size))
           (LPWSTR ()
             ;; size は NULL 文字を含む
             (unpack-WSTR-pointer info (1- size)))
           (LPDWORD ()
             (unpack-DWORD-pointer info size))
           (LPHINTERNET ()
             (LPDWORD))
           (LPWINHTTP_ASYNC_RESULT ()
             (multiple-value-bind (type error-code)
                 (unpack-WINHTTP_ASYNC_RESULT (make-WINHTTP_ASYNC_RESULT nil info))
               (let ((err (create-winhttp-condition (ecase type
                                                      (:receive-response 'WinHttpReceiveResponse)
                                                      (:query-data-available 'WinHttpQueryDataAvailable)
                                                      (:read-data 'WinHttpReadData)
                                                      (:write-data 'WinHttpWriteData)
                                                      (:send-request 'WinHttpSendRequest))
                                                    error-code)))
                 (warn "WINHTTP_ASYNC_RESULT: ~A" err)
                 (list type err))))
           (SECURE_FAILURE ()
             (unpack-flags info *secure-failure-infomation-type*))
           )
    (ecase status
      (:closing-connection nil)
      (:connected-to-server (LPWSTR))
      (:connecting-to-server (LPWSTR))
      (:connection-closed nil)
      (:data-available (LPDWORD))
      (:handle-created (LPHINTERNET))
      (:handle-closing (LPHINTERNET))
      (:headers-available nil)
      (:intermediate-response (LPDWORD))
      (:name-resolved (LPWSTR))
      (:read-complete (LPCSTR))
      (:receiving-response nil)
      (:redirect (LPWSTR))
      (:request-error (LPWINHTTP_ASYNC_RESULT))
      (:request-sent (LPDWORD))
      (:resolving-name (LPWSTR))
      (:response-received (LPDWORD))
      (:secure-failure (SECURE_FAILURE))
      (:sending-request nil)
      (:send-request-complete nil)
      (:write-complete (LPDWORD))
      ;(:getproxyforurl-complete)
      )))


(provide "xl-winhttp/api/async")

;;; End
