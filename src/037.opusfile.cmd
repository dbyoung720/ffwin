@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=opusfile
set LibraryName=opusfile
set ProjectName=opusfile
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DOP_DISABLE_DOCS=ON -DOP_DISABLE_EXAMPLES=ON -DOP_DISABLE_HTTP=ON -DWITH_GTEST=OFF -DPNG_BUILD_ZLIB=ON -DPNG_SHARED=OFF "
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
