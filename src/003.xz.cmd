@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=xz
set LibraryName=lzma
set ProjectName=xz
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
if exist "%PCInstall%\liblzma.pc" exit /b

copy /Y    "%BuildPath%\liblzma.pc"            "%PCInstall%\liblzma.pc"
copy /B /Y "%VSSDKPath%\lib\%LibraryName%.lib" "%VSSDKPath%\lib\liblzma.lib"

set "PCFileName=%PCInstall%\liblzma.pc"
set "strOld=Cflags: -I\${includedir}"
set "strNew=Cflags: -I${includedir} -DLZMA_API_STATIC"
call powershell -Command "(gc %PCFileName%) -replace  '%strOld%', '%strNew%' | Out-File %PCFileName% -encoding ASCII"
