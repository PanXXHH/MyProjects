@echo off

if [%1] == []  ( 
	echo �������ļ�
	pause
	exit /B
)

::������

ffmpeg -err_detect ignore_err -i %1 -c copy %~dp1%~n1_output%~x1