@echo off

if [%1] == [] ( 
	echo �������ļ�
	pause
	exit /B
)

::������

set /p volvalue=�������ֵ(Ĭ�ϣ�20)��

if not defined volvalue (
	set volvalue=20
)

ffmpeg -i %1 -vcodec copy -af "volume=%volvalue%dB" %~dp1%~n1_output%~x1