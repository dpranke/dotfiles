@echo off
set SRC=C:\src
set WHOME=%USERPROFILE%
set checkpath=0
if "%OPATH%" neq "" goto l1
set OPATH=%PATH%
set checkpath=1

:l1
rem We want to have full control over the path, so set the whole thing
rem explicitly.
set PATH=%USERPROFILE%\bat
call "%~dp0\ap" %USERPROFILE%\scoop\apps\python312\current\Scripts
call "%~dp0\ap" %USERPROFILE%\scoop\apps\python312\current
call "%~dp0\ap" %USERPROFILE%\scoop\shims
call "%~dp0\ap" %SRC%\depot_tools
call "%~dp0\ap" %SystemRoot%\System32
call "%~dp0\ap" %SystemRoot%
call "%~dp0\ap" %SystemRoot%\System32\Wbem
call "%~dp0\ap" %ProgramFiles%\PowerShell\7
call "%~dp0\ap" %SystemRoot%\System32\WindowsPowerShell\v1.0
call "%~dp0\ap" %ProgramFiles%\Git Google Extras
call "%~dp0\ap" %USERPROFILE%\AppData\Local\Microsoft\WindowsApps
call "%~dp0\ap" C:\msys64\usr\bin

rem TODO: Consider adding visual studio dirs and win sdk dirs.
rem "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvarsall.bat" amd64

rem Compare OPATH to EPATH and alert if something has changed.
if "%checkpath%" neq "1" exit /b

set EPATH=%SystemRoot%\System32
call :ep %SystemRoot%
call :ep %SystemRoot%\System32\Wbem
call :ep %ProgramFiles%\PowerShell\7\
call :ep %SystemRoot%\System32\WindowsPowerShell\v1.0\
call :ep %SystemRoot%\System32\OpenSSH\
call :ep %USERPROFILE%\AppData\Local\Microsoft\WindowsApps

if "%OPATH%" == "%EPATH%;" goto done
echo Warning, path has changed

:done
set checkpath=
set EPATH=
goto eof

:ep
@echo off
echo %EPATH%; | find /i "%*;" 1>nul
if not errorlevel 1 goto eof
if not exist "%*" goto eof
set EPATH=%EPATH%;%*

:eof
