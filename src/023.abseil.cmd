@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=abseil-cpp
set LibraryName=absl_base
set ProjectName=absl
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
