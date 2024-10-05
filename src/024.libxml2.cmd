@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libxml2
set LibraryName=libxml2s
set ProjectName=libxml2
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

if not exist "%VSSDKPath%\lib\xml2.lib" (
  copy /b /y "%VSSDKPath%\lib\%LibraryName%.lib" "%VSSDKPath%\lib\xml2.lib"
)
