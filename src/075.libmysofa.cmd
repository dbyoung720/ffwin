@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libmysofa
set LibraryName=mysofa
set ProjectName=libmysofa
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DBUILD_TESTS=no -DCODE_COVERAGE=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
