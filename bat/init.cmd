@echo off
REM To set things up so that this script is run every time you start
REM a command prompt, run %USERPROFILE%\bat\setup_init_script.bat
REM
REM
SET checkpath=0
if "%OPATH%" eq "" set checkpath=1

%USERPROFILE%\bat\setdirs.bat

if %checkpath% == "0" goto done

"%~dp0\check_path.bat"

done:
