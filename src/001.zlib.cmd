@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=zlib
set LibraryName=zlibstatic
set ProjectName=zlib
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DINSTALL_PKGCONFIG_DIR=%PCInstall%"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
if exist "%VSSDKPath%\lib\zlib.lib" exit /b

del "%VSSDKPath%\bin\zlib1.dll"
del "%VSSDKPath%\bin\z.dll"
del "%VSSDKPath%\lib\z.lib"
copy /b /y "%VSSDKPath%\lib\zs.lib" "%VSSDKPath%\lib\zlib.lib"
copy /b /y "%VSSDKPath%\lib\zs.lib" "%VSSDKPath%\lib\z.lib"

set "PCFileName=%PCInstall%\zlib.pc"
set "strOld=-L\${sharedlibdir} -lz"
set "strNew=-lzlib"
call powershell -Command "(gc %PCFileName%) -replace '%strOld%', '%strNew%' | Out-File %PCFileName% -encoding ASCII"

set "zlibconf=%VSSDKPath%\include\zconf.h"
set "strOld=\#  define Z_HAVE_UNISTD_H"
set "strNew=//#  define Z_HAVE_UNISTD_H"
call powershell -Command "(gc %zlibconf%) -replace '%strOld%', '%strNew%' | Out-File %zlibconf% -encoding ASCII"
