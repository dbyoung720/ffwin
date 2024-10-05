@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=freetype
set LibraryName=freetype
set ProjectName=freetype
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DINSTALL_PKGCONFIG_DIR=%PCInstall%"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
