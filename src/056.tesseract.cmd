@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=tesseract
set LibraryName=tesseract54
set ProjectName=tesseract
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF -DDISABLE_TIFF=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
