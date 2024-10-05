@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=mpg123
set LibraryName=mpg123
set ProjectName=mpg123
set SourceCDX=%SourcePath%\%packageName%
set CMakePath=%SourcePath%\%packageName%\ports\cmake
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam% %CMakePath% 
