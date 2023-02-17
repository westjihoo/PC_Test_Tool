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

@title Time Spy [ 1 Time ]
@color 1f
@echo.
@ECHO Time Spy [ 1 Time ]
@ECHO Time Spy [ 1 Time ]
@ECHO Time Spy [ 1 Time ]

timeout /t 3

 :--------------------------------------------------------------
set result_file_path=%~dp0
set TS_result_file_name=Result_Timespy

CD %result_file_path%

if exist %TS_result_file_name%.xml del %TS_result_file_name%.xml
if exist %TS_result_file_name%.txt del %TS_result_file_name%.txt


 :--------------------------------------------------------------
cd "%~dp0Tools\3DMark"

set /p 3DM_KEY=<"3dm_key.txt"

3DMarkCmd.exe --register=%3DM_KEY%
timeout /t 1

3DMarkCmd.exe --path=%~dp0Tools\3DMark\DLC
timeout /t 1

@ECHO.
@ECHO.
@ECHO 3Dmark Time Spy [ 1 Time ]
@ECHO.
3DMarkCmd.exe --definition=timespy.3dmdef --loop=1 --export=%result_file_path%%TS_result_file_name%.xml --systeminfo=off
timeout /t 1

3DMarkCmd.exe --unregister



 :--------------------------------------------------------------
timeout /t 2
CD /d "%~dp0"
ren *.xml *.txt

@set TS_GPU_SCORE=0
@set TS_CPU_SCORE=0
@set TS_TOTAL_SCORE=0

 :--------------------------------------------------------------

FINDSTR /L /I "<TimeSpyPerformanceGraphicsScore>" %result_file_path%%TS_result_file_name%.txt >> %~dp0temp_1.txt
FINDSTR /L /I "<TimeSpyPerformanceCPUScore>" %result_file_path%%TS_result_file_name%.txt >> %~dp0temp_2.txt
FINDSTR /L /I "<TimeSpyPerformance3DMarkScore>" %result_file_path%%TS_result_file_name%.txt >> %~dp0temp_3.txt

set /p TS_GPU_SCORE=<%~dp0temp_1.txt
set /p TS_CPU_SCORE=<%~dp0temp_2.txt
set /p TS_TOTAL_SCORE=<%~dp0temp_3.txt

del %~dp0temp_1.txt
del %~dp0temp_2.txt
del %~dp0temp_3.txt

set TS_GPU_SCORE="%TS_GPU_SCORE%"
set TS_CPU_SCORE="%TS_CPU_SCORE%"
set TS_TOTAL_SCORE="%TS_TOTAL_SCORE%"

set TS_GPU_SCORE=%TS_GPU_SCORE: =%
set TS_CPU_SCORE=%TS_CPU_SCORE: =%
set TS_TOTAL_SCORE=%TS_TOTAL_SCORE: =%

set TS_GPU_SCORE=%TS_GPU_SCORE:<TimeSpyPerformanceGraphicsScore>=%
set TS_CPU_SCORE=%TS_CPU_SCORE:<TimeSpyPerformanceCPUScore>=%
set TS_TOTAL_SCORE=%TS_TOTAL_SCORE:<TimeSpyPerformance3DMarkScore>=%

set TS_GPU_SCORE=%TS_GPU_SCORE:</TimeSpyPerformanceGraphicsScore>=%
set TS_CPU_SCORE=%TS_CPU_SCORE:</TimeSpyPerformanceCPUScore>=%
set TS_TOTAL_SCORE=%TS_TOTAL_SCORE:</TimeSpyPerformance3DMarkScore>=%

set TS_GPU_SCORE=%TS_GPU_SCORE:"=%
set TS_CPU_SCORE=%TS_CPU_SCORE:"=%
set TS_TOTAL_SCORE=%TS_TOTAL_SCORE:"=%



 :--------------------------------------------------------------
@ECHO. > %TS_result_file_name%.txt
@ECHO             ######### Time Spy Result ######### >> %TS_result_file_name%.txt
@ECHO. >> %TS_result_file_name%.txt
@ECHO GPU : %TS_GPU_SCORE% >> %TS_result_file_name%.txt
@ECHO CPU : %TS_CPU_SCORE% >> %TS_result_file_name%.txt
@ECHO TOTAL : %TS_TOTAL_SCORE% >> %TS_result_file_name%.txt
@ECHO. >> %TS_result_file_name%.txt
@ECHO. >> %TS_result_file_name%.txt

type %TS_result_file_name%.txt

 :--------------------------------------------------------------
if "%1" EQU "1" (
exit
)
 :--------------------------------------------------------------
@ECHO END
@ECHO.
@ECHO.
pause > nul