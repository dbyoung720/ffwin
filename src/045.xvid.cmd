@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=xvid
set LibraryName=libxvidcore
set ProjectName=libxvidcore
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform%

call %~dp0createbcd %~n0

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

xcopy /e /y /c /i "%~dp0patch\xvid\*.*" "%SourceCDX%\build\win32\"

echo   ¡ï¡ï¡ï¡ï¡ï VS2022 multi process build %ProjectName% ¡ï¡ï¡ï¡ï¡ï
call MSBuild.exe "%SourceCDX%\build\win32\%ProjectName%.sln" /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
	/target:Build /property:Configuration=Release;Platform=%Platform2%^
	/flp1:LogFile=%SourceCDX%\zxerr.log;Verbosity=diagnostic;errorsonly^
	/flp2:LogFile=%SourceCDX%\zxwas.log;Verbosity=diagnostic;warningsonly

:: install
if %Platform%==x86 (
  copy /Y "%SourceCDX%\build\win32\Release\%LibraryName%.lib" "%VSSDKPath%\lib\%LibraryName%.lib"
) else (
  copy /Y "%SourceCDX%\build\win32\x64\Release\%LibraryName%.lib" "%VSSDKPath%\lib\%LibraryName%.lib"
)

copy /Y "%SourceCDX%\src\xvid.h" "%VSSDKPath%\include\xvid.h"

:: git source reset 
cd /D "%SourceCDX%"
if exist "%SourceCDX%\.git\" (
  git clean -xfd
  git checkout .
)
