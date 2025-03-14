@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=bzip2
set LibraryName=bz2
set ProjectName=bzip2
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

if exist %PCInstall%\bzip2.pc exit /b

set msysVSSDKPath=%VSSDKPath:\=/%
echo 
(
	echo prefix=%msysVSSDKPath%
	echo exec_prefix=${prefix}
	echo libdir=${exec_prefix}/lib
	echo includedir=${prefix}/include
	echo. 
	echo Name: bzip2
	echo Description: Lossless, block-sorting data compression
	echo Version: 1.0.6
	echo Libs: -L${libdir} -lbz2 -lzlib -llibpng -lbrotlidec -lbrotlicommon -liconv -llibcharset
	echo Libs.private: -lzlib -llibpng -lbrotlidec -lbrotlicommon -liconv -llibcharset
	echo Cflags: -I${includedir}
)>%PCInstall%\bzip2.pc
