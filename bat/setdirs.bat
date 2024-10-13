@echo off
set SRC=C:\src
if "%ORIGPATH%" == "" (
    set ORIGPATH=%PATH%
    set checkpath=1
)

rem We want to have full control over the path, so set the whole thing
rem explicitly.
rem TODO: For some reason it seems like I can only put one SET PATH inside
rem an if block.
set PATH=%USERPROFILE%\bat
if exist "%USERPROFILE%\scoop" (
set PATH=%PATH%;%USERPROFILE%\scoop\apps\python312\current\Scripts
)
if exist "%USERPROFILE%\scoop" (
set PATH=%PATH%;%USERPROFILE%\scoop\apps\python312\current
)
if exist "%USERPROFILE%\scoop" (
set PATH=%PATH%;%USERPROFILE%\scoop\shims
)

if exist "%SRC%\depot_tools" (
    set PATH=%PATH%;%SRC%\depot_tools
)
set PATH=%PATH%;%SystemRoot%\System32
set PATH=%PATH%;%SystemRoot%
set PATH=%PATH%;%SystemRoot%\Wbem
set PATH=%PATH%;%ProgramFiles%\PowerShell\7
set PATH=%PATH%;%SystemRoot%\System32\WindowsPowerShell\v1.0
if exist "%ProgramFiles%\Git Google Extras" (
    set PATH=%PATH%;%ProgramFiles%\Git Google Extras
)
set PATH=%PATH%;C:\msys64\usr\bin
set PATH=%PATH%;C:\msys64\bin

rem TODO: Consider adding visual studio dirs and win sdk dirs.
rem "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvarsall.bat" amd64

rem Compare %ORIGPATH% to expected value and alert if something has changed.
if "%checkpath%" == "1" (
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
  if "%FOO%" neq "%EXP%" (
    ECHO "Warning, path has changed"
  )
)
set checkpath=
