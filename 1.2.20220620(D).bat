@echo off
set AWM_CORE_VERSION = 1.2.20220620
::���������������

::Ҫ�������Ƶ����
:videoFileName
set /p videoFileName=����Ҫ�������Ƶ���ƣ�
if [%videoFileName%] == [] (
	echo "������Ϊ�������"
	goto videoFileName
)

::������������ѡ�

::ˮӡ�ļ�����
set /p WMFileName=����ˮӡ�ļ����ƣ�Ĭ�ϣ�logo.png����
if [%WMFileName%] == [] (
	set WMFileName=logo.png
)
::ˮӡX��ʼλ��
set /p WMPlaceX=����ˮӡX��ʼλ�ã�Ĭ�ϣ�10����
if [%WMPlaceX%] == [] (
	set WMPlaceX=10
)
::ˮӡY��ʼλ��
set /p WMPlaceY=����ˮӡY��ʼλ�ã�Ĭ�ϣ�15����
if [%WMPlaceY%] == [] (
	set WMPlaceY=15
)
::����Ŀ¼
set /p inputdir=���뵼��Ŀ¼��Ĭ�ϣ�.����
if [%inputdir%] == [] (
	set inputdir=.
)
::����Ŀ¼
set /p outputdir=���뵼��Ŀ¼��Ĭ�ϣ�.\output����
if [%outputdir%] == [] (
	set outputdir=.\output
)

:: ����Ԥ������

::ˮӡͼƬ���
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=width %WMFileName% >> _temp_width.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_width.txt) do @set WMw=%%i
del _temp_width.txt
::ˮӡͼƬ�߶�
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height %WMFileName% >> _temp_height.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_height.txt) do @set WMh=%%i
del _temp_height.txt

mkdir %outputdir%
ffmpeg -i %inputdir%\%videoFileName% -vf "[in]delogo=x=%WMPlaceX%:y=%WMPlaceY%:w=%WMw%:h=%WMh%[a];movie=%WMFileName%,scale=%WMw%:%WMh%[watermark];[a][watermark] overlay=%WMPlaceX%:%WMPlaceY% [out]" %outputdir%\%videoFileName%