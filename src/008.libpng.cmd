@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libpng
set LibraryName=libpng16_static
set ProjectName=libpng
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
if exist %VSSDKPath%\lib\libpng.lib exit /b

del "%VSSDKPath%\bin\libpng16.dll"
copy /b %VSSDKPath%\lib\libpng16_static.lib %VSSDKPath%\lib\libpng.lib
copy /b %VSSDKPath%\lib\libpng16_static.lib %VSSDKPath%\lib\libpng16.lib
copy /b %VSSDKPath%\lib\libpng16_static.lib %VSSDKPath%\lib\png16.lib

set msysVSSDKPath=%VSSDKPath:\=/%
echo 
(
	echo prefix=%msysVSSDKPath%
	echo libdir=${exec_prefix}/lib
	echo includedir=${prefix}/include/libpng16
	echo.
	echo Name: libpng
	echo Description: Loads and saves PNG files
	echo Version: 1.6.47
	echo Requires.private: zlib
	echo Libs: -L${libdir} -lpng16 -lzlib
	echo Libs.private: -lzlib
	echo Cflags: -I${includedir}
)>%PCInstall%\libpng.pc

echo 
(
	echo prefix=%msysVSSDKPath%
	echo libdir=${exec_prefix}/lib
	echo includedir=${prefix}/include/libpng16
	echo.
	echo Name: libpng
	echo Description: Loads and saves PNG files
	echo Version: 1.6.47
	echo Requires.private: zlib
	echo Libs: -L${libdir} -lpng16 -lzlib
	echo Libs.private: -lzlib
	echo Cflags: -I${includedir}
)>%PCInstall%\libpng16.pc

