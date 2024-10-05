@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=Little-CMS
set LibraryName=lcms2
set ProjectName=lcms2
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: Ninja lcms2
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
CD /D %VSSDKPath%/lib
copy /b liblcms2.a liblcms2.lib
copy /b liblcms2.a lcms2.lib
