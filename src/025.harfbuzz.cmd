@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=harfbuzz
set LibraryName=harfbuzz
set ProjectName=harfbuzz
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: cmake source
set SpecialCMakeParam="-DHB_HAVE_FREETYPE=ON"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

if exist "%VSSDKLIB%\libharfbuzz.lib" exit /b

copy /b /y "%VSSDKLIB%\harfbuzz.lib" "%VSSDKLIB%\libharfbuzz.lib"

set "PCFileName=%PCInstall%\harfbuzz.pc"
set "strOld=Libs: -L\${libdir}"
set "strNew=Libs: -L${libdir} -lfreetype -lfontconfig -lbz2 -lbrotlidec -lbrotlicommon"
call powershell -Command "(gc %PCFileName%) -replace  '%strOld%', '%strNew%' | Out-File %PCFileName% -encoding ASCII"

set "sDelLine=Requires"
powershell -Command "$data = foreach($line in gc %PCFileName%){ if($line -notlike '*%sDelLine%*') {$line}} $data | Out-File %PCFileName%  -encoding ASCII"
