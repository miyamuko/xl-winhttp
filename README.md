# xl-winhttp - Windows HTTP Services for xyzzy Lisp

* Home URL: http://miyamuko.s56.xrea.com/xyzzy/xl-winhttp/intro.htm
* Version: 0.0.1


## SYNOPSIS

```lisp
(require "xl-winhttp")

(defun http-get (url)
  (multiple-value-bind (scheme user pass host port path extra)
      (winhttp:crack-url url)
    (winhttp:with-open (session :user-agent "xl-winhttp/0.0.1")
      (winhttp:with-connect (conn session host port)
        (winhttp:with-open-request (req conn "GET" (format nil "~A~A" path (or extra ""))
                                        :flags (if (string= scheme "https")
                                                   winhttp.ffi:WINHTTP_FLAG_SECURE
                                                 winhttp.ffi:NULL))
          (winhttp:send-request req)
          (winhttp:receive-response req)
          (let (body (total 0))
            (long-operation
              (loop
                (let ((n (winhttp:query-data-available req)))
                  (when (<= n 0)
                    (return))
                  (incf total n)
                  (push (winhttp:read-data req n) body))
                (message "~D bytes" total)))
            (values
             (format nil "~{~A~}" (nreverse body))
             (split-string (winhttp:query-headers req winhttp.ffi:WINHTTP_QUERY_RAW_HEADERS)
                           #\NUL)
             )))))))

;; SSL
(http-get "https://www.hatena.ne.jp/login")
"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
  ...
"
("HTTP/1.1 200 OK" "Cache-Control: no-cache" "Connection: Keep-Alive" ...)

;; Shift_JIS (charset なし) (xhr だと化ける)
(alexandria:write-string-into-file
 (http-get "http://miyamuko.s56.xrea.com/xyzzy/package.l") "package.l")

;; 中国語(簡体字) (xhr だと化ける)
(alexandria:write-string-into-file
 (http-get "http://www.baidu.com/s?wd=xyzzy") "baidu.html")
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
   で xl-winhttp をインストールします。

2. xl-winhttp はライブラリであるため自動的にロードはされません。
   必要な時点で require してください。


## TODO

* 非同期
* リファレンス
* オプションをキーワードで指定できるようにする

  ```lisp
  (winhttp:with-open-request (req conn "GET" "/") :flags :secure)
    ...)
  ```


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
