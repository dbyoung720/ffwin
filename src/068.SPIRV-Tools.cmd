@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=SPIRV-Tools
set LibraryName=SPIRV-Tools
set ProjectName=SPIRV-Tools
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DSPIRV_SKIP_TESTS=ON -DSPIRV_TOOLS_BUILD_STATIC=ON"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
