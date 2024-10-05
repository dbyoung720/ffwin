@echo off
setlocal EnableDelayedExpansion
color A

set ProjectName=%1

if not exist "%BuildPathX%\%ProjectName%" (
 cd /d "%BuildPathX%"
 md %ProjectName%
)

if not exist "%BuildPathX%\%ProjectName%\%Platform1%" (
 cd /d "%BuildPathX%\%ProjectName%"
 md %Platform1%
)
