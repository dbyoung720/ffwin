@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libiconv
set LibraryName=libiconv
set ProjectName=libiconv
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

if not exist "%VSSDKPath%\lib\iconv.lib" (
	copy /b /y "%VSSDKPath%\lib\%LibraryName%.lib" "%VSSDKPath%\lib\iconv.lib"
)
