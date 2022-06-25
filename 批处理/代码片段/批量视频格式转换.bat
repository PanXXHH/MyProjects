@echo off

if [%1] == []  ( 
	echo 请拖入文件
	pause
	exit /B
)

::主程序

set /p outputType=导出格式(默认：mp4)：

if not defined outputType (
	set outputType=mp4
)

ffmpeg -i %1 %~dp1%~n1_output.%outputType%