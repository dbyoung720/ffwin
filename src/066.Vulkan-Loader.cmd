@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=Vulkan-Loader
set LibraryName=vulkan
set ProjectName=Vulkan-Loader
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DBUILD_STATIC_LOADER=ON -DBUILD_TESTS=OFF -DUNIX=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
