@echo off
setlocal EnableDelayedExpansion

set msBuildPath=%1
set PackageName=%2
set ProjectName=%3
set msbPlatform=%4

if not exist "%msBuildPath%\%ProjectName%.sln" ( goto bEnd)

CD /D "%msBuildPath%"
set "strOld=<RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>"
set "strNew=<RuntimeLibrary>MultiThreaded</RuntimeLibrary>"
for /f %%i in ('dir /b /s /a:-d *.vcxproj') do (
  powershell -Command "(gc %%i) -replace '%strOld%', '%strNew%' | Out-File %%i"
)

echo   ¡ï¡ï¡ï¡ï¡ï VS2022 multi process build %PackageName% ¡ï¡ï¡ï¡ï¡ï
call MSBuild.exe "%msBuildPath%\%ProjectName%.sln" /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
	/target:Build /property:Configuration=Release;Platform=%msbPlatform%^
	/flp1:LogFile=%msBuildPath%\zxerr.log;Verbosity=diagnostic;errorsonly^
	/flp2:LogFile=%msBuildPath%\zxwas.log;Verbosity=diagnostic;warningsonly

if %errorlevel% NEQ 0 (
	echo ¡ï¡ï¡ï¡ï¡ï compile %PackageName% error. press any key to open project with vs2022 ¡ï¡ï¡ï¡ï¡ï 
	pause
	call "%msBuildPath%\%ProjectName%.sln"
	pause
)

:bEnd
