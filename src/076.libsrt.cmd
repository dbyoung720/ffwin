@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libsrt
set LibraryName=srt
set ProjectName=libsrt
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DENABLE_CXX11=ON -DENABLE_UNITTESTS=OFF -DENABLE_SHARED=OFF -DENABLE_SUFLIP=OFF -DENABLE_EXAMPLES=OFF -DUSE_OPENSSL_PC=ON"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%
