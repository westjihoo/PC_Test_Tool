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

@title Fire Strike [ Loop ]
@color c0
@echo.
@echo Fire Strike [ Loop ]
@echo Fire Strike [ Loop ]
@echo Fire Strike [ Loop ]

timeout /t 3

 :--------------------------------------------------------------
cd "%~dp0Tools\3DMark"

set /p 3DM_KEY=<"3dm_key.txt"

3DMarkCmd.exe --register=%3DM_KEY%
timeout /t 1

3DMarkCmd.exe --path=%~dp0Tools\3DMark\DLC
timeout /t 1

@ECHO.
@ECHO.
@echo 3Dmark Fire Strike [ Loop ]
ECHO.
3DMarkCmd.exe --definition=firestrike.3dmdef --loop=0 --systeminfo=off
timeout /t 1

3DMarkCmd.exe --unregister

@echo.
@echo.
@echo END
@echo.
@echo.
pause