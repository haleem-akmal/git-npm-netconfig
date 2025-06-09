@echo off
chcp 65001 >nul
setlocal 
set ERRLOG=%TEMP%\npm_proxy_error.log

REM ------------------------------
REM Choose default or custom proxy
REM ------------------------------
:choose_proxy
cls
echo ================================
echo ██╗  ██╗██╗     ███╗   ███╗    ██╗   ██╗██████╗ ███╗   ██╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
echo ██║  ██║██║     ████╗ ████║    ██║   ██║██╔══██╗████╗  ██║    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
echo ███████║██║     ██╔████╔██║    ██║   ██║██████╔╝██╔██╗ ██║    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
echo ██╔══██║██║     ██║╚██╔╝██║    ╚██╗ ██╔╝██╔═══╝ ██║╚██╗██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
echo ██║  ██║███████╗██║ ╚═╝ ██║     ╚████╔╝ ██║     ██║ ╚████║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
echo ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝      ╚═══╝  ╚═╝     ╚═╝  ╚═══╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝

echo -----------------------------------------------
echo Git ^& npm Proxy Configuration
echo ================================
echo ➤ Choose a proxy mode:
echo [1] Use Default Proxy (127.0.0.1:10808)
echo [2] Enter Custom Proxy
echo.
set /p proxychoice=Choose an option [1-2]: 

REM If user chooses default, set PROXY variable to default value
if "%proxychoice%"=="1" (
    set "PROXY=http://127.0.0.1:10808"
) else if "%proxychoice%"=="2" (
    REM Prompt user to enter custom proxy URL
    :enter_custom_proxy
    set /p PROXY=Enter your proxy ^(e.g., http://192.168.1.100:8080^): 
    if "%PROXY%"=="" (
        echo  Proxy cannot be empty. Please enter again.
        goto enter_custom_proxy
    )
) else (
    echo Invalid choice.
    pause
    goto choose_proxy
)

REM ------------------------------
REM Main menu for proxy operations
REM ------------------------------
:menu
cls
echo ================================
echo Git ^& npm Proxy Menu
echo ================================
echo   [1] ➤ Set Git Proxy (HTTP/HTTPS)
echo   [2] ➤ Set Git Proxy (SOCKS5)
echo   [4] ➤ Show Git Proxy
echo   [6] ➤ Unset Git Proxy
echo.
echo npm Configuration:
echo   [3] ➤ Set npm Proxy
echo   [5] ➤ Show npm Proxy
echo   [7] ➤ Unset npm Proxy
echo.
echo [8] ➤ Exit
echo --------------------------------------------------
set /p choice=Choose an option [1-8]: 

if "%choice%"=="1" goto set_git_http
if "%choice%"=="2" goto set_git_socks5
if "%choice%"=="3" goto set_npm
if "%choice%"=="4" goto show_git
if "%choice%"=="5" goto show_npm
if "%choice%"=="6" goto unset_git
if "%choice%"=="7" goto unset_npm
if "%choice%"=="8" goto exit_script

echo Invalid choice. Please try again.
pause
goto menu

REM ------------------------------
REM Set Git HTTP/HTTPS proxy
REM ------------------------------
:set_git_http
git config --global http.proxy "%PROXY%"
git config --global https.proxy "%PROXY%"
echo.
echo ✅ Git HTTP/HTTPS proxy set to: %PROXY%
pause
goto menu

REM ------------------------------
REM Set Git SOCKS5 proxy
REM ------------------------------
:set_git_socks5
set "GIT_SOCKS_PROXY=%PROXY:http://=socks5://%"
git config --global http.proxy "%GIT_SOCKS_PROXY%"
git config --global https.proxy "%GIT_SOCKS_PROXY%"
echo.
echo ✅ Git SOCKS5 proxy set to: %GIT_SOCKS_PROXY%
pause
goto menu

REM ------------------------------
REM Set npm proxy
REM ------------------------------
:set_npm
where npm >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ npm not found. Please ensure Node.js is installed and npm is in your PATH.
    pause
    goto menu
)

echo Setting npm proxy...
call npm config set proxy "%PROXY%"
set npm_error1=%errorlevel%

call npm config set https-proxy "%PROXY%"
set npm_error2=%errorlevel%

if %npm_error1% neq 0 (
    echo ❌ Failed to set npm HTTP proxy
    goto menu
) else if %npm_error2% neq 0 (
    echo ❌ Failed to set npm HTTPS proxy
    goto menu
) else (
    echo ✅ npm proxy set to: %PROXY%
)
echo.
pause
goto menu

REM ------------------------------
REM Show Git proxy settings
REM ------------------------------
:show_git
echo.
echo --- Git Proxy ---
echo HTTP Proxy:
git config --global --get http.proxy
echo HTTPS Proxy:
git config --global --get https.proxy
echo.
pause
goto menu

REM ------------------------------
REM Show npm proxy settings
REM ------------------------------
:show_npm
where npm >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ npm not found. Please ensure Node.js is installed and in your PATH.
    pause
    goto menu
)

echo.
echo --- npm Proxy ---
echo HTTP Proxy:
call npm config get proxy
echo HTTPS Proxy:
call npm config get https-proxy
echo.
pause
goto menu

REM ------------------------------
REM Unset Git proxy settings
REM ------------------------------
:unset_git
git config --global --unset http.proxy 2>nul
git config --global --unset https.proxy 2>nul
echo.
echo ✅ Git proxy removed.
pause
goto menu

REM ------------------------------
REM Unset npm proxy settings
REM ------------------------------
:unset_npm
where npm >nul 2>&1
if errorlevel 1 (
    echo ❌ npm not found. Please ensure Node.js is installed and in your PATH.
    pause
    goto menu
)

echo Removing npm proxy settings...
call npm config delete proxy
set npm_error1=%errorlevel%

call npm config delete https-proxy
set npm_error2=%errorlevel%

if %npm_error1% neq 0 (
    echo ❌ Failed to delete npm HTTP proxy
) else if %npm_error2% neq 0 (
    echo ❌ Failed to delete npm HTTPS proxy
) else (
    echo ✅ npm proxy removed.
)
echo.
pause
goto menu

REM ------------------------------
REM Exit script gracefully
REM ------------------------------
:exit_script
echo.
echo Goodbye!
pause
exit /b 0