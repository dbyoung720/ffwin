@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libdeflate
set LibraryName=deflate
set ProjectName=libdeflate
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DLIBDEFLATE_BUILD_SHARED_LIB=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
if exist "%VSSDKPath%\lib\deflate.lib" exit /b

copy /b /y "%VSSDKPath%\lib\deflatestatic.lib" "%VSSDKPath%\lib\deflate.lib"
copy /b /y "%VSSDKPath%\lib\deflatestatic.lib" "%VSSDKPath%\lib\libdeflate.lib"
