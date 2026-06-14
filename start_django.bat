@echo off
title MediCare-Chain - Step 2: Django Server
color 0B

set PROJECT_DIR=C:\Users\sasik\Desktop\MediCare-Chain\MediCare-Chain

echo ============================================
echo   STEP 2: Start Django + Open Browser
echo ============================================
echo.

:: Start Django in new window
echo Starting Django server...
start "Django Server" cmd /k "cd /d %PROJECT_DIR% && python manage.py runserver"

echo Waiting for Django to start...
timeout /t 5 /nobreak >nul

:: Open browser
echo Opening browser...
start "" "http://127.0.0.1:8000/"

echo.
echo ============================================
echo   Django running at http://127.0.0.1:8000/
echo   You can close this window.
echo ============================================
echo.
pause