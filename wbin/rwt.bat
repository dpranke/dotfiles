@echo off
rem echo %time% & python %WKS%\new-run-webkit-tests %* & echo .|time
@echo on
python %WKS%\new-run-webkit-tests %*
