@echo off
set SRC=C:\src
if "%ORIGPATH%" == "" goto l1
set ORIGPATH=%PATH%
set checkpath=1

:l1
rem We want to have full control over the path, so set the whole thing
rem explicitly.
rem TODO: For some reason it seems like I can only put one SET PATH inside
rem an if block.
set PATH=%USERPROFILE%\bat
if not exist "%USERPROFILE%\scoop" goto l2
set PATH=%PATH%;%USERPROFILE%\scoop\apps\python312\current\Scripts
set PATH=%PATH%;%USERPROFILE%\scoop\apps\python312\current
set PATH=%PATH%;%USERPROFILE%\scoop\shims

:l2
if not exist "%SRC%\depot_tools" goto l3
set PATH=%PATH%;%SRC%\depot_tools

:l3
set PATH=%PATH%;%SystemRoot%\System32
set PATH=%PATH%;%SystemRoot%
set PATH=%PATH%;%SystemRoot%\Wbem

if not exist %PATH%;%ProgramFiles%\PowerShell\7 goto l4
set PATH=%PATH%;%ProgramFiles%\PowerShell\7

:l4
set PATH=%PATH%;%SystemRoot%\System32\WindowsPowerShell\v1.0
if not exist "%ProgramFiles%\Git Google Extras" goto l5
set PATH=%PATH%;%ProgramFiles%\Git Google Extras

:l5
if not exist "C:\msys64\usr\bin" goto l5
set PATH=%PATH%;C:\msys64\usr\bin
set PATH=%PATH%;C:\msys64\bin

:l5
rem TODO: Consider adding visual studio dirs and win sdk dirs.
rem "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvarsall.bat" amd64

rem Compare %ORIGPATH% to expected value and alert if something has changed.
if "%checkpath%" neq "1" exit /b

set EXP=C:\Windows\system32
set EXP=%EXP%;C:\Windows
set EXP=%EXP%;C:\Windows\System32\Wbem
set EXP=%EXP%;C:\Program Files\PowerShell\7\
set EXP=%EXP%;C:\Windows\System32\WindowsPowerShell\v1.0\
set EXP=%EXP%;C:\Windows\System32\OpenSSH\
set EXP=%EXP%;C:\Program Files\Git\cmd
set EXP=%EXP%;%USERPROFILE%\scoop\apps\python312\current\Scripts
set EXP=%EXP%;%USERPROFILE%\scoop\apps\python312\current
set EXP=%EXP%;%USERPROFILE%\scoop\shims
set EXP=%EXP%;%USERPROFILE%\AppData\Local\Microsoft\WindowsApps
if "%FOO%" neq "%EXP%" echo "Warning, path has changed"
set checkpath=
