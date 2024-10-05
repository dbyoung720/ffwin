@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=theora
set LibraryName=libtheora
set ProjectName=libtheora_static
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

call %~dp0createbcd %~n0

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

echo ¡ï¡ï¡ï¡ï¡ï CMake %PackageName% ¡ï¡ï¡ï¡ï¡ï
if not exist %BuildPathX% (
	CD /D %BuildPathX%
	MD %BuildPath%
)

:: Patch theora
CD /D "%SourceCDX%"
git apply --ignore-space-change --ignore-whitespace -v %~dp0patch\%PackageName%.patch

:: vs compile theora
set "strOld=<RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>"
set "strNew=<RuntimeLibrary>MultiThreaded</RuntimeLibrary>"
for /f %%i in ('dir /b /s /a:-d *.vcxproj') do (
  powershell -Command "(gc %%i) -replace '%strOld%', '%strNew%' | Out-File %%i"
)

echo   ¡ï¡ï¡ï¡ï¡ï VS2022 multi process build %ProjectName% ¡ï¡ï¡ï¡ï¡ï
call MSBuild.exe "%SourceCDX%\win32\VS2010\%ProjectName%.sln" /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
	/target:Build /property:Configuration=Release;Platform=%Platform1%^
	/flp1:LogFile=%SourceCDX%\zxerr.log;Verbosity=diagnostic;errorsonly^
	/flp2:LogFile=%SourceCDX%\zxwas.log;Verbosity=diagnostic;warningsonly

if %errorlevel% NEQ 0 (
	echo ¡ï¡ï¡ï¡ï¡ï compile error. press any key to open project with vs2022 ¡ï¡ï¡ï¡ï¡ï 
	pause
	call "%SourceCDX%\win32\VS2010\%ProjectName%.sln"
	pause
)

:: install
if exist "%VSSDKPath%\lib\libtheora.lib" exit /b

copy /Y "%SourceCDX%\win32\VS2010\%Platform2%\Release\%ProjectName%.lib" "%VSSDKPath%\lib\libtheora.lib"
copy /Y "%SourceCDX%\win32\VS2010\%Platform2%\Release\%ProjectName%.lib" "%VSSDKPath%\lib\theoraenc.lib"
copy /Y "%SourceCDX%\win32\VS2010\%Platform2%\Release\%ProjectName%.lib" "%VSSDKPath%\lib\theoradec.lib"
xcopy /e /y /c /i "%SourceCDX%\include\theora\*.h" "%VSSDKPath%\include\theora\"

:: git source reset 
cd /D "%SourceCDX%"
if exist "%SourceCDX%\.git\" (
  git clean -xfd
  git checkout .
)
