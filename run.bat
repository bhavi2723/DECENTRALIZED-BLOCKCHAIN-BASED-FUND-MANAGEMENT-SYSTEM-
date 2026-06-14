@echo off
title MediCare-Chain - Step 1: Ganache + Deploy
color 0A

set PROJECT_DIR=C:\Users\sasik\Desktop\MediCare-Chain\MediCare-Chain
set CONTRACT_DIR=%PROJECT_DIR%\contract

echo ============================================
echo   STEP 1: Start Ganache + Deploy Contract
echo ============================================
echo.

:: Kill anything on port 8545
echo Clearing port 8545...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8545" 2^>nul') do (
    taskkill /F /PID %%a >nul 2>&1
)
timeout /t 2 /nobreak >nul

:: Start Ganache in new window
echo Starting Ganache...
start "Ganache" cmd /k "npx ganache --port 8545 --deterministic"

echo Waiting 10 seconds for Ganache...
timeout /t 10 /nobreak >nul

:: Deploy contract
echo Deploying contract...
cd /d "%CONTRACT_DIR%"
npx truffle migrate --reset --network development > "%TEMP%\truffle_output.txt" 2>&1

:: Show deploy result
echo.
echo --- Deploy Output ---
type "%TEMP%\truffle_output.txt" | findstr "contract address:"
echo --------------------
echo.

:: Extract address
set CONTRACT_ADDRESS=
for /f "tokens=3" %%a in ('findstr "contract address:" "%TEMP%\truffle_output.txt"') do set CONTRACT_ADDRESS=%%a

if "%CONTRACT_ADDRESS%"=="" (
    echo ERROR: Deployment failed! Full output:
    type "%TEMP%\truffle_output.txt"
    pause
    exit /b 1
)

echo Contract deployed at: %CONTRACT_ADDRESS%
echo.

:: Update views.py
echo Updating views.py...
powershell -Command "(Get-Content '%PROJECT_DIR%\main_app\views.py') -replace '\"0x[a-fA-F0-9]{40}\"', '\"%CONTRACT_ADDRESS%\"' | Set-Content '%PROJECT_DIR%\main_app\views.py'"

:: Update HTML templates
echo Updating HTML templates...
set TEMPLATES_DIR=%PROJECT_DIR%\main_app\templates\main_app
for %%f in (addPatients.html addDoctor.html donation.html sign.html) do (
    powershell -Command "(Get-Content '%TEMPLATES_DIR%\%%f') -replace '\"0x[a-fA-F0-9]{40}\"', '\"%CONTRACT_ADDRESS%\"' | Set-Content '%TEMPLATES_DIR%\%%f'"
    echo   Updated: %%f
)

echo.
echo ============================================
echo   DONE! Contract: %CONTRACT_ADDRESS%
echo   Now double-click start_django.bat
echo ============================================
echo.
pause