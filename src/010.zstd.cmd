@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=zstd
set LibraryName=zstd
set ProjectName=zstd
set SourceCDX=%SourcePath%\%packageName%
set CMakePath=%SourcePath%\%packageName%\build\cmake
set BuildPath=%BuildPathX%\%~n0\%Platform%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam% %CMakePath%

:: modify install
if not exist %VSSDKPath%\bin\zstd.dll exit /b

del %VSSDKPath%\bin\zstd.dll

CD /D %VSSDKPath%\lib
copy /b zstd_static.lib zstd.lib
