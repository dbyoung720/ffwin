@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=leptonica
set LibraryName=leptonica-1.84.1
set ProjectName=leptonica
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DSW_BUILD=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
if exist "%PCInstall%\lept.pc" exit /b

set "PCFileName=%PCInstall%\lept_Release.pc"
set "strOld=Libs: -L\${libdir}"
set "strNew=Libs: -L${libdir} -lgiflib -lzlib -llzma -lzstd -llibpng -ljpeg -ltiff -llibwebp -llibsharpyuv -llibwebpmux -lopenjp2"
call powershell -Command "(gc %PCFileName%) -replace  '%strOld%', '%strNew%' | Out-File %PCFileName% -encoding ASCII"

copy /b /y %PCFileName% %PCInstall%\lept.pc

set "strMakeFile=%VSSDKLIB%\cmake\leptonica\LeptonicaTargets.cmake"
set "strOldMake=INTERFACE_LINK_LIBRARIES"
set "strNewMake=INTERFACE_LINK_LIBRARIES """"gif.lib;jpeg.lib;openjp2.lib;zlib.lib;zstd.lib;lzma.lib;libpng.lib;tiff.lib;Deflate.lib;libWebp.lib;libwebpmux.lib;libsharpyuv.lib;user32.lib"""
call %RootPath%src\rtl %strMakeFile% %strOldMake% "%strNewMake%"

