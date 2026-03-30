@echo off
title PhoneDrop
color 0A
cls

echo.
echo  +------------------------------------------+
echo  ^|          PhoneDrop  [phone -^> PC]        ^|
echo  +------------------------------------------+
echo.

:: Check if Node.js is installed
where node >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo  [!] Node.js is not installed.
    echo.
    echo  Installing via winget...
    winget install OpenJS.NodeJS.LTS --silent
    if %errorlevel% neq 0 (
        echo.
        echo  [!] Auto-install failed. Please install Node.js manually:
        echo      https://nodejs.org
        echo.
        pause
        exit /b 1
    )
    echo  [+] Node.js installed. Restarting...
    timeout /t 2 /nobreak >nul
    start "" "%~f0"
    exit /b
)

:: Install dependencies if node_modules is missing
if not exist "%~dp0node_modules" (
    echo  [*] First run - installing dependencies...
    echo.
    cd /d "%~dp0"
    call npm install --silent
    echo.
)

cd /d "%~dp0"

:: Start server (runs in this window, browser opens separately)
echo  [*] Starting server...
echo.

:: Launch server in background briefly to detect port
start /b node "%~dp0dist-bundle\index.js" > "%~dp0phonedrop.log" 2>&1
timeout /t 2 /nobreak >nul

:: Extract port from log (looks for "localhost:NNNNN")
for /f "tokens=2 delims=:" %%a in ('findstr /i "localhost:" "%~dp0phonedrop.log"') do (
    set PORT=%%a
    goto :found
)
set PORT=49372
:found
set PORT=%PORT: =%

start "" "http://localhost:%PORT%"
echo  [+] Server running at http://localhost:%PORT%
echo  [+] Browser opened automatically
echo  [+] Files saved to: %~dp0received\
echo.
echo  Press Ctrl+C or close this window to stop.
echo.

:: Keep the window open and show live log
node "%~dp0dist-bundle\index.js"

pause
