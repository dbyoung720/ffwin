@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=rav1e
set LibraryName=rav1e
set ProjectName=rav1e
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%
set CARGO_CFG_TARGET_FEATURE=crt-static
set RUSTFLAGS=-C target-feature=+crt-static

call %~dp0createbcd %~n0

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: cargo rav1e
echo ¡ï¡ï¡ï¡ï¡ï cargo %PackageName% ¡ï¡ï¡ï¡ï¡ï
CD /D "%SourceCDX%"
cargo install cargo-c --force
cargo cbuild --release

:: install
set targetPath=%SourceCDX%\target\%PlatformD%\release
xcopy /e /y /c /i "%targetPath%\include\*.*"   "%VSSDKPath%\include\" 
copy /Y %targetPath%\rav1e.lib "%VSSDKPath%\lib\rav1e.lib"
copy /Y %targetPath%\rav1e.pc  "%VSSDKPath%\lib\pkgconfig\rav1e.pc"

set GCCSDKPath=%VSSDKPath:\=/%
set "PCFileName=%PCInstall%\rav1e.pc"
call powershell -Command "(gc %PCFileName%) -replace  'prefix=/usr/local', 'prefix=%GCCSDKPath%' | Out-File %PCFileName% -encoding ASCII"

:: git source reset 
cd /D "%SourceCDX%"
git clean -xfd
git checkout .
