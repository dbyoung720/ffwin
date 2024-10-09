@echo off
setlocal EnableDelayedExpansion

set SourceSaveX=%1
set PackageName=%2

:: check if exist source code 
if exist "%SourceSaveX%" (goto bEnd)

:: get source code download url from daddr.ini file
set cmdline=%windir%\System32\WindowsPowerShell\v1.0\powershell -NoProfile -ExecutionPolicy Bypass -Command "%RootPath%src\readini.ps1 -filePath '%RootPath%src\daddr.ini' -section 'http' -key '%PackageName%'"
FOR /f "delims=" %%A IN ('%cmdline%') DO SET "HTTPURL=%%A"

:: check if have branch
set "delimiter=#"
echo %HTTPURL% | findstr /C:"%delimiter%" >nul 2>&1
if errorlevel 1 (
	echo git clone source code from "!HTTPURL!"
) else (
	for /f "tokens=1,2 delims=^%delimiter%" %%a in ("%HTTPURL%") do (
  set "part1=%%a"
  set "part2=%%b"
  )
)

:: download source code
echo ¡ï¡ï¡ï¡ï¡ï download %PackageName% ¡ï¡ï¡ï¡ï¡ï
if /I "%PackageName%" == "opusfile" (
	echo git clone source code from "!HTTPURL!"
	git clone --progress --recursive "%HTTPURL%" "%SourceSaveX%"
	goto bEnd
)

if /I "%PackageName%" == "x265" (
	echo git clone source code from "!HTTPURL!"
	git clone --progress --recursive "%HTTPURL%" "%SourceSaveX%"
	goto bEnd
)

if /I "%PackageName%" == "SPIRV-Tools" (
	call git clone --progress --recursive "%HTTPURL%" "%SourceSaveX%"
	call git clone --progress --recursive "https://github.com/KhronosGroup/SPIRV-Headers.git" "%SourceSaveX%\external\SPIRV-Headers"
	call git clone --progress --recursive "https://github.com/google/googletest.git" "%SourceSaveX%\external\googletest"
	goto bEnd
)

if (%part2%)==() (
	git clone --progress --recursive "%HTTPURL%" "%SourceSaveX%"  --depth 1 
) else (
	echo git clone source code from "%part1%" branch %part2%
	git clone --progress --recursive --branch %part2% "%part1%" "%SourceSaveX%"  --depth 1 
)

:bEnd
