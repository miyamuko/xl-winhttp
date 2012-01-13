@echo off
setlocal

set TARGET=Release

set _CD=%CD%
cd %~dp0

msbuild xl-winhttp-helper.sln /p:Configuration=%TARGET%
if not %ERRORLEVEL%==0 goto :end

copy /Y %TARGET%\xl-winhttp-helper.dll ..\..\site-lisp\xl-winhttp\ffi
goto :end

:end

cd %_CD%
