@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=gflags
set LibraryName=gflags_static
set ProjectName=gflags
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
if exist "%VSSDKPath%\lib\gflags.lib" exit /b
CD /D %VSSDKPath%\lib
copy /b /y gflags_static.lib           gflags.lib
copy /b /y gflags_nothreads_static.lib gflags_nothreads.lib
