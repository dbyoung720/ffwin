@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=amf
set LibraryName=amf
set ProjectName=amf
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

if exist "%VSSDKINC%\amf" exit /b

xcopy /e /y /c /i "%RootPath%src\patch\amf\*.*"  "%VSSDKINC%\amf\" 
