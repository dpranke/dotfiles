@echo off
rem echo %time% & python %WKS%\run-webkit-tests %* & echo .|time
@echo on
python %WKS%\run-webkit-tests %*
