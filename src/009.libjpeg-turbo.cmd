@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libjpeg-turbo
set LibraryName=turbojpeg-static
set ProjectName=libjpeg-turbo
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DWITH_GTEST=OFF -DPNG_BUILD_ZLIB=ON -DPNG_SHARED=OFF -DENABLE_SHARED=OFF -DENABLE_STATIC=ON -DCMAKE_VERBOSE_MAKEFILE=ON -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
if exist "%VSSDKPath%\lib\jpeg.lib" exit /b

CD /D %VSSDKPath%\lib
copy /b jpeg-static.lib      jpeg.lib
copy /b jpeg-static.lib      libjpeg.lib
copy /b turbojpeg-static.lib turbojpeg.lib
