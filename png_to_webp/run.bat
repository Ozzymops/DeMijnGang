:: Rename, convert, do both, install or update, exit
@ECHO OFF
CLS
goto InstallCheck

:InstallCheck
if exist install_check (
	goto Menu
) else (
	goto FirstTimeMenu
)

:FirstTimeMenu
CLS
echo Keuzemenu:
echo - 1. Installeer programma
echo - 2. Sluit programma af
echo.
choice /c 12 /n /m "> "

if errorlevel 2 goto End
if errorlevel 1 goto Install

:Menu
CLS
echo Keuzemenu:
echo - 1. Hernoem foto's naar nummersequentie (0000, 0001, ...)
echo - 2. Converteer foto's naar .webp formaat
echo - 3. Voer 1. en 2. achter elkaar uit
echo - 4. Update programma
echo - 5. Sluit programma af
echo.
choice /c 12345 /n /m "> "

if errorlevel 5 goto End
if errorlevel 4 goto End
if errorlevel 3 goto End
if errorlevel 2 goto End
if errorlevel 1 goto End

:Install
echo Creating Python virtual environment...
PYTHON -m venv .venv
CD .venv/Scripts
echo Activating Python virtual environment...
CALL activate.bat
echo Installing requirements...
CALL python.exe -m pip install --upgrade pip
CALL python.exe -m pip install Pillow
echo.
echo Finished! Enjoy.
PAUSE
GOTO InstallCheck

:ExtrasSelect
CLS
echo Select Extras classification model:
echo - 1. Default (6 emotions)
echo - 2. Extended (28 emotions)
echo.
choice /c 12 /n /m "> "

if errorlevel 2 goto LaunchExtrasLarge
if errorlevel 1 goto LaunchExtrasSmall

:LaunchMain
cd SillyTavern-main
start /min start.bat
goto ExtrasSelect

:LaunchStaging
cd SillyTavern-staging
start /min start.bat
goto ExtrasSelect

:LaunchExtrasSmall
cd ../SillyTavern-extras
call conda.bat activate "D:\Artificial Intelligence\SillyTavern\conda"
start /min python server.py --enable-modules=classify
call conda.bat deactivate
goto End

:LaunchExtrasLarge
cd ../SillyTavern-extras
call conda.bat activate "D:\Artificial Intelligence\SillyTavern\conda"
start /min python server.py --enable-modules=classify --classification-model "joeddav/distilbert-base-uncased-go-emotions-student"
call conda.bat deactivate
goto End

:UpdateBranches
call conda.bat activate "D:\Artificial Intelligence\SillyTavern\conda"
echo.
echo ~Updating Main branch~
cd SillyTavern-main
git pull
echo ~Finished~
echo.
echo ~Updating Staging branch~
cd ../SillyTavern-staging
git pull
echo ~Finished~
echo.
echo ~Updating Extras~
cd ../SillyTavern-extras
git pull
echo.
call conda.bat deactivate
echo ~Finished~
echo.
cd ..
goto BranchSelect

:End