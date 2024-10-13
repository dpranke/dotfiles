@echo off
reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun ^
    /t REG_EXPAND_SZ /d "%%USERPROFILE%%\bat\init.cmd" /f
