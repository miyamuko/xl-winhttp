// -*- mode: c; encoding: shift_jis -*-

/// src/xl-winhttp-helper/xl-winhttp-helper.cpp
//
// Copyright (c) 2012 MIYAMUKO Katsuyuki.
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

/// Code:

#include "stdafx.h"
#include "xl-winhttp-helper.h"


std::queue<LPWINHTTP_STATUS_CALLBACK_INFO> _queue;
CRITICAL_SECTION _lock;
BOOL _debug;

void
CALLBACK
WinHttpStatusCallback(HINTERNET hInternet,
                      DWORD_PTR dwContext,
                      DWORD dwInternetStatus,
                      LPVOID lpvStatusInformation,
                      DWORD dwStatusInformationLength)
{
    LPWINHTTP_STATUS_CALLBACK_INFO info = new WINHTTP_STATUS_CALLBACK_INFO;
    info->hInternet = hInternet;
    info->dwContext = dwContext;
    info->dwInternetStatus = dwInternetStatus;

    // READ_COMPLETE の場合は WinHttpReadData に指定したバッファなのでコピー不要
    // それ以外は一時的なバッファなのでコールバックを抜けると解放されるのでコピーしておく
    if (lpvStatusInformation != 0 && dwInternetStatus != WINHTTP_CALLBACK_STATUS_READ_COMPLETE)
    {
        size_t bytes;
        if (IsStatusInformationWSTR(dwInternetStatus))
            bytes = dwStatusInformationLength * sizeof(WCHAR);
        else
            bytes = dwStatusInformationLength;

        HGLOBAL copy = GlobalAlloc(GMEM_FIXED, bytes);
        CopyMemory(copy, lpvStatusInformation, bytes);

        info->lpvStatusInformation = copy;
        info->dwStatusInformationLength = dwStatusInformationLength;
        info->bNeedGlobalFree = TRUE;

        Debug(L"GlobalAlloc: %p (copy %d bytes from %p)", copy,, bytes, lpvStatusInformation);
    }
    else
    {
        info->lpvStatusInformation = lpvStatusInformation;
        info->dwStatusInformationLength = dwStatusInformationLength;
        info->bNeedGlobalFree = FALSE;
    }

    EnterCriticalSection(&_lock);
    _queue.push(info);
    LeaveCriticalSection(&_lock);

    DebugCallbackInfo(L"WinHttpStatusCallback", info);
}

XLWINHTTPHELPER_API
WINHTTP_STATUS_CALLBACK
GetWinHttpStatusCallbackAddress()
{
    WINHTTP_STATUS_CALLBACK r = WinHttpStatusCallback;

    Debug(L"GetWinHttpStatusCallbackAddress: %p", r);
    return r;
}

XLWINHTTPHELPER_API
BOOL
QueryWinHttpStatusCallbackInfoAvailable()
{
    EnterCriticalSection(&_lock);
    BOOL r = !_queue.empty();
    LeaveCriticalSection(&_lock);

    // 毎回出力するのは冗長すぎるのでデータがある場合のみ
    if (r) Debug(L"QueryWinHttpStatusCallbackInfoAvailable: %d", r);

    return r;
}

XLWINHTTPHELPER_API
BOOL
TakeWinHttpStatusCallbackInfo(LPWINHTTP_STATUS_CALLBACK_INFO info)
{
    if (!info) {
        Debug(L"TakeWinHttpStatusCallbackInfo: buffer is null");
        return FALSE;
    }

    LPWINHTTP_STATUS_CALLBACK_INFO r = 0;
    EnterCriticalSection(&_lock);
    if (!_queue.empty())
    {
        r = _queue.front();
        _queue.pop();
    }
    LeaveCriticalSection(&_lock);

    if (!r) {
        Debug(L"TakeWinHttpStatusCallbackInfo: queue is empty");
        return FALSE;
    }

    info->hInternet = r->hInternet;
    info->dwContext = r->dwContext;
    info->dwInternetStatus = r->dwInternetStatus;
    info->lpvStatusInformation = r->lpvStatusInformation;
    info->dwStatusInformationLength = r->dwStatusInformationLength;
    info->bNeedGlobalFree = r->bNeedGlobalFree;

    DebugCallbackInfo(L"TakeWinHttpStatusCallbackInfo", info);

    delete r;

    return TRUE;
}

XLWINHTTPHELPER_API
VOID
ToggleDebugOutput(BOOL enable)
{
    // ログを出力するため一時的に TRUE にする
    _debug = TRUE;
    Debug(L"ToggleDebugOutput: enable=%d", enable);

    _debug = enable;
}

BOOL
IsStatusInformationWSTR(DWORD dwInternetStatus)
{
    switch (dwInternetStatus)
    {
    case WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER:
    case WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER:
    case WINHTTP_CALLBACK_STATUS_NAME_RESOLVED:
    case WINHTTP_CALLBACK_STATUS_REDIRECT:
    case WINHTTP_CALLBACK_STATUS_RESOLVING_NAME:
        return TRUE;
    default:
        return FALSE;
    }
}


void
DebugCallbackInfo(LPCWCHAR prefix, LPWINHTTP_STATUS_CALLBACK_INFO info)
{
    if (!_debug) return;
    Debug(L"%s: handle=%p, context=%p, status=%p, info=%p, len=%d, needfree=%d",
          prefix, info->hInternet, info->dwContext, info->dwInternetStatus,
          info->lpvStatusInformation, info->dwStatusInformationLength, info->bNeedGlobalFree);
}

void
Debug(LPCWCHAR format, ...)
{
    va_list ap;
    if (!_debug) return;

#define BUF_SIZE 512
    WCHAR buf[BUF_SIZE];
    int prefix = swprintf_s(buf, BUF_SIZE, L"[%04d] xl-winhttp-helper: ", GetCurrentThreadId());

    va_start(ap,format);
    vswprintf_s(buf + prefix, BUF_SIZE - prefix, format, ap);
    va_end(ap);

    OutputDebugString(buf);
}

/// End
