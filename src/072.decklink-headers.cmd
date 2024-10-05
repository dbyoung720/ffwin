@echo off
setlocal EnableDelayedExpansion
color A

set PackageName=decklink-headers
set LibraryName=DeckLinkAPI
set ProjectName=DeckLinkAPI
set SourceCDX=%SourcePath%\%packageName%
set BuildPath=%BuildPathX%\%~n0\%Platform1%

if exist "%VSSDKINC%\DeckLinkAPIVersion.h" exit /b

set cmdline=%windir%\System32\WindowsPowerShell\v1.0\powershell -NoProfile -ExecutionPolicy Bypass -Command "%RootPath%src\readini.ps1 -filePath '%RootPath%src\daddr.ini' -section 'http' -key '%PackageName%'"
FOR /f "delims=" %%A IN ('%cmdline%') DO SET "HTTPURL=%%A"
git clone --progress --recursive "%HTTPURL%" "%SourceCDX%"
xcopy /e /y /c /i "%SourceCDX%\include\*.*"  "%VSSDKINC%\" 
