@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=fdk-aac
set LibraryName=fdk-aac
set ProjectName=fdk-aac
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
