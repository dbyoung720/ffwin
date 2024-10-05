@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libass
set LibraryName=ass
set ProjectName=libass
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: Ninja fribidi
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
if exist %VSSDKPath%\lib\%ProjectName%.lib exit /b

copy /b %VSSDKPath%\lib\%ProjectName%.a %VSSDKPath%\lib\%ProjectName%.lib
copy /b %VSSDKPath%\lib\%ProjectName%.a %VSSDKPath%\lib\%LibraryName%.lib
