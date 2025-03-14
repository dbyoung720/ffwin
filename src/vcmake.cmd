@echo off

set PackageName=%1
set LibraryName=%2
set ProjectName=%3
set SourceCDX=%4
set BuildPath=%5
set SpecialCMakeParam=%6
set CMakePath=%7

:: Dowload source
call %~dp0downgit %SourceCDX% %PackageName%

:: If exist library, exit build
if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: Delete build path
if exist "%BuildPath%" (
  rd /S /Q  "%BuildPath%"
)

:: Patch source
set PatchFile=%~dp0patch\%PackageName%.patch
if exist %PatchFile% (
	CD /D "%SourceCDX%"
	git apply --ignore-space-change --ignore-whitespace -v %PatchFile%
)

if defined CMakePath (
  set CMakeFilePath=%CMakePath%
) else (
  set CMakeFilePath=%SourceCDX%
)

if not exist "%SourceCDX%\CMakeLists.txt" (
  if exist "%~dp0patch\%PackageName%.txt" (
    copy /b /y "%~dp0patch\%PackageName%.txt" "%SourceCDX%\CMakeLists.txt"
  )
)

:: CMake source
echo ¡ï¡ï¡ï¡ï¡ï CMake %PackageName% ¡ï¡ï¡ï¡ï¡ï
set  SCP=%SpecialCMakeParam:~1,-1%
set  CMakeCommonParam=-DCMAKE_CONFIGURATION_TYPES=Release -DCMAKE_VERBOSE_MAKEFILE=ON -DUSE_MSVC_STATIC_RUNTIME=ON -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY="MultiThreaded$<$<CONFIG:Debug>:Debug>"
call %scoop%\apps\cmake\current\bin\cmake %SCP% %CMakeCommonParam% -S "%CMakeFilePath%" -G "%VSCMAKE%" -B "%BuildPath%" -DCMAKE_INSTALL_PREFIX="%VSSDKPath%" -Thost=%Platform1% -A %Platform2%
call %scoop%\apps\cmake\current\bin\cmake "%BuildPath%"

CD /D "%BuildPath%"
set "strOld=<RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>"
set "strNew=<RuntimeLibrary>MultiThreaded</RuntimeLibrary>"
for /f %%i in ('dir /b /s /a:-d *.vcxproj') do (
  powershell -Command "(gc %%i) -replace '%strOld%', '%strNew%' | Out-File %%i"
)

call %scoop%\apps\cmake\current\bin\cmake --build "%BuildPath%" --parallel --config Release --target install

:: If build error, pause
if %errorlevel% NEQ 0 (
	echo ¡ï¡ï¡ï¡ï¡ï compile error. ¡ï¡ï¡ï¡ï¡ï 
	pause
)

:: Git source reset 
cd /D "%SourceCDX%"
if exist "%SourceCDX%\.git\" (
  git clean -xfd
  git checkout .
)
