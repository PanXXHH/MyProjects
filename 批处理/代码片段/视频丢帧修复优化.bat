@echo off

if [%1] == []  ( 
	echo 请拖入文件
	pause
	exit /B
)

::主程序

ffmpeg -err_detect ignore_err -i %1 -c copy %~dp1%~n1_output%~x1