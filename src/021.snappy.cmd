@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=snappy
set LibraryName=snappy_static
set ProjectName=snappy
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: modify install
if not exist "%VSSDKPath%\bin\snappy.dll" exit /b

:: modify install
del "%VSSDKPath%\bin\snappy.dll"
del "%VSSDKPath%\lib\snappy.lib"
copy /b /y %VSSDKPath%\lib\snappy_static.lib %VSSDKPath%\lib\snappy.lib
