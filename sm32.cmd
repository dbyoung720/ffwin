@echo off
:: 如果 msys2 没有安装编译工具，请执行此文本。这是 x86 版本
:: 执行此文本前，必须保证 scoop 当前安装的是 x86 版本；系统环境变量 scoop 指向 x86 版本

call %~dp0proxy.cmd
set httpAddr=%httpproxyIP%
set httpPort=%httpproxyPT%

set msys2=%scoop%\apps\msys2\current
set "MSys2Platform01=mingw-w64-i686"
set "MSys2Platform02=mingw32"
set "MSys2Platform03=mingw-w64-clang-i686"

set "Path=%msys2%\usr\bin;%Path%"

:: 设置 scoop 网络代理
call scoop config proxy %httpAddr%:%httpPort%
call scoop config USE_LESSMSI $true

echo 安装 msys2 工具包
echo export http_proxy=%httpAddr%:%httpPort%>%msys2%\etc\profile.d\proxy.sh
echo export https_proxy=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
echo export ftp_proxy=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
echo export HTTP_PROXY=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
echo export HTTPS_PROXY=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
echo export FTP_PROXY=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
echo Close form after Initial setup complete. Press any key to continue.
call %msys2%\%MSys2Platform02%.exe
pause
bash -c "pacman --noconfirm -Syu"
bash -c "pacman --noconfirm -Su"
bash -c "pacman -S --noconfirm git subversion cvs mercurial doxygen swig p7zip lzip ed meson automake autoconf libtool m4 make cmake gettext gmp pkg-config findutils ruby ruby-docs yasm nasm patch perl dos2unix unzip gperf flex bison autogen python3 help2man"
bash -c "pacman -S --noconfirm --needed base-devel msys2-devel  %MSys2Platform01%-toolchain"
bash -c "pacman -S --noconfirm %MSys2Platform01%-python-certifi %MSys2Platform01%-meson %MSys2Platform01%-yasm %MSys2Platform01%-nasm %MSys2Platform01%-gtk3 %MSys2Platform01%-cmake %MSys2Platform01%-ninja %MSys2Platform01%-openh264 %MSys2Platform01%-ffmpeg %MSys2Platform01%-libjpeg-turbo %MSys2Platform01%-lua51 %MSys2Platform01%-llvm %MSys2Platform01%-qt5-static %MSys2Platform01%-gimp %MSys2Platform01%-gflags %MSys2Platform01%-hdf5"
bash -c "pacman -S --noconfirm %MSys2Platform03%-cmake %MSys2Platform03%-cc %MSys2Platform03%-meson %MSys2Platform03%-python-glad %MSys2Platform03%-python-jinja %MSys2Platform03%-vulkan %MSys2Platform03%-fast_float %MSys2Platform03%-glslang %MSys2Platform03%-tools"
