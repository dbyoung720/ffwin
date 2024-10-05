@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=x264
set LibraryName=libx264
set ProjectName=x264
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: start compiling
call %RootPath%src\delbtp %BuildPath%
CD /D %BuildPathX%
MD %~n0\%Platform1%
CD %BuildPath%

call %~dp0buildgcc.cmd "--enable-static" %PackageName% "%SourceCDX%"
