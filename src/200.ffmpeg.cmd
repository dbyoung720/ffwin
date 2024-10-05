@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=ffmpeg
set LibraryName=avcodec
set ProjectName=ffmpeg
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%
set CurrDate=%date%

:: Dowload source
call %~dp0downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\ffmpeg\%CurrDate%\bin\%LibraryName%.lib" exit /b

:: ffmpeg common param
set "libtp=--enable-shared --disable-static"
set "commf=--enable-gpl --enable-version3 --enable-nonfree --enable-cross-compile --enable-optimizations --arch=%platformA% --enable-asm --enable-x86asm" 
set "vcpar=--toolchain=msvc --cc=cl.exe --cxx=cl.exe --windres=rc.exe --ld=link.exe --ar='ar-lib lib.exe' --ranlib=':' --extra-version='%CurrDate%'"
set "cflag=--extra-cflags='-I%VSSDKINC%' --extra-cflags='-I%cudaincXX%' --extra-cflags='-I%vulkaninc%' --extra-cflags='-I%RootPath%vs2022\source\ffmpeg\compat\stdbit' --extra-cflags=-wd4333 --extra-cflags=-wd4006 --extra-cflags=-wd4819 --extra-cflags=-wd4313 --extra-cflags=-wd4267 --extra-cflags=-wd4113 --extra-cflags=-wd4133 --extra-cflags=-wd4114 --extra-cflags=-wd4334 --extra-cflags=-wd4293 --extra-cflags=-wd4101"
set "libpr=--extra-ldflags='/LIBPATH:%VSSDKLIB%' --extra-ldflags='/LIBPATH:%cudalibXX%' --extra-ldflags='/LIBPATH:%vulkanlib%' --extra-ldflags='/FORCE:MULTIPLE'"
set "pkgpr=--pkg-config='%PkgConfigPEPath%' --pkg-config-flags='--static'"
set "statc=--extra-cflags=-DAL_LIBTYPE_STATIC --extra-cflags=-DCACA_STATIC --extra-cflags=-DCHROMAPRINT_NODLL --extra-cflags=-DKVZ_STATIC_LIB --extra-cflags=-DLIBTWOLAME_STATIC --extra-cflags=-DLIBXML_STATIC --extra-cflags=-DMODPLUG_STATIC --extra-cflags=-DZMQ_STATIC --extra-cflags=-DKHRONOS_STATIC --extra-cflags=-DLZMA_API_STATIC --extra-cflags=-DJXL_STATIC_DEFINE"
set "third=--disable-debug --disable-autodetect --enable-amf --enable-bzlib --enable-fontconfig --enable-iconv --enable-libaom --enable-libass --enable-libfdk-aac --enable-libfribidi --enable-libfreetype --enable-libmp3lame --enable-libmysofa --enable-libopus --enable-libvorbis --enable-libvpx --enable-libdav1d --enable-libsrt --enable-zlib --enable-sdl2 --enable-lzma --enable-vulkan --enable-libx264 --enable-libx265 --enable-libopenh264 --enable-libkvazaar --enable-librav1e --enable-decklink --enable-libtesseract --enable-libopenmpt --enable-libjxl --enable-opencl --enable-opengl --enable-openssl --enable-libplacebo --enable-libharfbuzz --enable-libopenjpeg --enable-libtheora --enable-libwebp --enable-libxml2 "

set "cflag=%cflag:\=/%"
set "libpr=%libpr:\=/%"
set "pkgpr=%pkgpr:\=/%"

:: ffmpeg hwacclate param
if /I %platform%==x86 (
  set "hwacc=--enable-dxva2 --enable-mediafoundation --enable-d3d11va --enable-cuda_nvcc --enable-nvdec --enable-nvenc --enable-cuvid --enable-ffnvcodec --enable-libvpl --enable-opencl"
) else (
  set "hwacc=--enable-dxva2 --enable-mediafoundation --enable-d3d11va --enable-cuda_nvcc --enable-nvdec --enable-nvenc --enable-cuvid --enable-ffnvcodec --enable-libvpl --enable-opencl --enable-cuda_llvm --enable-libnpp"
)

if not exist "%VSSDKPath%\lib\m.lib" (
  copy /b /y "%VSSDKPath%\lib\zlib.lib" "%VSSDKPath%\lib\m.lib"
)

:: start compiling
call %RootPath%src\delbtp %BuildPath%
CD /D %BuildPathX%
MD %~n0\%Platform%
CD %BuildPath%

call %~dp0buildgcc.cmd "%libtp% %commf% %statc% %vcpar% %pkgpr% %cflag% %libpr% %hwacc% %third%" %PackageName% "%SourceCDX%"
