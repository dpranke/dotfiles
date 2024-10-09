@echo off
SET var=%cd%
cd "%~dp0"
bash --norc -c "../bin/sel %*"
cd "%var%"
