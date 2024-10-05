@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=freeglut
set LibraryName=glut
set ProjectName=freeglut
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

set SpecialCMakeParam="-DFREEGLUT_BUILD_SHARED_LIBS=OFF -DFREEGLUT_BUILD_DEMOS=OFF -DUNIX=OFF -DFREEGLUT_REPLACE_GLUT=ON"
call %RootPath%src\vcmake.cmd %PackageName% %LibraryName% %ProjectName% %SourceCDX% %BuildPath% %SpecialCMakeParam%

:: cmake source
if not exist "%VSSDKINC%\KHR" (
  xcopy /e /y /c /i "%RootPath%src\patch\OpenGL\*.*"  "%VSSDKINC%\" 
)
