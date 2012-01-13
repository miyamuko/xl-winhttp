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
    info->lpvStatusInformation = lpvStatusInformation;
    info->dwStatusInformationLength = dwStatusInformationLength;

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

    Debug(L"QueryWinHttpStatusCallbackInfoAvailable: %d", r);
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

    DebugCallbackInfo(L"TakeWinHttpStatusCallbackInfo", info);

    delete r;

    return TRUE;
}


void
DebugCallbackInfo(LPCWCHAR prefix, LPWINHTTP_STATUS_CALLBACK_INFO info)
{
#ifdef _DEBUG
    Debug(L"%s: handle=%p, context=%p, status=%p, info=%p, len=%d",
          prefix, info->hInternet, info->dwContext, info->dwInternetStatus,
          info->lpvStatusInformation, info->dwStatusInformationLength);
#endif // _DEBUG
}

void
Debug(LPCWCHAR format, ...)
{
#ifdef _DEBUG
    va_list ap;

#define BUF_SIZE 512
    WCHAR buf[BUF_SIZE];

    int prefix = swprintf_s(buf, BUF_SIZE, L"[%04d] xl-winhttp-helper: ", GetCurrentThreadId());

    va_start(ap,format);
    vswprintf_s(buf + prefix, BUF_SIZE - prefix, format, ap);
    va_end(ap);

    OutputDebugString(buf);
#endif // _DEBUG
}

/// End
