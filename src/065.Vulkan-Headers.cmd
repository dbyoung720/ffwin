@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=Vulkan-Headers
set LibraryName=Vulkan-Headers
set ProjectName=Vulkan-Headers
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

if exist "%VSSDKPath%\share\vulkan\registry\vk.xml" exit /b

:: cmake source
set SpecialCMakeParam="-DVULKAN_HEADERS_ENABLE_MODULE=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
