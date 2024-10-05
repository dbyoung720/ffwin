@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=dav1d
set LibraryName=libdav1d
set ProjectName=dav1d
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: Ninja dav1d
echo ������ CMake %PackageName% ������
call %RootPath%src\delbtp %BuildPath%
%scoop%\apps\meson\current\meson setup -Doptimization=3 -Ddebug=false -Ddefault_library=static -Ddebug=false -Db_vscrt=mt --prefix=%VSSDKPath% %SourceCDX% %BuildPath%
CD /D "%BuildPath%"
%scoop%\apps\ninja\current\ninja
%scoop%\apps\ninja\current\ninja install

:: check build error
if %errorlevel% NEQ 0 (
	echo ������ compile error. ������ 
	pause
)

:: modify install
if exist "%VSSDKPath%\lib\libdav1d.lib" exit /b
copy /b /y  %VSSDKPath%\lib\libdav1d.a %VSSDKPath%\lib\libdav1d.lib
copy /b /y  %VSSDKPath%\lib\libdav1d.a %VSSDKPath%\lib\dav1d.lib
