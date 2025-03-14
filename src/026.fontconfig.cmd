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
echo ¡ï¡ï¡ï¡ï¡ï CMake %PackageName% ¡ï¡ï¡ï¡ï¡ï
call %RootPath%src\delbtp %BuildPath%
%scoop%\apps\meson\current\meson setup -Dbuildtype=release -Ddefault_library=static -Ddebug=false -Db_vscrt=mt -Dtests=disabled -Dtools=disabled --prefix=%VSSDKPath% %SourceCDX% %BuildPath%
CD /D "%BuildPath%"
%scoop%\apps\ninja\current\ninja
%scoop%\apps\ninja\current\ninja install

:: check build error
if %errorlevel% NEQ 0 (
	echo ¡ï¡ï¡ï¡ï¡ï compile error. ¡ï¡ï¡ï¡ï¡ï 
	pause
)

if exist "%VSSDKPath%\lib\fontconfig.lib" exit /b

CD /D %VSSDKPath%\lib
copy /Y /b libfontconfig.a libfontconfig.lib
copy /Y /b libfontconfig.a fontconfig.lib
copy /Y /b libexpat.a      libexpat.lib
copy /Y /b libexpat.a      expat.lib
copy /Y /b libfreetype.a   libfreetype.lib
copy /Y /b libfreetype.a   freetype.lib
