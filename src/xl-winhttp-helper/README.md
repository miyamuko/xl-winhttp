# xl-winhttp-helper - WinHTTP からのコールバックを受け取るヘルパー DLL

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


## REMARKS

### ポーリング間隔

start-timer を使ったポーリングによるイベント監視は xml-http-request でも
行なっている。

xml-http-request では 0.3 秒間隔で監視している。xml-http-request では
XMLHTTP オブジェクト内でレスポンスをすべて受信した後に状態が変わるため、
0.3 秒間隔でも許容範囲内の遅延だと思われる。

WinHTTP ではデータを受信するたびにコールバックが呼び出され、
コールバック内から WinHttpReadData などを再び呼び出さないと
次のイベントが発火しない。

そのため、xml-http-request と同じ 0.3 秒間隔では遅延が許容できない
範囲になる可能性があるため、ポーリング間隔はアプリごとに指定可能とする。
