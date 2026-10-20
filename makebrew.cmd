@echo off
powershell.exe -NoProfile -File "%~dp0makebrew.ps1" %*
exit /b %ERRORLEVEL%
