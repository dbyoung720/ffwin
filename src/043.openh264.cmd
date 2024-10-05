@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=openh264
set LibraryName=libopenh264
set ProjectName=openh264
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: Ninja openh264
echo ¡ï¡ï¡ï¡ï¡ï CMake %PackageName% ¡ï¡ï¡ï¡ï¡ï
call %RootPath%src\delbtp %BuildPath%
%scoop%\apps\meson\current\meson setup -Doptimization=3 -Ddebug=false -Ddefault_library=static -Ddebug=false -Db_vscrt=mt -Dtests=disabled --prefix=%VSSDKPath% %SourceCDX% %BuildPath%
CD /D "%BuildPath%"
%scoop%\apps\ninja\current\ninja
%scoop%\apps\ninja\current\ninja install

:: check build error
if %errorlevel% NEQ 0 (
	echo ¡ï¡ï¡ï¡ï¡ï compile error. ¡ï¡ï¡ï¡ï¡ï 
	pause
)

:: modify install
if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit/ b
copy /b /y "%VSSDKPath%\lib\%LibraryName%.a" "%VSSDKPath%\lib\%LibraryName%.lib"
copy /b /y "%VSSDKPath%\lib\%LibraryName%.a" "%VSSDKPath%\lib\openh264.lib"
