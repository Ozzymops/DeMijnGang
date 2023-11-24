:: Rename, convert, do both, install or update, exit
@ECHO OFF
CLS
goto InstallCheck

:InstallCheck
if exist %~dp0/scripts/install_check (
	goto Menu
) else (
	goto FirstTimeMenu
)

:FirstTimeMenu
CLS
CD %~dp0
echo Keuzemenu:
echo - 1. Installeer programma
echo - 2. Sluit programma af
echo.
choice /c 12 /n /m "> "

if errorlevel 2 goto End
if errorlevel 1 goto Install

:Menu
CLS
CD %~dp0
echo Keuzemenu:
echo - 1. Download foto's van gegeven Facebook groep
echo - 2. Update programma
echo - 3. Sluit programma af
echo.
choice /c 123 /n /m "> "

if errorlevel 3 goto End
if errorlevel 2 goto Update
if errorlevel 1 goto Download

:Install
ECHO Creating folders...
IF NOT EXIST "output" MKDIR "output"
IF NOT EXIST "scripts" MKDIR "scripts"

echo Creating Python virtual environment...
PYTHON -m venv .venv

ECHO Activating Python virtual environment...
CD .venv/Scripts
CALL activate.bat

ECHO Installing requirements...
CALL python.exe -m pip install --upgrade pip
CALL python.exe -m pip install facebook-sdk

ECHO Downloading scripts...
CD %~dp0/scripts
::CURL https://raw.githubusercontent.com/Ozzymops/DeMijngang/main/png_to_webp/scripts/png_to_webp.py > png_to_webp.py

COPY NUL install_check
GOTO InstallCheck

:Update
CLS
cd scripts
ECHO Downloading scripts...
::CURL https://raw.githubusercontent.com/Ozzymops/DeMijngang/main/png_to_webp/scripts/png_to_webp.py > png_to_webp.py
GOTO InstallCheck

:Download
CLS
CD .venv/Scripts
CALL python.exe %~dp0/scripts/fb_downloader.py
PAUSE
GOTO InstallCheck

:End