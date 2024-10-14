@echo off
if not exist "%USERPROFILE%\.opath.txt" goto nopath

set opath_filename=%TEMP%\path-%RANDOM%.txt
echo %OPATH% > %opath_filename%
fc "%USERPROFILE%\.opath.txt" "%opath_filename%" > /nul
if errorlevel 1 goto diff
goto delfile

:diff
echo Path has changed:
echo ^<^<^<
type "%USERPROFILE%\.opath.txt"
echo ===
type "%opath_filename%"
echo ^>^>^>

goto run

:nopath
echo Check your path:
echo %OPATH%
echo.
echo ^> echo %%OPATH%% ^> %USERPROFILE%\.opath.txt
goto done

:run
echo.
echo Run: 
echo ^> echo %%OPATH%% ^> %USERPROFILE%\.opath.txt
echo.

:delfile
if exist "%opath_filename%" del "%opath_filename%"

:done
