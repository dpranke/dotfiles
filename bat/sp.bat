@echo off
set SRC=C:\src
set WHOME=%USERPROFILE%
set UHOME=$SRC\msys64\home\%USERNAME%

if "%OPATH%" neq "" goto l1
set OPATH=%PATH%

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
call "%~dp0\ap" %USERPROFILE%\AppData\Local\Microsoft\WindowsApps

set local_path_file=%UserProfile%\.set_path-%COMPUTERNAME%.bat
if not exist "%local_path_file%" goto end
call "%local_path_file%"

:end
call "%~dp0\ap" C:\src\msys64\usr\bin
set local_path_file=

rem TODO: Consider adding visual studio dirs and win sdk dirs.
rem "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvarsall.bat" amd64
