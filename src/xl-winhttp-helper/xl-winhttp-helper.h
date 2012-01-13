// -*- mode: c; encoding: shift_jis -*-

/// src/xl-winhttp-helper/xl-winhttp-helper.h
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

#pragma once

#include <queue>

// �ȉ��� ifdef �u���b�N�� DLL ����̃G�N�X�|�[�g��e�Ղɂ���}�N�����쐬���邽�߂�
// ��ʓI�ȕ��@�ł��B���� DLL ���̂��ׂẴt�@�C���́A�R�}���h ���C���Œ�`���ꂽ XLWINHTTPHELPER_EXPORTS
// �V���{���ŃR���p�C������܂��B���̃V���{���́A���� DLL ���g���v���W�F�N�g�Œ�`���邱�Ƃ͂ł��܂���B
// �\�[�X�t�@�C�������̃t�@�C�����܂�ł��鑼�̃v���W�F�N�g�́A
// XLWINHTTPHELPER_API �֐��� DLL ����C���|�[�g���ꂽ�ƌ��Ȃ��̂ɑ΂��A���� DLL �́A���̃}�N���Œ�`���ꂽ
// �V���{�����G�N�X�|�[�g���ꂽ�ƌ��Ȃ��܂��B
#ifdef XLWINHTTPHELPER_EXPORTS
#define XLWINHTTPHELPER_API __declspec(dllexport)
#else
#define XLWINHTTPHELPER_API __declspec(dllimport)
#endif

// �\���̒�`
typedef struct
{
    HINTERNET hInternet;
    DWORD_PTR dwContext;
    DWORD dwInternetStatus;
    LPVOID lpvStatusInformation;
    DWORD dwStatusInformationLength;
    BOOL bNeedGlobalFree;
}
WINHTTP_STATUS_CALLBACK_INFO, * LPWINHTTP_STATUS_CALLBACK_INFO;

// �O���[�o���ϐ�
extern std::queue<LPWINHTTP_STATUS_CALLBACK_INFO> _queue;
extern CRITICAL_SECTION _lock;

// �����֐��錾
BOOL
IsStatusInformationWSTR(DWORD dwInternetStatus);
void
DebugCallbackInfo(LPCWCHAR prefix, LPWINHTTP_STATUS_CALLBACK_INFO info);
void
Debug(LPCWCHAR format, ...);

// xyzzy ����Ăяo���֐��錾
#ifdef __cplusplus
extern "C" {
#endif

XLWINHTTPHELPER_API
WINHTTP_STATUS_CALLBACK
GetWinHttpStatusCallbackAddress();

XLWINHTTPHELPER_API
BOOL
QueryWinHttpStatusCallbackInfoAvailable();

XLWINHTTPHELPER_API
BOOL
TakeWinHttpStatusCallbackInfo(LPWINHTTP_STATUS_CALLBACK_INFO info);

#ifdef __cplusplus
}
#endif

/// End
