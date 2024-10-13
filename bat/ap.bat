@echo off

rem Check to see if the directory is already in PATH.
echo %PATH%; | %SystemRoot%\System32\find /i "%*;" 1>nul
if errorlevel 1 goto notfound
exit /b

:notfound
if not exist "%*" goto notexist
set PATH=%PATH%;%*
goto eof

:notexist

:eof
