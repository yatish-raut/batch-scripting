@echo off
setlocal enabledelayedexpansion

:: Initialize all cells to empty (just space)
for /L %%i in (1,1,9) do (
    set cell%%i= 
)

set player=X
set turnCount=0

:display
cls
echo *** TIC-TAC-TOE ***
echo.

:: Show board with empty cells (all)
echo !cell1! ^| !cell2! ^| !cell3!
echo --+---+--
echo !cell4! ^| !cell5! ^| !cell6!
echo --+---+--
echo !cell7! ^| !cell8! ^| !cell9!
echo.

:: Check for win or draw
call :checkWin
if !errorlevel! EQU 1 (
    echo Player !winner! wins!
    goto end
)

if !turnCount! GEQ 9 (
    echo It's a draw!
    goto end
)

goto input

:input
set /p choice=Player %player%, choose a cell number (1-9): 
:: Validate input (only numbers 1-9 allowed)
echo 123456789 | findstr /C:"%choice%" >nul
if errorlevel 1 (
    echo Invalid input. Try again.
    pause >nul
    goto display
)

call set current=!cell%choice%!

:: Check if cell is already taken
if not "!current!"==" " (
    echo That cell is already taken! Try another.
    pause >nul
    goto display
)

:: Place player's mark
call set cell%choice%=%player%
set /a turnCount+=1

:: Switch player
if "%player%"=="X" (
    set player=O
) else (
    set player=X
)

goto display

:checkWin
set winner=
set result=0

:: Check win lines
call :checkLine cell1 cell2 cell3
call :checkLine cell4 cell5 cell6
call :checkLine cell7 cell8 cell9
call :checkLine cell1 cell4 cell7
call :checkLine cell2 cell5 cell8
call :checkLine cell3 cell6 cell9
call :checkLine cell1 cell5 cell9
call :checkLine cell3 cell5 cell7

if defined winner (
    exit /b 1
) else (
    exit /b 0
)

:checkLine
call set a=!%1!
call set b=!%2!
call set c=!%3!

if not "!a!"==" " if "!a!"=="!b!" if "!b!"=="!c!" (
    set winner=!a!
)
exit /b

:end
echo.
pause
exit /b
