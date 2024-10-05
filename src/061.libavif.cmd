@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libavif
set LibraryName=avif
set ProjectName=libavif
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DAVIF_CODEC_AOM=ON -DAVIF_CODEC_DAV1D=ON -DAVIF_CODEC_RAV1E=ON -DAVIF_CODEC_SVT=OFF"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
