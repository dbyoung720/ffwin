@echo off
:: delete build temp path

set BuildTempPath=%1

if exist %BuildTempPath% (
  rd /S /Q  "%BuildTempPath%"
)
