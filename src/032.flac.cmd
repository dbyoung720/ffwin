@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=flac
set LibraryName=flac
set ProjectName=flac
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DHAVE_PANDOC="%RootPath%scoop\%Platform%\shims\pandoc.exe" -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF -DBUILD_DOXYGEN=OFF -DBUILD_DOCS=OFF -DWITH_GTEST=OFF -DPNG_BUILD_ZLIB=ON -DPNG_SHARED=OFF "
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
