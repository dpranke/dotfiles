@echo off
@set VNAME=%1
if not exist %SRC%\%1\src goto nosrc
set CSRC=%SRC%\%1\src
cd/d %CSRC%
exit /b

:nosrc
if not exist %SRC%\%1 goto missing
set CSRC=%SRC%\%1
cd/d %CSRC%
exit /b

:missing
echo No such view '%1' under %SRC%
