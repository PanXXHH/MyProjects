@echo off

if [%1] == []  ( 
	echo �������ļ�
	pause
	exit /B
)

::������

set /p outputType=������ʽ(Ĭ�ϣ�mp4)��

if not defined outputType (
	set outputType=mp4
)

ffmpeg -i %1 %~dp1%~n1_output.%outputType%