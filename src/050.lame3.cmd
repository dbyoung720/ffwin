@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=lame3
set LibraryName=libmp3lame
set ProjectName=vs2019_lame
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

call %~dp0createbcd %~n0

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: start compiling
MSBuild.exe %SourceCDX%\vc_solution\%ProjectName%.sln /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
  /target:Build /property:Configuration=ReleaseSSE2;Platform=%platform2%^
  /flp1:LogFile=%SourceCDX%\zxerr1.log;Verbosity=diagnostic;errorsonly^
  /flp2:LogFile=%SourceCDX%\zxwas1.log;Verbosity=diagnostic;warningsonly

:: check compile error
if %errorlevel% NEQ 0 (
  echo An error occurred, compile lame3 stop¡£
  pause
)

:: modify install
copy  /Y          "%SourceCDX%\output\%platform2%\ReleaseSSE2\%LibraryName%-static.lib" "%VSSDKPath%\lib\%LibraryName%.lib"
copy  /Y          "%SourceCDX%\output\%platform2%\ReleaseSSE2\%LibraryName%-static.lib" "%VSSDKPath%\lib\mp3lame.lib"
xcopy /e /y /c /i "%SourceCDX%\include\*.h"                                             "%VSSDKPath%\include\lame\"

:: git source reset 
cd /D "%SourceCDX%"
git clean -xfd
git checkout .
