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

@echo กเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเ
@echo กเกเกเกแกแกแกแกเกเกแกแกแกแกแกเกเกเกแกแกแกเกเกเกแกแกแกแกเกเกเกแกแกแกแกแกเกเ
@echo กเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกแกเกเกแกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกแกเกเกแกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกแกแกแกเกเกเกเกเกแกเกเกเกเกแกเกเกเกแกเกเกแกแกแกแกเกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกเกแกแกแกแกแกเกเกแกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกแกเกเกแกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกแกแกแกแกเกเกเกเกเกแกเกเกเกเกแกเกเกเกแกเกเกแกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเ

set MAIN_TEST=1
cd %~dp0Tools

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
start /wait TEST_RUN_Firestrike_1Time.bat %MAIN_TEST%

type Result_Firestrike.txt

timeout /t 10

@echo.
@echo AIDA / FurMark AGING
@echo.

timeout /t 2

start "" "App\FurMark\FurMark.exe"

timeout /t 5 /NOBREAK

start "" "App\aida64engineer\aida64.exe" /SST CPU,FPU,Cache,RAM

timeout /t 5 /NOBREAK

start "" "App\SnapTimer\SnapTimer.exe"

timeout /t 2080 /NOBREAK

cd "App\capture"
Powershell.exe Set-ExecutionPolicy Unrestricted
timeout /t 1 /NOBREAK
Powershell.exe -noprofile -executionpolicy bypass -file "expert_screen_resolution.ps1"
timeout /t 1 /NOBREAK
Powershell.exe -noprofile -executionpolicy bypass -file "capture.ps1"
timeout /t 1 /NOBREAK
Powershell.exe Set-ExecutionPolicy Restricted
pushd %~dp0

timeout /t 2 /NOBREAK

taskkill /f /im FurMark.exe
if errorlevel 1 do ( taskkill /f /im FurMark.exe )

taskkill /f /im aida64.exe
if errorlevel 1 do ( taskkill /f /im aida64.exe )

taskkill /f /im aida_bench64.dll
if errorlevel 1 do ( taskkill /f /im aida_bench64.dll )
cls
color 2F
@echo.
@echo.
@echo กเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเ
@echo กเกเกเกเกแกแกแกแกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเกเกแกแกแกเกเกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกแกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกแกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกแกแกแกแกแกเกเกเกเกแกเกเกเกเกแกเกแกเกเกแกเกเกเกเกแกเกเกเกเกเกแกแกแกเกเกเกเกเกแกแกแกแกแกแกเกเกเกเ
@echo กเกเกเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกเกเกแกเกแกเกเกเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกแกแกเกเกเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกแกแกเกเกเกเกแกเกเกเกเกแกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกแกเกเกเกเกเกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเกแกเกเกเกเกเกแกแกแกเกเกเกเกเกแกเกเกเกเกแกเกเกเกเ
@echo กเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเกเ
@echo.
@echo.
timeout /t 3 /NOBREAK
shutdown -s -f -t 0n -s -f -t 0