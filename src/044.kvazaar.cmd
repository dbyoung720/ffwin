@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=kvazaar
set LibraryName=libkvazaar
set ProjectName=kvazaar
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

if exist "%VSSDKPath%\lib\kvazaar.lib" exit /b

copy /b /y "%VSSDKPath%\lib\%LibraryName%.lib" "%VSSDKPath%\lib\kvazaar.lib"
