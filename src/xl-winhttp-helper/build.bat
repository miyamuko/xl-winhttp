@echo off
setlocal

if not "%1"=="" (
  set TARGET=%1
) else (
  set TARGET=Release
)

if not "%2"=="" (
  set SLN=%2
) else (
  set SLN=xl-winhttp-helper.sln
)

set _CD=%CD%
cd %~dp0

msbuild %SLN% /p:Configuration=%TARGET%
if not %ERRORLEVEL%==0 goto :end

copy /Y %TARGET%\xl-winhttp-helper.dll ..\..\site-lisp\xl-winhttp\ffi
goto :end

:end

cd %_CD%
