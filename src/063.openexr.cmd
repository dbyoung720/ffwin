@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=openexr
set LibraryName=OpenEXR-3_3
set ProjectName=openexr
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DBUILD_TESTING=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
set "PCFileName=%PCInstall%\openexr.pc"
set "strOld=-lIlmThread\${libsuffix}"
set "strNew=-lIlmThread${libsuffix} -llibdeflate"
call powershell -Command "(gc %PCFileName%) -replace  '%strOld%', '%strNew%' | Out-File %PCFileName% -encoding ASCII"
