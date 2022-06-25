@echo off

if [%1] == []  ( 
	echo 请拖入文件
	pause
	exit /B
)

::主程序

ffmpeg -i %1 -ss 00:00:08.0 -c copy -t 90:00:10.0 %~dp1%~n1_output%~x1
