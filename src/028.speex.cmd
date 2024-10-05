@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=speex
set LibraryName=libspeex
set ProjectName=speex
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: CMake speex
echo ¡ï¡ï¡ï¡ï¡ï CMake %PackageName% ¡ï¡ï¡ï¡ï¡ï
call %RootPath%src\delbtp %BuildPath%
%scoop%\apps\meson\current\meson setup -Doptimization=3 -Ddebug=false -Ddefault_library=static -Ddebug=false -Db_vscrt=mt -Dtest-binaries=disabled -Dtools=disabled --prefix=%VSSDKPath% %SourceCDX% %BuildPath%
CD /D "%BuildPath%"
%scoop%\apps\ninja\current\ninja
%scoop%\apps\ninja\current\ninja install

:: check build error
if %errorlevel% NEQ 0 (
	echo ¡ï¡ï¡ï¡ï¡ï compile error. ¡ï¡ï¡ï¡ï¡ï 
	pause
)

if exist "%VSSDKPath%\lib\speex.lib" exit /b

copy /b %VSSDKPath%\lib\libspeex.a %VSSDKPath%\lib\speex.lib
copy /b %VSSDKPath%\lib\libspeex.a %VSSDKPath%\lib\libspeex.lib
