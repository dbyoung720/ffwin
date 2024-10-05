@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libjxl
set LibraryName=jxl
set ProjectName=libjxl
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DJPEGXL_ENABLE_BENCHMARK=OFF -DBUILD_TESTING=OFF -DJPEGXL_STATIC=ON -DJPEGXL_ENABLE_EXAMPLES=OFF -DJPEGXL_ENABLE_JPEGLI=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
