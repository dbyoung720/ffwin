@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=SDL2
set LibraryName=SDL2-static
set ProjectName=SDL2
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=" -DSDL_INSTALL_CMAKEDIR=%VSSDKLIB%\cmake "
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
