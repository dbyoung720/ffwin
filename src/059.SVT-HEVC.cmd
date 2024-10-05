@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=SVT-HEVC
set LibraryName=SvtHevcEnc
set ProjectName=SVT-HEVC
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

if %Platform1%==x86 exit /b

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
