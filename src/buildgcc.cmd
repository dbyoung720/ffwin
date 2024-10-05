@echo off
setlocal EnableDelayedExpansion
color A

set "BuildParam=%1"
set PackageName=%2
set "SourceCDX=%3"

:: Delete first/bottom
set BuildParam=%BuildParam:~1,-1%

:: GCC style path
set VSSDKPathX=%VSSDKPath:\=/%

:: Backup system search path
set BackupPath=%Path%

:: Env
set "msys2=%scoop%\apps\msys2\current"
set "Path=%psInstall%;%msys2%;%msys2%\usr\bin;%msys2%\%platform9%\bin;%CUDA_PATH%\bin"
call "%VSInstallPath%\Common7\Tools\vsdevcmd.bat" -no_logo -arch=%Platform3%
set "INCLUDE=%VSSDKINC%;%VSSDKINC%\sdl2;%VSSDKINC%\mfx;%VSSDKINC%\libxml2;%VSSDKINC%\freetype2;%VSSDKINC%\TBB;%VSSDKINC%\harfbuzz;%cudaincXX%;%vulkaninc%;%INCLUDE%"
set "LIB=%VSSDKLIB%;%cudalibXX%;%vulkanlib%;%VCToolsInstallDir%atlmfc\lib\%Platform%;%LIB%"
set "UseEnv=True"
set MSYS2_PATH_TYPE=inherit
set BackupCurrentDir=%CD%

:: Patch source
set PatchFile=%RootPath%src\patch\%PackageName%.patch
if exist %PatchFile% (
	CD /D "%SourceCDX%"
	git apply --ignore-space-change --ignore-whitespace -v %PatchFile%
)

CD /D "%BackupCurrentDir%"

:: Configure
echo %PackageName% configure in progress, please waitting for ...... 

if /I %PackageName%==ffmpeg (
  bash -c "../../../source/%PackageName%/configure %BuildParam% --prefix=%VSSDKPathX%/ffmpeg/%date%"
) else if /I %PackageName%==libvpx (
	bash -c "../../../source/%PackageName%/configure %BuildParam% --prefix=%VSSDKPathX%"
) else (
	bash -c "CC=cl ../../../source/%PackageName%/configure %BuildParam% --host=%Platform7% --prefix=%VSSDKPathX%"
)
bash -c "make -j 16"
bash -c "make install"

:: Restore old path
set Path=%BackupPath%

:: Check compile error
if %errorlevel% NEQ 0 (
  echo An error occurred, compile %PackageName% stop¡£
  pause
)

:: Get source reset
if exist "%SourceCDX%\.git\" (
  CD /D %SourceCDX%
  git clean -d -fx -f
  git checkout .
)
