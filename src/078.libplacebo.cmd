@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libplacebo
set LibraryName=libplacebo
set ProjectName=libplacebo
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

if exist "%VSSDKLIB%\%LibraryName%.lib" exit /b

:: Dowload source
call downgit %SourceCDX% %PackageName%

:: Patch source
set PatchFile=%RootPath%src\patch\%PackageName%.patch
if exist %PatchFile% (
	CD /D "%SourceCDX%"
	git apply --ignore-space-change --ignore-whitespace -v %PatchFile%
)

:: Ninja libplacebo
echo ¡ï¡ï¡ï¡ï¡ï CMake %PackageName% ¡ï¡ï¡ï¡ï¡ï
set  VKInstall=%VSSDKPath:\=/%
call %RootPath%src\delbtp %BuildPath%
set CC=clang
set CXX=clang++
%scoop%\apps\python39\current\Scripts\meson setup -Ddefault_library=static -Doptimization=3 -Ddebug=false -Dd3d11=enabled -Dglslang=disabled -Dopengl=disabled -Ddefault_library=static -Ddemos=false -Db_vscrt=mt -Dvulkan-registry=%VKInstall%/share/vulkan/registry/vk.xml --prefix=%VSSDKPath% %SourceCDX% %BuildPath%

set "compilemt=%BuildPath%\compile_commands.json"
set "strOld= -MD "
set "strNew= -MT "
%windir%\System32\WindowsPowerShell\v1.0\powershell -Command "(gc '%compilemt%') -replace '%strOld%', '%strNew%' | Out-File '%compilemt%' -encoding ASCII"

%scoop%\apps\ninja\current\ninja -C %BuildPath%
%scoop%\apps\ninja\current\ninja -C %BuildPath% install

:: check build error
if %errorlevel% NEQ 0 (
	echo ¡ï¡ï¡ï¡ï¡ï compile error. ¡ï¡ï¡ï¡ï¡ï 
	pause
)

:: modify install
if exist %VSSDKPath%\lib\libplacebo.lib goto bEnd

copy /b %VSSDKPath%\lib\libplacebo.a %VSSDKPath%\lib\libplacebo.lib
copy /b %VSSDKPath%\lib\libplacebo.a %VSSDKPath%\lib\placebo.lib

set "strMakeFile=%PCInstall%\libplacebo.pc"
set "strOldMake=Libs: "
set "strNewMake=Libs: -L${libdir} -llibplacebo -lvulkan -lglslang -lshlwapi -lAdvapi32 -lCfgMgr32 -lversion -lshaderc -lshaderc_util -lspirv-cross-c -llcms2 -lSPIRV-Tools-diff -lSPIRV-Tools-link -lSPIRV-Tools-lint -lSPIRV-Tools-opt -lSPIRV-Tools-reduce -lSPIRV-Tools -lSPIRV "
call %RootPath%src\rtl %strMakeFile% %strOldMake% "%strNewMake%"

:bEnd
:: Get source reset
if exist "%SourceCDX%\.git\" (
  CD /D %SourceCDX%
  git clean -d -fx -f
  git checkout .
)
