@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=openssl
set LibraryName=libssl
set ProjectName=openssl
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: Compile openssl
echo ★★★★★ Perl %PackageName% ★★★★★
call %RootPath%src\delbtp %BuildPath%

CD /D "%RootPath%vs2022\vsbuild"
MD %~n0\%Platform1%

CD /D %BuildPath%
set CL=/MP
set "InstallOpenSSL=%VSSDKPath:\=/%"
call "%scoop%\apps\perl\current\perl\bin\perl.exe" %SourceCDX%\Configure %Platform5% no-shared no-tests no-docs --prefix="%InstallOpenSSL%"
nmake
nmake install

:: modify install
if exist "%VSSDKPath%\lib\ssl.lib" exit /b

copy /Y "%VSSDKPath%\lib\libssl.lib"    "%VSSDKPath%\lib\ssl.lib"
copy /Y "%VSSDKPath%\lib\libcrypto.lib" "%VSSDKPath%\lib\crypto.lib"
del "%VSSDKPath%\bin\openssl.pdb"
del "%VSSDKPath%\lib\ossl_static.pdb"

:: 安装 PC 文件
set "InstallPCPath=%VSSDKPath:\=/%"

@echo prefix=%InstallPCPath%>%VSSDKPath%\lib\pkgconfig\openssl.pc
@echo exec_prefix=${prefix}>>%VSSDKPath%\lib\pkgconfig\openssl.pc
@echo libdir=${exec_prefix}/lib>>%VSSDKPath%\lib\pkgconfig\openssl.pc
@echo includedir=${prefix}/include>>%VSSDKPath%\lib\pkgconfig\openssl.pc
@echo Name: OpenSSL>>%VSSDKPath%\lib\pkgconfig\openssl.pc
@echo Description: Secure Sockets Layer and cryptography libraries and tools>>%VSSDKPath%\lib\pkgconfig\openssl.pc
@echo Version: 1.1.1n>>%VSSDKPath%\lib\pkgconfig\openssl.pc
@echo Requires: libssl libcrypto>>%VSSDKPath%\lib\pkgconfig\openssl.pc
@echo Libs: -L${libdir} -llibssl -lcrypto -lws2_32 -lgdi32 -lcrypt32 -lUser32 -lAdvapi32>>%VSSDKPath%\lib\pkgconfig\openssl.pc
@echo Cflags: -I${includedir}>>%VSSDKPath%\lib\pkgconfig\openssl.pc

@echo prefix=%InstallPCPath%>%VSSDKPath%\lib\pkgconfig\libssl.pc
@echo exec_prefix=${prefix}>>%VSSDKPath%\lib\pkgconfig\libssl.pc
@echo libdir=${exec_prefix}/lib>>%VSSDKPath%\lib\pkgconfig\libssl.pc
@echo includedir=${prefix}/include>>%VSSDKPath%\lib\pkgconfig\libssl.pc
@echo Name: OpenSSL-libssl>>%VSSDKPath%\lib\pkgconfig\libssl.pc
@echo Description: Secure Sockets Layer and cryptography libraries>>%VSSDKPath%\lib\pkgconfig\libssl.pc
@echo Version: 1.1.1n>>%VSSDKPath%\lib\pkgconfig\libssl.pc
@echo Requires.private: libcrypto>>%VSSDKPath%\lib\pkgconfig\libssl.pc
@echo Libs: -L${libdir} -llibssl -lws2_32 -ladvapi32 -lcrypt32 -luser32>>%VSSDKPath%\lib\pkgconfig\libssl.pc
@echo Cflags: -I${includedir}>>%VSSDKPath%\lib\pkgconfig\libssl.pc

@echo prefix=%InstallPCPath%>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo exec_prefix=${prefix}>>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo libdir=${exec_prefix}/lib>>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo includedir=${prefix}/include>>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo enginesdir=${libdir}/engines-1_1>>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo Name: OpenSSL-libcrypto>>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo Description: OpenSSL cryptography library>>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo Version: 1.1.1n>>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo Libs: -L${libdir} -lcrypto -lws2_32 -lgdi32 -lcrypt32 -ladvapi32>>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo Libs.private: -lws2_32 -lgdi32 -lcrypt32 >>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
@echo Cflags: -I${includedir}>>%VSSDKPath%\lib\pkgconfig\libcrypto.pc
