# xl-winhttp - Windows HTTP Services for xyzzy Lisp

* Home URL: <http://miyamuko.s56.xrea.com/xyzzy/xl-winhttp/intro.htm>
* Version: 0.0.1


## SYNOPSIS

```lisp
(require "xl-winhttp")

(defparameter *winhttp-session* nil)

(defun winhttp-session ()
  ;; winhttp:open を実行すると WinHTTP 内でスレッドプールの初期化が行われるので
  ;; session は使いまわす
  (or *winhttp-session*
      (setf *winhttp-session*
            (winhttp:open :user-agent "xl-winhttp/example"))))

;;
;; 同期バージョン
;;

;; 同期 GET
(defun http-get (url &key (accept-language '("ja" "en-US;q=0.8" "en;q=0.6")))
  (multiple-value-bind (scheme user pass host port path extra)
      ;; URL を分割
      (winhttp:crack-url url)
    ;; connection と request を作成
    ;; この時点では実際には接続されない
    (winhttp:with-connect (conn (winhttp-session) host port)
      (winhttp:with-open-request (req conn "GET" (format nil "~A~A" (or path "") (or extra ""))
                                      :secure (string= scheme "https"))
        ;; Accept-Language ヘッダを設定
        (dolist (lang accept-language)
          (winhttp:add-request-headers req `(:Accept-Language ,lang) :coalesce-with-comma))
        ;; リクエスト送信
        (winhttp:send-request req :headers `(:X-Yzzy-Version ,(software-version)))
        ;; レスポンスを待つ
        (winhttp:receive-response req)
        ;; レスポンスボディを読み込む
        (let ((body nil)
              (total 0)
              (content-length (winhttp:query-response-header req :content-length :type :number)))
          (long-operation
            (loop
              (let ((n (winhttp:query-data-available req)))
                (when (<= n 0)
                  (return))
                (multiple-value-bind (data n)
                    (winhttp:read-data req n)
                  (incf total n)
                  (push data body))
                (do-events)
                (progress-message total content-length)
                )))
          ;; レスポンスボディ、ステータスコード、リクエストヘッダ、レスポンスヘッダを多値で返す
          (values
           (format nil "~{~A~}" (nreverse body))
           (winhttp:query-response-header req :status-code :type :number)
           (split-string (winhttp:query-request-header req :raw-headers) #\NUL)
           (split-string (winhttp:query-response-header req :raw-headers) #\NUL)
           ))))))

;;
;; start-timer を利用したなんちゃって非同期バージョン
;;
(defparameter *winhttp-connection* nil)
(defparameter *winhttp-request* nil)
(defparameter *winhttp-worker-state* nil)
(defparameter *winhttp-worker-callback* nil)

;; 非同期 GET
(defun http-get-async (url callback)
  (multiple-value-bind (scheme user pass host port path extra)
      ;; URL を分割
      (winhttp:crack-url url)
    ;; connection と request を作成
    ;; この時点では実際には接続されない
    (setf *winhttp-connection*
          (winhttp:connect (winhttp-session) host port))
    (setf *winhttp-request*
          (winhttp:open-request *winhttp-connection* "GET" (format nil "~A~A" (or path "") (or extra ""))
                                :accept "*/*"
                                :secure (string= scheme "https")))
    ;; 非同期処理を開始
    (setf *winhttp-worker-callback* callback)
    (dispatch-winhttp-async-worker 'send-request)))

(defun dispatch-winhttp-async-worker (next-state)
  (setf *winhttp-worker-state* next-state)
  (start-timer 0 'do-winhttp-async-worker t))

(defun do-winhttp-async-worker ()
  (case *winhttp-worker-state*
    (send-request
     ;; リクエスト送信
     (winhttp:send-request *winhttp-request* :headers `(:X-Yzzy-Version ,(software-version)))
     (dispatch-winhttp-async-worker 'receive-response))
    (receive-response
     ;; レスポンスを待つ
     (winhttp:receive-response *winhttp-request*)
     (funcall *winhttp-worker-callback*
              'on-response *winhttp-request*)
     (dispatch-winhttp-async-worker 'read-data))
    (read-data
     ;; レスポンスボディを読み込む
     (let ((n (winhttp:query-data-available *winhttp-request*)))
       (if (<= n 0)
           (dispatch-winhttp-async-worker 'end-data)
         (multiple-value-bind (data n)
             (winhttp:read-data *winhttp-request* n)
           (funcall *winhttp-worker-callback*
                    'on-read-data *winhttp-request* data n)
           (dispatch-winhttp-async-worker 'read-data)))))
    (end-data
     ;; レスポンスボディの読み込み完了
     (funcall *winhttp-worker-callback*
              'on-end-data *winhttp-request*)
     (dispatch-winhttp-async-worker 'cleanup))
    (cleanup
     ;; connection と request ハンドルを閉じる
     (winhttp:close-handle *winhttp-request*)
     (winhttp:close-handle *winhttp-connection*)
     (setf *winhttp-connection* nil
           *winhttp-request* nil
           *winhttp-worker-state* nil
           *winhttp-worker-callback* nil))
    (t
     ;; バグってる
     (msgbox "Error: ~S" *winhttp-worker-state*)
     (dispatch-winhttp-async-worker 'cleanup))))


;; 非同期ダウンロード
(defun http-download-async (url localfile callback)
  (let ((output (open localfile :direction :output :encoding :binary))
        (content-length nil)
        (total 0))
    (http-get-async url #'(lambda (state req &optional data n)
                            (case state
                              (on-response
                               (setf content-length
                                     (winhttp:query-response-header
                                      req :content-length :type :number)))
                              (on-read-data
                               (incf total n)
                               (princ data output)
                               (progress-message total content-length))
                              (on-end-data
                               (close output)
                               (funcall callback url localfile))))
                    )))

(defun progress-message (total-read content-length)
  (if content-length
      (message "~:D/~:D bytes (~D%)" total-read content-length
               (floor (* 100 (/ total-read content-length))))
    (message "~:D bytes" total-read)))


;; SSL
(http-get "https://twitter.com/" :accept-language '("en-us"))
;=> "<!DOCTYPE html>
;          :
;   "
;   200
;   ("GET / HTTP/1.1" "Accept-Language: en-us" "X-Yzzy-Version: 0.2.2.235" "User-Agent: xl-winhttp/example" ...)
;   ("HTTP/1.1 200 OK" "Date: Tue, 10 Jan 2012 08:10:47 GMT" "Status: 200 OK" "X-Transaction: 83ad207851e77640" ...)


;; 中国語(簡体字) (xhr だと化ける)
(http-get "http://www.baidu.com/s?wd=xyzzy")


;; Shift_JIS (charset なし) (xhr だと化ける)
(http-get "http://miyamuko.s56.xrea.com/xyzzy/package.l")


;; バイナリファイル
(http-download-async "http://www.jsdlab.co.jp/~kamei/cgi-bin/download.cgi"
                     "xyzzy-0.2.2.235.lzh"
                     #'(lambda (url localfile)
                         (msgbox "ダウンロードが完了しました。~%URL: ~A~%File: ~A~%MD5: ~A"
                                 url localfile
                                 (with-open-file (s localfile :encoding :binary)
                                   (si:md5 s)))))
```


## DESCRIPTION

xl-winhttp は [Windows HTTP Services](http://msdn.microsoft.com/en-us/library/windows/desktop/aa384273.aspx)
を利用した HTTP 通信を行うためのライブラリです。

[xml-http-request](http://miyamuko.s56.xrea.com/xyzzy/xml-http-request/intro.htm)
と比べて低レベルなライブラリですが、xml-http-request では取得出来なかった以下のようなデータも取得可能です。

  * チャンク形式のエンコーディング (Transfer-Encoding: chunked)
  * バイナリファイルの取得
  * 文字エンコーディングを自動的に変換しないため、charset などが不適切でも文字化けしません

Proxy や Basic/Digest 認証、SSL などは xml-http-request と同様に対応しています。

なお、非同期通信はまだサポートしていません（サポート予定はあります）。


## INSTALL

1. [NetInstaller](http://www7a.biglobe.ne.jp/~hat/xyzzy/ni.html)
   で xl-winhttp, ansi-loop, ansify をインストールします。

2. xl-winhttp はライブラリであるため自動的にロードはされません。
   必要な時点で require してください。


## TODO

* 非同期
* リファレンス
* reset-auto-proxy, create-proxy-resolver, get-proxy-for-url-ex
  - Windows 8 で追加された API への対応
* set-option, query-option
  - DWORD, WSTR 型以外のオプションに対応
  - (query-option r :security-flags) などをキーワードで返す
* check-type を徹底的に


## KNOWN BUGS

なし。

要望やバグは
[GitHub Issues](http://github.com/miyamuko/xl-winhttp/issues) か
[@miyamuko](http://twitter.com/home?status=%40miyamuko%20%23xyzzy%20xl-winhttp%3a%20)
まで。


## AUTHOR

みやむこ かつゆき (<mailto:miyamuko@gmail.com>)


## COPYRIGHT

xl-winhttp は MIT/X ライセンスに従って本ソフトウェアを使用、再頒布することができます。

    Copyright (c) 2011-2012 MIYAMUKO Katsuyuki.

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
