@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libtiff
set LibraryName=tiff
set ProjectName=tiff
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%
set CL=/DLZMA_API_STATIC=1

:: cmake source
set SpecialCMakeParam="-Dtiff-docs=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

if exist "%VSSDKPath%\lib\libtiff-4.lib" exit /b

copy /b /y "%VSSDKPath%\lib\%LibraryName%.lib" "%VSSDKPath%\lib\libtiff-4.lib"

set "PCFileName=%PCInstall%\libtiff-4.pc"
set "strOld=Libs: -L\${libdir} -ltiff"
set "strNew=Libs: -L${libdir} -ltiff -lzlib -ldeflate -ljpeg -llzma -lzstd"
call powershell -Command "(gc %PCFileName%) -replace  '%strOld%', '%strNew%' | Out-File %PCFileName% -encoding ASCII"

set "strMakeFile=%VSSDKLIB%\cmake\tiff\TiffTargets.cmake"
set "strOldMake=INTERFACE_LINK_LIBRARIES"
set "strNewMake=INTERFACE_LINK_LIBRARIES """"gif.lib;jpeg.lib;openjp2.lib;zlib.lib;zstd.lib;lzma.lib;libpng.lib;tiff.lib;Deflate.lib;libWebp.lib;libwebpmux.lib;libsharpyuv.lib;user32.lib"""
call %RootPath%src\rtl %strMakeFile% %strOldMake% "%strNewMake%"
