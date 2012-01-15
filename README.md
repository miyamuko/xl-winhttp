# xl-winhttp - Windows HTTP Services for xyzzy Lisp

* Home URL: <http://miyamuko.s56.xrea.com/xyzzy/xl-winhttp/intro.htm>
* Version: 0.0.1


## SYNOPSIS

```lisp
(require "xl-winhttp")

(defparameter *winhttp-session* (make-hash-table :test #'equalp))

(defun winhttp-session (&rest args)
  ;; winhttp:open を実行すると WinHTTP 内でスレッドプールの初期化が行われるので
  ;; session は使いまわす
  (or (gethash args *winhttp-session*)
      (setf (gethash args *winhttp-session*)
            (apply #'winhttp:open args))))


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
    (winhttp:with-connect (conn (winhttp-session :user-agent "xl-winhttp/example") host port)
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
;; 非同期バージョン
;;

;; 非同期 GET
(defun http-get-async (url callback)
  (multiple-value-bind (scheme user pass host port path extra)
      ;; URL を分割
      (winhttp:crack-url url)
    ;; connection と request を作成
    ;; この時点では実際には接続されない
    (let* ((sess (winhttp-session :user-agent "xl-winhttp/async-example" :async t))
           (conn (winhttp:connect sess host port))
           (req (winhttp:open-request conn "GET" (format nil "~A~A" (or path "") (or extra ""))
                                      :accept "*/*"
                                      :secure (string= scheme "https"))))
      (winhttp:set-status-callback
       req #'(lambda (&rest args)
               (alexandria:destructuring-case args
                 ;; リクエスト送信完了
                 ((:send-request-complete req)
                  (winhttp:receive-response req))
                 ;; レスポンスヘッダ受信完了
                 ((:headers-available req)
                  (funcall callback :on-response req)
                  (winhttp:query-data-available req))
                 ;; レスポンスボディ受信チェック
                 ((:data-available req n)
                  (if (< 0 n)
                      (winhttp:read-data req n)
                    (winhttp:close-handle req)))
                 ;; レスポンスボディ受信
                 ((:read-complete req data n)
                  (funcall callback :on-data req data n)
                  (winhttp:query-data-available req))
                 ;; レスポンスボディ受信完了
                 ((:handle-closing req hinternet)
                  (funcall callback :on-end req))
                 ;; 送信エラー
                 ((:request-error req error)
                  (funcall callback :on-error req))
                 ((otherwise req &rest params)
                  (message "~S" (cons (car args) params)))
                 )))
      (winhttp:send-request req)
      )))

;; 非同期ダウンロード
(defun http-download-async (url localfile callback)
  (let ((output (open localfile :direction :output :encoding :binary))
        (content-length nil)
        (total 0))
    (http-get-async url #'(lambda (&rest args)
                            (alexandria:destructuring-case args
                              ((:on-response req)
                               (setf content-length
                                     (winhttp:query-response-header
                                      req :content-length :type :number)))
                              ((:on-data req data n)
                               (incf total n)
                               (princ data output)
                               (progress-message total content-length))
                              ((:on-end req)
                               (close output)
                               (funcall callback url localfile))
                              ))
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

Proxy や Basic/Digest 認証、SSL、非同期通信などは xml-http-request と同様に対応しています。


## INSTALL

1. [NetInstaller](http://www7a.biglobe.ne.jp/~hat/xyzzy/ni.html)
   で xl-winhttp, xl-alexandria, ansi-loop, ansify, setf-values をインストールします。

2. xl-winhttp はライブラリであるため自動的にロードはされません。
   必要な時点で require してください。


## TODO

* リファレンス
* reset-auto-proxy, create-proxy-resolver, get-proxy-for-url-ex
  - Windows 8 で追加された API への対応
* set-option, query-option
  - DWORD, WSTR, BOOL 型以外のオプションに対応


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
