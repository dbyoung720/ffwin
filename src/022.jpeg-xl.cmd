@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=jpeg-xl
set LibraryName=jxl
set ProjectName=libjxl
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DHWY_CMAKE_SSE2=ON -DJPEGXL_ENABLE_EXAMPLES=OFF -DBUILD_TESTING=OFF -DINSTALL_GTEST=OFF -DJPEGXL_ENABLE_TOOLS=OFF -DJPEGXL_ENABLE_DOXYGEN=OFF -DJPEGXL_EXAMPLES=OFF -DWITH_GTEST=OFF -DPNG_BUILD_ZLIB=ON -DPNG_SHARED=OFF "
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
