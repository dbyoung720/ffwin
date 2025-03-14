@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=fontconfig
set LibraryName=libfontconfig
set ProjectName=fontconfig
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: CMake fontconfig
echo ������ CMake %PackageName% ������
call %RootPath%src\delbtp %BuildPath%
%scoop%\apps\meson\current\meson setup -Dbuildtype=release -Ddefault_library=static -Ddebug=false -Ddoc=disabled -Db_vscrt=mt -Dtests=disabled -Dtools=disabled -Diconv=disabled --prefix=%VSSDKPath% %SourceCDX% %BuildPath%
CD /D "%BuildPath%"
%scoop%\apps\ninja\current\ninja

:: check build error
if %errorlevel% NEQ 0 (
	echo ������ compile error. ������ 
	pause
)

CD /D "%VSSDKPath%\lib"
copy /Y /b "%BuildPath%\src\libfontconfig.a"  libfontconfig.lib
copy /Y /b "%BuildPath%\src\libfontconfig.a"  fontconfig.lib

if not exist "%VSSDKPath%\include\fontconfig" (
  CD /D "%VSSDKPath%\include"
  MD fontconfig
  CD /D fontconfig
  copy /b /y "%SourceCDX%\fontconfig\*.h"
)

set msysVSSDKPath=%VSSDKPath:\=/%
echo 
(
	echo prefix=%msysVSSDKPath%
	echo includedir=${prefix}/include
	echo libdir=${prefix}/lib
	echo. 
	echo Name: Fontconfig
	echo Description: Font configuration and customization library
	echo Version: 2.16.1
	echo Libs: -L${libdir} -lfontconfig -llibxml2s -lfreetype -lbz2 -lzlib -llibpng -lbrotlidec -lbrotlicommon -liconv -llibcharset
	echo Libs.private: -lfreetype -llibxml2s -lbz2 -lzlib -llibpng -lbrotlidec -lbrotlicommon -liconv -llibcharset
	echo Cflags: -I${includedir}
)>%PCInstall%\fontconfig.pc
