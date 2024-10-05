@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=libvpx
set LibraryName=vpx
set ProjectName=vpx
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform%

:: Dowload source
call downgit %SourceCDX% %PackageName%

if exist "%VSSDKPath%\lib\%LibraryName%.lib" exit /b

:: start compiling
call %RootPath%src\delbtp %BuildPath%
CD /D %BuildPathX%
MD %~n0\%Platform1%
CD /D %BuildPath%

call %~dp0buildgcc.cmd "--target=%platformE% --disable-examples --disable-tools --disable-unit-tests --disable-docs --disable-install-bins --disable-shared --enable-static --enable-static-msvcrt --enable-vp9-postproc --enable-vp9-highbitdepth" %PackageName% "%SourceCDX%"

SET "PARAMS=-property installationPath -requires Microsoft.Component.MSBuild Microsoft.VisualStudio.Component.VC.ATLMFC Microsoft.VisualStudio.Component.VC.Tools.x86.x64  -latest -prerelease -version [,17.0)"
set "VS2022=vswhere.exe %PARAMS%"
FOR /f "delims=" %%A IN ('!VS2022!') DO SET "VCVARS=%%A\Common7\Tools\vsdevcmd.bat"
call "%VCVARS%" -no_logo -arch=%Platform3%

echo ★★★★★ VS2022 multi process build %PackageName% ★★★★★
call MSBuild.exe "%BuildPath%\vpx.sln" /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
	/target:Build /property:Configuration=Release;Platform=%Platform2%^
	/flp1:LogFile=%BuildPath%\zxerr.log;Verbosity=diagnostic;errorsonly^
	/flp2:LogFile=%BuildPath%\zxwas.log;Verbosity=diagnostic;warningsonly

if %errorlevel% NEQ 0 (
	echo ★★★★★ compile %PackageName% error. press any key to open project with vs2022 ★★★★★ 
	pause
	call "%BuildPath%\vpx.sln"
	pause
)

:: 备份原有的系统搜索路径
set BackupPath=%Path%
set "msys2=%scoop%\apps\msys2\current"
set "Path=%msys2%;%msys2%\usr\bin;%msys2%\%platform9%\bin;"

CD /D %BuildPath%
bash -c "make install"
copy /b /y "%VSSDKPath%\lib\%Platform2%\vpxmt.lib" "%VSSDKPath%\lib\vpxmt.lib"
copy /b /y "%VSSDKPath%\lib\%Platform2%\vpxmt.lib" "%VSSDKPath%\lib\vpx.lib"

:: 还原原先的系统搜索路径
set Path=%BackupPath%

