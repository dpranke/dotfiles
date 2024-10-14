@echo off
if not exist "%USERPROFILE%\.opath.txt" goto nopath

set opath_filename=%TEMP%\path-%RANDOM%.txt
echo %OPATH% > %opath_filename%
fc "%USERPROFILE%\.opath.txt" "%opath_filename%" > /nul
if errorlevel 1 goto diff
goto delfile

:diff
echo Path has changed:
call "%~dp0\compare_opath.bat"
goto run

:nopath
echo Check your path:
echo %OPATH% | sed -e "s/;/\n/g"

:run
echo.
echo Run `update_opath` to update ~\.opath.txt when done.

:delfile
if exist "%opath_filename%" del "%opath_filename%"
