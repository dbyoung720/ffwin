@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=glslang
set LibraryName=glslang
set ProjectName=glslang
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DENABLE_OPT=0"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
