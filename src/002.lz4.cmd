@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=lz4
set LibraryName=lz4
set ProjectName=lz4
set SourceCDX=%SourcePath%\%packageName%
set CMakePath=%SourcePath%\%packageName%\build\cmake
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam% %CMakePath%
