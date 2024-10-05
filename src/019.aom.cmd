@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=aom
set LibraryName=aom
set ProjectName=aom
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: cmake source
set SpecialCMakeParam="-DPERL_EXECUTABLE="%scoop%\apps\perl\current\perl\bin\perl.exe" -DENABLE_EXAMPLES=OFF -DENABLE_DOCS=OFF -DENABLE_CCACHE=ON -DENABLE_TESTDATA=OFF -DENABLE_TESTS=OFF -DCMAKE_CONFIGURATION_TYPES=Release -DENABLE_SHARED=OFF -DENABLE_STATIC=ON  -DCMAKE_VERBOSE_MAKEFILE=ON "
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
