@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=openmpt
set LibraryName=libopenmpt
set ProjectName=libopenmpt
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam=""
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

if exist "%VSSDKLIB%\libopenmpt.lib" exit /b

copy /b /y "%VSSDKLIB%\openmpt.lib" "%VSSDKLIB%\libopenmpt.lib"

set "PCFileName=%PCInstall%\%LibraryName%.pc"
set "strOld=Libs: -L\${prefix}/lib -lopenmpt"
set "strNew=Libs: -L${prefix}/lib -lopenmpt -lzlib -logg -lvorbis -lvorbisfile -lmpg123 lShlwapi"
call powershell -Command "(gc %PCFileName%) -replace  '%strOld%', '%strNew%' | Out-File %PCFileName% -encoding ASCII"

set "strOld2=Version: "
set "strNew2=Version: 0.8.01"
call powershell -Command "(gc %PCFileName%) -replace  '%strOld2%', '%strNew2%' | Out-File %PCFileName% -encoding ASCII"
