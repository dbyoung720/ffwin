@echo off
setlocal EnableDelayedExpansion
title build ffmpeg %1 on windows with vs2022
CD /D %~dp0
set "RootPath=%~dp0"

:: Compile platform : x86 / x64
set Platform=%1

:: VPN proxy
call %RootPath%proxy.cmd
set httpAddr=%httpproxyIP%
set httpPort=%httpproxyPT%
set http_proxy=%httpAddr%:%httpPort%
set https_proxy=%httpAddr%:%httpPort%

:: Platform
if %Platform%==x86 (
  set Platform1=x86
  set Platform2=Win32
  set Platform3=x86
  set Platform4=32
  set Platform5=VC-WIN32
  set Platform6=win32
  set Platform7=i686-w64-mingw32
  set Platform8=x32
  set platform9=mingw32
  set platformA=x86_32
  set platformB=x86-windows-static
  set platformC=mingw-w64-i686
  set platformD=i686-pc-windows-msvc
  set platformE=x86-win32-vs17
) else (
  set Platform1=x64
  set Platform2=x64
  set Platform3=amd64
  set Platform4=64
  set Platform5=VC-WIN64A
  set Platform6=win64
  set Platform7=x86_64-w64-mingw32
  set Platform8=x64
  set platform9=mingw64
  set platformA=x86_64
  set platformB=x64-windows-static
  set platformC=mingw-w64-x86_64
  set platformD=x86_64-pc-windows-msvc
  set platformE=x86_64-win64-vs17
)

:: Env
set "MSYS2Path=%scoop%\apps\msys2\current"
set "CUDA_PATH=%scoop%\apps\cuda\current"
set "Vulkan_CD=%scoop%\apps\Vulkan\current
set "psInstall=%SystemRoot%\System32\WindowsPowerShell\v1.0"
set "VSSDKPath=%RootPath%vs2022\vssdk\%Platform%"
set "Path=%scoop%\shims;%psInstall%;%VSSDKPath%;%VSSDKPath%\bin;%CUDA_PATH%\bin;%Path%"

:: source path¡¢comple temp path¡¢pc file intall path
set "SourcePath=%RootPath%vs2022\source"
set "BuildPathX=%RootPath%vs2022\vsbuild"
set "PCInstall=%VSSDKPath%\lib\pkgconfig"

:: third library inc/lib search path
set "VSSDKINC=%VSSDKPath%\include"
set "VSSDKLIB=%VSSDKPath%\lib"
set "cudaincXX=%CUDA_PATH%\include"
set "cudalibXX=%CUDA_PATH%\lib\%Platform2%"
set "vulkaninc=%Vulkan_CD%\include"
set "vulkanlib=%Vulkan_CD%\lib"

set "PKG_CONFIG_PATH=%VSSDKLIB%\pkgconfig"
set "PkgConfigPEPath=%scoop%\apps\pkg-config\current\pkg-config.exe"

:: check vs2022 already installed
for %%G in (Community,Professional,Enterprise) do (
  if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\%%G" (
    set "VSInstallPath=%ProgramFiles(x86)%\Microsoft Visual Studio\2022\%%G"
  )
  if exist "%ProgramFiles%\Microsoft Visual Studio\2022\%%G" (
    set "VSInstallPath=%ProgramFiles%\Microsoft Visual Studio\2022\%%G"
  )
)

if "%VSInstallPath%"=="" (
  echo "Visual Studio 2022 not found"
  pause
  goto bEnd
)

:: int VS2022 env
call "%VSInstallPath%\Common7\Tools\vsdevcmd.bat" -no_logo -arch=%Platform3%
set "INCLUDE=%RootPath%vs2022\source\ffmpeg\compat\stdbit;%VSSDKINC%;%VSSDKINC%\sdl2;%VSSDKINC%\mfx;%VSSDKINC%\libxml2;%VSSDKINC%\freetype2;%VSSDKINC%\TBB;%VSSDKINC%\harfbuzz;%cudaincXX%;%vulkaninc%;%INCLUDE%"
set "LIB=%VSSDKLIB%;%cudalibXX%;%vulkanlib%;%VCToolsInstallDir%atlmfc\lib\%Platform1%;%LIB%"
set "UseEnv=True"

:: CMake compile type
set "VSCMAKE=Visual Studio 17 2022"

:: Create temp path
if not exist %RootPath%vs2022 (
  CD /D "%RootPath%
  MD vs2022
)

if not exist %RootPath%vs2022\source (
  CD /D "%RootPath%vs2022"
  MD source
)

if not exist %RootPath%vs2022\vssdk (
  CD /D "%RootPath%vs2022"
  MD vssdk
)

if not exist %RootPath%vs2022\vssdk\%Platform% (
  CD /D "%RootPath%vs2022\vssdk"
  MD %Platform%
)

if not exist %RootPath%vs2022\vssdk\%Platform%\lib (
  CD /D "%RootPath%vs2022\vssdk\%Platform%"
  MD lib
)

:: compile third library and ffmpeg
cls
CD /D %RootPath%src

for /f %%i in ('dir /b /a:-d *.*.cmd') do (
  set   SourceCodeLibraryName=%%i	
  title build ffmpeg %platform% on windows with vs2022 --- !SourceCodeLibraryName!
  call  !SourceCodeLibraryName!
  cls
)

:: ffmpeg compile finished
echo compile ffmpeg finished.
 
pause

:bEnd
