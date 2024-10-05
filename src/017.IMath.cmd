@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=Imath
set LibraryName=Imath-3_2
set ProjectName=Imath
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
