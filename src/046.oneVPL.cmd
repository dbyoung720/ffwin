@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=oneVPL
set LibraryName=VPL
set ProjectName=VPL
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=" -DCMAKE_INSTALL_LIBDIR=lib "
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
if exist "%VSSDKPath%\lib\oneVPL.lib" exit /b

copy /b /y "%VSSDKPath%\lib\%LibraryName%.lib" "%VSSDKPath%\lib\oneVPL.lib"

set "strMakeFile=%PCInstall%\vpl.pc"
set "strOldMake=Libs: "
set "strNewMake=Libs: -L${libdir} -lvpl -liconv -llibcharset -lAdvapi32 -lOle32"
call %RootPath%src\rtl %strMakeFile% %strOldMake% "%strNewMake%"
