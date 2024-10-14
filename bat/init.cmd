@echo off
REM To set things up so that this script is run every time you start
REM a command prompt, run %USERPROFILE%\bat\setup_init_script.bat

set checkopath=0
if "%OPATH%" == "" set checkopath=1
call %USERPROFILE%\bat\set_path.bat

if "%checkopath%" == "1" call %USERPROFILE%\bat\check_opath.bat
set checkopath=
