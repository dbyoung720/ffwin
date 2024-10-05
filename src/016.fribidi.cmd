@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=fribidi
set LibraryName=fribidi
set ProjectName=fribidi
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: Ninja fribidi
echo ¡ï¡ï¡ï¡ï¡ï CMake %PackageName% ¡ï¡ï¡ï¡ï¡ï
call %RootPath%src\delbtp %BuildPath%
%scoop%\apps\meson\current\meson setup -Doptimization=3 -Ddebug=false -Ddefault_library=static -Ddebug=false -Db_vscrt=mt -Ddocs=false --prefix=%VSSDKPath% %SourceCDX% %BuildPath%
CD /D "%BuildPath%"
%scoop%\apps\ninja\current\ninja
%scoop%\apps\ninja\current\ninja install

:: check build error
if %errorlevel% NEQ 0 (
	echo ¡ï¡ï¡ï¡ï¡ï compile error. ¡ï¡ï¡ï¡ï¡ï 
	pause
)

:: modify install
if exist %VSSDKPath%\lib\libfribidi.lib exit /b

copy /b %VSSDKPath%\lib\libfribidi.a %VSSDKPath%\lib\libfribidi.lib
copy /b %VSSDKPath%\lib\libfribidi.a %VSSDKPath%\lib\fribidi.lib
