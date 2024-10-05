@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=SVT-VP9
set LibraryName=SvtVp9Enc
set ProjectName=SVT-VP9
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

if %Platform1%==x86 exit /b

if not exist "%VSSDKINC%\unistd.h" (
  copy /b /y "%RootPath%src\patch\unistd.h" "%VSSDKINC%\unistd.h"
)

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
