@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=shaderc
set LibraryName=shaderc
set ProjectName=shaderc
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DSHADERC_ENABLE_SHARED_CRT=OFF -DCMAKE_BUILD_TYPE=Release -DSHADERC_ENABLE_TESTS=OFF -DSHADERC_SKIP_TESTS=ON -DSHADERC_THIRD_PARTY_ROOT_DIR=%SourcePath%"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
