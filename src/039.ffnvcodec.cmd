@echo off
setlocal EnableDelayedExpansion
color A
CD /D %~dp0

set PackageName=ffnvcodec
set LibraryName=ffnvcodec
set ProjectName=ffnvcodec
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

call %~dp0createbcd %~n0

:: Dowload source
call %~dp0downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\pkgconfig\%LibraryName%.pc" exit /b

xcopy /e /y /c /i "%SourceCDX%\include\ffnvcodec\*.*" "%VSSDKINC%\ffnvcodec\"

copy /y "%SourceCDX%\ffnvcodec.pc.in" "%PCInstall%\ffnvcodec.pc"

set GCCSDKPath=%VSSDKPath:\=/%
set "ffnvcodecPC=%PCInstall%\ffnvcodec.pc"
call powershell -Command "(gc %ffnvcodecPC%) -replace  '@@PREFIX@@', '%GCCSDKPath%' | Out-File %ffnvcodecPC% -encoding ASCII"

echo must be ffnvcodec version number HIGH cuda sdk version number
