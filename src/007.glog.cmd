@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=glog
set LibraryName=glog
set ProjectName=glog
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DWITH_GTEST=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
