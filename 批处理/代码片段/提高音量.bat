@echo off

if [%1] == [] ( 
	echo 请拖入文件
	pause
	exit /B
)

::主程序

set /p volvalue=提高音量值(默认：20)：

if not defined volvalue (
	set volvalue=20
)

ffmpeg -i %1 -vcodec copy -af "volume=%volvalue%dB" %~dp1%~n1_output%~x1