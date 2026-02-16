@echo off
REM ====== Flussonic GitHub Auto Upload Script ======
REM Author: Md. Sohag Rana
REM GitHub: https://github.com/sohag1192
REM Repo: sohag1192
REM Local Directory: C:\Users\USER\Downloads\html-cdn-server-list

:: === CONFIGURATION ===
set "LOCAL_DIR=C:\Users\USER\Downloads\html-cdn-server-list"
set "REPO_URL=https://github.com/sohag1192/html-cdn-server-list.git"
set "USER_NAME=sohag1192"
set "USER_EMAIL=sohag1192@gmail.com"

:: === NAVIGATE TO LOCAL DIRECTORY ===
cd /d "%LOCAL_DIR%"
if errorlevel 1 (
    echo ❌ Failed to access directory: %LOCAL_DIR%
    pause
    exit /b
)

:: === SET GIT CONFIG (First-time only) ===
git config user.name "%USER_NAME%"
git config user.email "%USER_EMAIL%"

:: === INITIALIZE REPO IF NEEDED ===
if not exist ".git" (
    git init
)

:: === DETECT DEFAULT BRANCH ===
for /f "tokens=*" %%i in ('git symbolic-ref --short HEAD 2^>nul') do set "BRANCH_NAME=%%i"

if "%BRANCH_NAME%"=="" (
    REM If no branch detected, default to main
    set "BRANCH_NAME=main"
    git branch -M %BRANCH_NAME%
)

echo 📌 Using branch: %BRANCH_NAME%

:: === ADD ALL CHANGES ===
git add .

:: === COMMIT WITH TIMESTAMP ===
git commit -m "Auto commit - %date% %time%" >nul 2>&1
if errorlevel 1 (
    echo ⚠️ Nothing to commit. Working directory clean.
) else (
    echo ✅ Changes committed.
)

:: === ADD REMOTE IF MISSING ===
git remote | find "origin" >nul
if errorlevel 1 (
    git remote add origin "%REPO_URL%"
)

:: === PULL BEFORE PUSH TO AVOID CONFLICTS ===
git pull origin %BRANCH_NAME% --rebase >nul 2>&1

:: === PUSH TO GITHUB ===
git push -u origin %BRANCH_NAME%
if errorlevel 1 (
    echo ❌ Push failed. Check credentials or network.
    pause
    exit /b
)

:: === DONE ===
echo.
echo ===============================
echo  ✅ Upload to GitHub completed
echo ===============================
pause