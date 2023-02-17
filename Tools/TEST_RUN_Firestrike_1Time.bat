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

@title Fire Strike [ 1 Time ]
@color 1f
@echo.
@echo Fire Strike [ 1 Time ]
@echo Fire Strike [ 1 Time ]
@echo Fire Strike [ 1 Time ]

timeout /t 3

 :--------------------------------------------------------------
set result_file_path=%~dp0
set FS_result_file_name=Result_Firestrike

CD %result_file_path%

if exist %FS_result_file_name%.xml del %FS_result_file_name%.xml
if exist %FS_result_file_name%.txt del %FS_result_file_name%.txt



 :--------------------------------------------------------------
cd "%~dp0Tools\3DMark"

set /p 3DM_KEY=<"3dm_key.txt"

3DMarkCmd.exe --register=%3DM_KEY%
timeout /t 1

3DMarkCmd.exe --path=%~dp0Tools\3DMark\DLC
timeout /t 1

@ECHO.
@ECHO.
@ECHO 3Dmark Fire Strike [ 1 Time ]
@ECHO.
3DMarkCmd.exe --definition=firestrike.3dmdef --loop=1 --export=%result_file_path%%FS_result_file_name%.xml --systeminfo=off
timeout /t 1

3DMarkCmd.exe --unregister



 :--------------------------------------------------------------
timeout /t 2
CD /d "%~dp0"
ren *.xml *.txt

@set FS_GPU_SCORE=0
@set FS_PHYSICS_SCORE=0
@set FS_COMBINE_SCORE=0
@set FS_TOTAL_SCORE=0

 :--------------------------------------------------------------
FINDSTR /L /I "<firestrikegraphicsscorep>" %result_file_path%%FS_result_file_name%.txt >> %~dp0temp_1.txt
FINDSTR /L /I "<firestrikephysicsscorep>" %result_file_path%%FS_result_file_name%.txt >> %~dp0temp_2.txt
FINDSTR /L /I "<firestrikecombinedscorep>" %result_file_path%%FS_result_file_name%.txt >> %~dp0temp_3.txt
FINDSTR /L /I "<firestrikeoverallscorep>" %result_file_path%%FS_result_file_name%.txt >> %~dp0temp_4.txt

set /p FS_GPU_SCORE=<%~dp0temp_1.txt
set /p FS_PHYSICS_SCORE=<%~dp0temp_2.txt
set /p FS_COMBINE_SCORE=<%~dp0temp_3.txt
set /p FS_TOTAL_SCORE=<%~dp0temp_4.txt

del %~dp0temp_1.txt
del %~dp0temp_2.txt
del %~dp0temp_3.txt
del %~dp0temp_4.txt

set FS_GPU_SCORE="%FS_GPU_SCORE%"
set FS_PHYSICS_SCORE="%FS_PHYSICS_SCORE%"
set FS_COMBINE_SCORE="%FS_COMBINE_SCORE%"
set FS_TOTAL_SCORE="%FS_TOTAL_SCORE%"

set FS_GPU_SCORE=%FS_GPU_SCORE: =%
set FS_PHYSICS_SCORE=%FS_PHYSICS_SCORE: =%
set FS_COMBINE_SCORE=%FS_COMBINE_SCORE: =%
set FS_TOTAL_SCORE=%FS_TOTAL_SCORE: =%

set FS_GPU_SCORE=%FS_GPU_SCORE:<firestrikegraphicsscorep>=%
set FS_PHYSICS_SCORE=%FS_PHYSICS_SCORE:<firestrikephysicsscorep>=%
set FS_COMBINE_SCORE=%FS_COMBINE_SCORE:<firestrikecombinedscorep>=%
set FS_TOTAL_SCORE=%FS_TOTAL_SCORE:<firestrikeoverallscorep>=%

set FS_GPU_SCORE=%FS_GPU_SCORE:</firestrikegraphicsscorep>=%
set FS_PHYSICS_SCORE=%FS_PHYSICS_SCORE:</firestrikephysicsscorep>=%
set FS_COMBINE_SCORE=%FS_COMBINE_SCORE:</firestrikecombinedscorep>=%
set FS_TOTAL_SCORE=%FS_TOTAL_SCORE:</firestrikeoverallscorep>=%

set FS_GPU_SCORE=%FS_GPU_SCORE:"=%
set FS_PHYSICS_SCORE=%FS_PHYSICS_SCORE:"=%
set FS_COMBINE_SCORE=%FS_COMBINE_SCORE:"=%
set FS_TOTAL_SCORE=%FS_TOTAL_SCORE:"=%



 :--------------------------------------------------------------
@ECHO. > %FS_result_file_name%.txt
@ECHO             ######### Fire Strike Result ######### >> %FS_result_file_name%.txt
@ECHO. >> %FS_result_file_name%.txt
@ECHO GPU : %FS_GPU_SCORE% >> %FS_result_file_name%.txt
@ECHO PHYSICS : %FS_PHYSICS_SCORE% >> %FS_result_file_name%.txt
@ECHO COMBINE : %FS_COMBINE_SCORE% >> %FS_result_file_name%.txt
@ECHO TOTAL : %FS_TOTAL_SCORE% >> %FS_result_file_name%.txt
@ECHO. >> %FS_result_file_name%.txt
@ECHO. >> %FS_result_file_name%.txt

type %FS_result_file_name%.txt

 :--------------------------------------------------------------
if "%1" EQU "1" (
exit
)
 :--------------------------------------------------------------
@ECHO END
@ECHO.
@ECHO.
pause > nul