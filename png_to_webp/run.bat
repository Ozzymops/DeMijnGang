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
echo - 1. Converteer foto's naar .webp formaat
echo - 2. Hernoem foto's naar nummersequentie (0000, 0001, ...)
echo - 3. Voer 1. en 2. achter elkaar uit
echo - 4. Update programma
echo - 5. Sluit programma af
echo.
choice /c 12345 /n /m "> "

if errorlevel 5 goto End
if errorlevel 4 goto Update
if errorlevel 3 goto ConvertAndRename
if errorlevel 2 goto Rename
if errorlevel 1 goto Convert

:Install
ECHO Creating folders...
IF NOT EXIST "input" MKDIR "input"
IF NOT EXIST "output" MKDIR "output"
IF NOT EXIST "scripts" MKDIR "scripts"

echo Creating Python virtual environment...
PYTHON -m venv .venv

ECHO Activating Python virtual environment...
CD .venv/Scripts
CALL activate.bat

ECHO Installing requirements...
CALL python.exe -m pip install --upgrade pip
CALL python.exe -m pip install Pillow

ECHO Downloading scripts...
CD %~dp0/scripts
CURL https://raw.githubusercontent.com/Ozzymops/DeMijngang/main/png_to_webp/scripts/png_to_webp.py > png_to_webp.py

COPY NUL install_check
GOTO InstallCheck

:Update
CLS
cd scripts
ECHO Downloading scripts...
CURL https://raw.githubusercontent.com/Ozzymops/DeMijngang/main/png_to_webp/scripts/png_to_webp.py > png_to_webp.py
GOTO InstallCheck

:Convert
CLS
CD .venv/Scripts
CALL python.exe %~dp0/scripts/png_to_webp.py
PAUSE
GOTO InstallCheck

:Rename
CLS
CD .venv/Scripts
CALL python.exe %~dp0/scripts/rename_to_number_sequence.py
PAUSE
GOTO InstallCheck

:ConvertAndRename
CLS
CD .venv/Scripts
CALL python.exe %~dp0/scripts/png_to_webp.py
echo.
echo ---
echo.
CALL python.exe %~dp0/scripts/rename_to_number_sequence.py
PAUSE
GOTO InstallCheck

:End