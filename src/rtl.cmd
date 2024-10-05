@echo off
setlocal enabledelayedexpansion
:: replace text line

set filename=%1
set linetext=%2
set repttext=%3

call powershell -Command "(Get-Content "%filename%") | ForEach-Object { $_ -replace '%linetext%(.*)', '%repttext%'} | Set-Content %filename%"
