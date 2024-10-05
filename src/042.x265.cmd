@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=x265
set LibraryName=libx265
set ProjectName=x265
set SourceCDX=%SourcePath%\%packageName%
set CMakePath=%SourcePath%\%packageName%\source
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DSTATIC_LINK_CRT=ON -DENABLE_SHARED=OFF -DCMAKE_CONFIGURATION_TYPES=Release -DCMAKE_VERBOSE_MAKEFILE=ON"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam% %CMakePath%

:: modify install
if exist "%VSSDKPath%\lib\libx265.lib" exit /b
copy /b /y "%VSSDKPath%\lib\x265-static.lib" "%VSSDKPath%\lib\libx265.lib"
copy /b /y "%VSSDKPath%\lib\x265-static.lib" "%VSSDKPath%\lib\x265.lib"
