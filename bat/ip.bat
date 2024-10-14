@echo off

rem Check to see if the directory is already in PATH.
echo %PATH% | %SystemRoot%\System32\find /i "%1" 1>nul
if errorlevel 1 goto notfound
exit /b

if exist "%*" set PATH=%*;%PATH%
