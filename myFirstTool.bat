@echo off
:menu
cls
echo =============
echo  My 1st Tool
echo =============
echo.
echo 1. View items 
echo 2. Make a folder
echo 3. Print/Write
echo 4. Exit
echo.
set /p c=Enter (1-4) : 

if "%c%"=="1" goto view
if "%c%"=="2" goto make
if "%c%"=="3" goto print
if "%c%"=="4" exit

goto menu

:view
cls
echo List is Below
echo.
dir
pause
goto menu

:make
cls
set /p n=Enter folder name :
mkdir "%n%"
echo "%n%" folder created !
pause
goto menu

:print
set /p w=Write : 
cls
echo %w%
echo.
pause
goto menu