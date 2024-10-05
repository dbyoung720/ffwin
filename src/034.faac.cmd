@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=faac
set LibraryName=faac
set ProjectName=faac
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

call %~dp0createbcd %~n0

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: Patch faac
CD /D "%SourceCDX%"
git apply --ignore-space-change --ignore-whitespace -v %~dp0patch\faac.patch

:: vs compile faac
echo ¡ï¡ï¡ï¡ï¡ï VS2022 multi process build %LibraryName% ¡ï¡ï¡ï¡ï¡ï
call %RootPath%src\delbtp %BuildPath%
call MSBuild.exe "%SourceCDX%\project\msvc\%ProjectName%.sln" /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
	/target:Build /property:Configuration=Release;Platform=%Platform2%^
	/flp1:LogFile=%SourceCDX%\zxerr.log;Verbosity=diagnostic;errorsonly^
	/flp2:LogFile=%SourceCDX%\zxwas.log;Verbosity=diagnostic;warningsonly

if %errorlevel% NEQ 0 (
	echo ¡ï¡ï¡ï¡ï¡ï compile error. press any key to open project with vs2022 ¡ï¡ï¡ï¡ï¡ï 
	pause
	call "%SourceCDX%\project\msvc\%ProjectName%.sln"
	pause
)

:: install
if exist "%VSSDKPath%\lib\faac.lib" exit /b

copy /Y "%SourceCDX%\project\msvc\bin\Release\faac.lib" "%VSSDKPath%\lib\faac.lib"
xcopy /e /y /c /i "%SourceCDX%\include\*.h"             "%VSSDKPath%\include\"

:: git source reset 
cd /D "%SourceCDX%"
if exist "%SourceCDX%\.git\" (
  git clean -xfd
  git checkout .
)
