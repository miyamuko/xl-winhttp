# xl-winhttp-helper - WinHTTP からのコールバックを受け取るヘルパー DLL

----

## DESCRIPTION

WinHTTP のコールバックは WinHTTP 内のスレッドから呼ばれる。

c:defun-c-callable で作成したコールバック関数はスレッドセーフではないため(?)、
WinHTTP に渡すとコールバック時に xyzzy がクラッシュする場合がある。

そこで、WinHTTP からのコールバックを受け取る関数を C++ で作成する。
そのコールバック関数では受け取った引数を DLL 内のキューに保存する。

xyzzy からは start-timer でポーリングしてキューの状態を監視し、
状態の変更があったらキューから引数を読みだして処理するようにする。

<a href="https://cacoo.com/diagrams/SEHjYu1oCSCjpgkP">
<img src="https://cacoo.com/diagrams/SEHjYu1oCSCjpgkP-5783A.png">
</a>

----

## REMARKS

### ポーリング間隔

start-timer を使ったポーリングによるイベント監視は xml-http-request でも
行なっている。

xml-http-request では 0.1 秒間隔で監視している。xml-http-request では
XMLHTTP オブジェクト内でレスポンスをすべて受信した後に状態が変わるため、
0.1 秒間隔でも許容範囲内の遅延だと思われる。

WinHTTP ではデータを受信するたびにコールバックが呼び出され、
コールバック内から WinHttpReadData などを再び呼び出さないと
次のイベントが発火しない。

そのため、xml-http-request と同じ 0.1 秒間隔では遅延が許容できない
範囲になる可能性があるため、ポーリング間隔はアプリごとに指定可能とする。


### イベント一覧

<table>
  <tr>
    <th rowspan="3">イベント</th>
    <th>lpvStatusInformation の型</th>
  </tr>
  <tr><th>lpvStatusInformation の値</th></tr>
  <tr><th>備考</th></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION</td>
    <td>-</td>
  </tr>
  <tr><td>NULL</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER</td>
    <td>LPWSTR</td>
  </tr>
  <tr><td>IP アドレス</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER</td>
    <td>LPWSTR</td>
  </tr>
  <tr><td>IP アドレス</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED</td>
    <td>-</td>
  </tr>
  <tr><td>NULL</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE</td>
    <td>LPDWORD</td>
  </tr>
  <tr><td>読み込み可能なバイト数</td></tr>
  <tr><td>-</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_HANDLE_CREATED</td>
    <td>LPHINTERNET</td>
  </tr>
  <tr><td>ハンドル</td></tr>
  <tr><td>-</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING</td>
    <td>LPHINTERNET</td>
  </tr>
  <tr><td>ハンドル</td></tr>
  <tr><td>-</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE</td>
    <td>-</td>
  </tr>
  <tr><td>NULL</td></tr>
  <tr><td>WinHttpQueryHeaders で読み取り可能</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE</td>
    <td>LPDWORD</td>
  </tr>
  <tr><td>HTTP ステータスコード</td></tr>
  <tr><td>100 番台の場合</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_NAME_RESOLVED</td>
    <td>LPWSTR</td>
  </tr>
  <tr><td>IP アドレス</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_READ_COMPLETE</td>
    <td>LPVOID</td>
  </tr>
  <tr><td>WinHttpReadData で指定したバッファ</td></tr>
  <tr><td>-</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE</td>
    <td>-</td>
  </tr>
  <tr><td>NULL</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_REDIRECT</td>
    <td>LPWSTR</td>
  </tr>
  <tr><td>リダイレクト先の URL</td></tr>
  <tr><td>WinHttpQueryHeaders でリダイレクト前のヘッダを読み取り可能</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_REQUEST_ERROR</td>
    <td>LPWINHTTP_ASYNC_RESULT</td>
  </tr>
  <tr><td>WINHTTP_ASYNC_RESULT (失敗した API とエラーコード)</td></tr>
  <tr><td>-</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_REQUEST_SENT</td>
    <td>LPDWORD</td>
  </tr>
  <tr><td>送信したバイト数</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_RESOLVING_NAME</td>
    <td>LPWSTR</td>
  </tr>
  <tr><td>ホスト名</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED</td>
    <td>LPDWORD</td>
  </tr>
  <tr><td>受信したバイト数</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_SECURE_FAILURE</td>
    <td>DWORD</td>
  </tr>
  <tr><td>WINHTTP_CALLBACK_STATUS_FLAG_XXX が格納</td></tr>
  <tr><td>-</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_SENDING_REQUEST</td>
    <td>-</td>
  </tr>
  <tr><td>NULL</td></tr>
  <tr><td>deprecated</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE</td>
    <td>-</td>
  </tr>
  <tr><td>NULL</td></tr>
  <tr><td>-</td></tr>
  <tr>
    <td rowspan="3">WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE</td>
    <td>LPDWORD</td>
  </tr>
  <tr><td>送信したバイト数</td></tr>
  <tr><td>-</td></tr>
</table>

