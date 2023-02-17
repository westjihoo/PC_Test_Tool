@echo off

set uaccheck=0

:CheckUAC
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' ( goto UACAccess ) else ( goto DEPLOY )

:UACAccess
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\uac_get_admin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\uac_get_admin.vbs"
"%temp%\uac_get_admin.vbs"
del "%temp%\uac_get_admin.vbs"
exit /b


:DEPLOY
chcp 949
color 9F
pushd %~dp0

taskkill /f /im FurMark.exe
taskkill /f /im aida64.exe
taskkill /f /im aida_bench64.dll

cls
@echo ¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à
@echo ¡à¡à¡à¡á¡á¡á¡á¡à¡à¡á¡á¡á¡á¡á¡à¡à¡à¡á¡á¡á¡à¡à¡à¡á¡á¡á¡á¡à¡à¡à¡á¡á¡á¡á¡á¡à¡à
@echo ¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡á¡à¡à¡á¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡á¡à¡à¡á¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡á¡á¡á¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡á¡à¡à¡á¡á¡á¡á¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡á¡á¡á¡á¡à¡à¡á¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡á¡à¡à¡á¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡á¡á¡á¡á¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡á¡à¡à¡á¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à

set MAIN_TEST=1

@echo.
@echo 3Dmark Time Spy [ 1 Time ]
@echo.
timeout /t 5
start /wait TEST_RUN_Timespy_1Time.bat %MAIN_TEST%

type Result_Timespy.txt


@echo.
@echo 3Dmark Fire Strike [ 1 Time ]
@echo.
timeout /t 5
start /wait TEST_RUN_Firestrike_1Time.bat 

type Result_Firestrike.txt

timeout /t 10

@echo.
@echo AIDA / FurMark AGING
@echo.

timeout /t 2

start "" "App\FurMark\FurMark.exe"

timeout /t 20 /NOBREAK

start "" "App\aida64engineer\aida64.exe" /SST CPU,FPU,Cache,RAM

timeout /t 10 /NOBREAK

start "" "App\SnapTimer\SnapTimer.exe"

timeout /t 2400 /NOBREAK

@echo ¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡á¡á¡á¡á¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡á¡á¡á¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡á¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡á¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡á¡á¡á¡á¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡á¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡á¡á¡á¡à¡à¡à¡à¡à¡á¡á¡á¡á¡á¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡á¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡á¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡á¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à¡à¡á¡á¡á¡à¡à¡à¡à¡à¡á¡à¡à¡à¡à¡á¡à¡à¡à¡à
@echo ¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à¡à
pause
exit