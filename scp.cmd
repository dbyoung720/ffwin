@echo off
setlocal EnableDelayedExpansion
set platform=%1

:: create vs2022 directory
cd /d %~dp0
if not exist %~dp0vs2022 (
 MD vs2022
)
CD /D %~dp0vs2022

:: Env
set "Path=%windir%;%windir%\system32;%windir%\system32\WindowsPowerShell\v1.0"

:: Platform
if %Platform%==x86 (
  set MSys2Platform01=mingw-w64-i686
  set MSys2Platform02=mingw32
  set MSys2Platform03=mingw-w64-clang-i686
) else (
  set MSys2Platform01=mingw-w64-x86_64
  set MSys2Platform02=mingw64
  set MSys2Platform03=mingw-w64-clang-x86_64
)

:: vpn proxy
call %~dp0proxy.cmd

:: check scoop installed
where scoop.cmd >NUL 2>NUL
if "%ERRORLEVEL%" NEQ "0" (
  echo scoop not install
  goto installscoop
) else (
  :: scoop already installed. check installed path equal to current directory
  for /F "tokens=1,2,3 delims= " %%A in ('reg query "HKEY_CURRENT_USER\Environment" /v SCOOP') DO SET appdir=%%C
	if  /I "!scoop!" EQU "!Appdir!" (
	  echo scoop installed
	  goto bEnd
	) else (
	  echo install scoop in current directory
	  reg add "HKEY_CURRENT_USER\Environment" /v SCOOP /t REG_SZ /d "%scoop%"
	  taskkill /IM explorer.exe
	  start explorer.exe
	)
)

:installscoop
  title install scoop(%platform%) in your pc, please wait......
	set "Path=%backupPath"
	call powershell -Command "irm get.scoop.sh -outfile 'install.ps1'"
	call powershell -Command "%RootPath%vs2022\install.ps1 -ScoopDir '%scoop%' -Proxy 'http://%httpproxyIP%:%httpproxyPT%'"
	call powershell -Command "$env:SCOOP='%scoop%'"
  :: install git
  CD /D %scoop%\shims
  call scoop config proxy %httpproxyIP%:%httpproxyPT%
  call scoop config USE_LESSMSI $true
	call scoop install aria2 git
	git config --global http.proxy  %httpproxyIP%:%httpproxyPT%
	git config --global https.proxy %httpproxyIP%:%httpproxyPT%
  git config --global core.autocrlf false
  git config --global user.email "dbyoung@sina.com"
  git config --global user.name  "dbyoung"
  :: intall bucket
	call scoop bucket add extras
	call scoop bucket add java
	call scoop bucket add versions

:: install other compile tools
if %platform%==x64 (
  title install scoop -- %platform% in your pc, please wait......
	call scoop install ccache cmake doxygen go graphviz jom llvm meson msys2 nasm yasm ninja pandoc perl pkg-config python39 rust-msvc vulkan
) else (
  title install scoop--- %platform% in your pc, please wait......
	call scoop install ccache cmake go graphviz llvm nasm yasm pkg-config python39 rust-msvc vulkan -a %Platform%
	call scoop install cuda doxygen jom meson msys2 ninja pandoc perl
)

:: Initial python tools
if not exist "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\meson.exe" (
   call "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\pip" install meson
   call "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\pip" install ninja
   call "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\pip" install pylint
   call "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\pip" install numpy
   call "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\pip" install flake8
	 call "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\pip" install PyYaml
   call "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\pip" install matplotlib
	 call "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\pip" install jinja2
	 call "%RootPath%vs2022\scoop\%Platform%\apps\python39\current\Scripts\pip" install opencv-python-full
)

:: Initial msys2 tools
if not exist "%MSYS2Path%\%MSys2Platform02%\bin\gcc.exe" (
	echo install msys2 tools
	echo export http_proxy=%httpproxyIP%:%httpproxyPT%>%MSYS2Path%\etc\profile.d\proxy.sh
	echo export https_proxy=%httpproxyIP%:%httpproxyPT%>>%MSYS2Path%\etc\profile.d\proxy.sh
	echo export ftp_proxy=%httpproxyIP%:%httpproxyPT%>>%MSYS2Path%\etc\profile.d\proxy.sh
	echo export HTTP_PROXY=%httpproxyIP%:%httpproxyPT%>>%MSYS2Path%\etc\profile.d\proxy.sh
	echo export HTTPS_PROXY=%httpproxyIP%:%httpproxyPT%>>%MSYS2Path%\etc\profile.d\proxy.sh
	echo export FTP_PROXY=%httpproxyIP%:%httpproxyPT%>>%MSYS2Path%\etc\profile.d\proxy.sh
	echo Close form after Initial setup complete. Press any key to continue.
	call %MSYS2Path%\%MSys2Platform02%.exe
	pause
	bash -c "pacman --noconfirm -Syu"
	bash -c "pacman --noconfirm -Su"
	bash -c "pacman -S --noconfirm git subversion cvs mercurial doxygen swig p7zip lzip ed meson automake autoconf libtool m4 make cmake gettext gmp pkg-config findutils ruby ruby-docs yasm nasm patch perl dos2unix unzip gperf flex bison autogen python3 help2man"
	bash -c "pacman -S --noconfirm --needed base-devel msys2-devel %MSys2Platform01%-toolchain"
  bash -c "pacman -S --noconfirm %MSys2Platform01%-python-certifi %MSys2Platform01%-meson %MSys2Platform01%-yasm %MSys2Platform01%-nasm %MSys2Platform01%-gtk3 %MSys2Platform01%-cmake %MSys2Platform01%-ninja %MSys2Platform01%-openh264 %MSys2Platform01%-ffmpeg %MSys2Platform01%-libjpeg-turbo %MSys2Platform01%-lua51 %MSys2Platform01%-llvm %MSys2Platform01%-qt5-static %MSys2Platform01%-gimp %MSys2Platform01%-gflags %MSys2Platform01%-glog %MSys2Platform01%-hdf5"
	bash -c "pacman -S --noconfirm %MSys2Platform03%-cmake %MSys2Platform03%-cc %MSys2Platform03%-meson %MSys2Platform03%-python-glad %MSys2Platform03%-python-jinja %MSys2Platform03%-vulkan %MSys2Platform03%-fast_float %MSys2Platform03%-glslang %MSys2Platform03%-tools"
)

:bEnd
