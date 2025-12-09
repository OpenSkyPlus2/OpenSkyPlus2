@echo off
setlocal

title SkyTrak 5.8.27 Custom Install Helper

rem Where we expect the installer to live by default
set "INSTALLER=%USERPROFILE%\Downloads\SkyTrakSetup_x64_5.8.27.exe"

echo.
echo SkyTrak 5.8.27 custom installer
echo ================================
echo.

if not exist "%INSTALLER%" (
  echo ERROR: Could not find:
  echo   "%INSTALLER%"
  echo.
  echo Move SkyTrakSetup_x64_5.8.27.exe into your Downloads folder,
  echo or edit this script to point to the correct location.
  echo.
  pause
  exit /b 1
)

rem Default target directory if user just presses Enter
set "DEFAULT_DIR=C:\SkyTrak"

echo Default install folder is: "%DEFAULT_DIR%"
echo.
set /p TARGETDIR=Enter install folder path (or press Enter to use default): 

if "%TARGETDIR%"=="" set "TARGETDIR=%DEFAULT_DIR%"

echo.
echo SkyTrak will be installed to:
echo   "%TARGETDIR%"
echo.
pause

rem Create folder if it doesn't exist (ignore error if it already exists)
if not exist "%TARGETDIR%" mkdir "%TARGETDIR%" >nul 2>&1

echo.
echo Launching SkyTrak installer...
echo Command:
echo   "%INSTALLER%" /DIR="%TARGETDIR%"
echo.

"%INSTALLER%" /DIR="%TARGETDIR%"

echo.
echo Installer has exited. If you saw the SkyTrak setup wizard,
echo follow its on-screen steps to complete installation.
echo.
pause
endlocal
