@echo off
setlocal EnableDelayedExpansion

set srcHttpdownURL=%1
set srcWebfilename=%2
set tarWebfileName=%3
set srcLibraryName=%4
set srcpackageName=%5
set RootPath=%6
set platform=%7

set HTTPURLX=%srcHttpdownURL%%srcWebfilename%
set DownPath=%RootPath%vs2022\download
set FilePath=%RootPath%vs2022\download\%srcWebfilename%
set SourceCD=%SourcePath%\%srcLibraryName%

if exist "%SourceCD%" (goto bEnd)
if exist "%FilePath%" (goto unzip)

echo ¡ï¡ï¡ï¡ï¡ï download %srcpackageName% from %HTTPURLX% ¡ï¡ï¡ï¡ï¡ï 
call powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).Downloadfile('%HTTPURLX%', '%FilePath%'))"

:unzip
echo ¡ï¡ï¡ï¡ï¡ï unzip %srcpackageName% ¡ï¡ï¡ï¡ï¡ï 
call %RootPath%vs2022\scoop\%platform%\apps\7zip\current\7z x -aoa -y "%DownPath%\%srcWebfilename%" "-o%DownPath%"
call %RootPath%vs2022\scoop\%platform%\apps\7zip\current\7z x -aoa -y "%DownPath%\%tarWebfileName%" "-o%RootPath%vs2022\src"

:bEnd
