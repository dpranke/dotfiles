@echo off
setlocal
set opath_filename=%USERPROFILE%\.opath.txt
set old=%TEMP%\old-%RANDOM%.txt
set new=%TEMP%\new-%RANDOM%.txt
type %opath_filename% | sed -e "s/;/\n/g" > %old%
echo %OPATH% | sed -e "s/;/\n/g" > %new%
diff %old% %new%
del %old% %new% 
