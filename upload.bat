@echo off
REM === Upload.bat: Initialize, commit, and push to GitHub ===

REM Change to your project directory
cd /d "C:\Users\USER\Downloads\html-cdn-server-list"



REM Initialize repo if not already
if not exist .git (
    git init
    git branch -M main
    git remote add origin https://github.com/sohag1192/html-cdn-server-list.git
)

REM Stage all changes
git add .

REM Commit with timestamp
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (
    set DATE=%%a-%%b-%%c
)
for /f "tokens=1 delims= " %%a in ('time /t') do (
    set TIME=%%a
)
git commit -m "Auto update on %DATE% %TIME%"

REM Push to main branch
git push -u origin main

echo ✅ Upload complete!
pause