@echo off
set AWM_CORE_VERSION = 1.3.20220621

::���������������

::Ҫ�������Ƶ����
:videoFileName
set /p videoFileName=����Ҫ�������Ƶ���ƣ�
if [%videoFileName%] == [] (
	echo "������Ϊ�������"
	goto videoFileName
)

::������������ѡ�

::ˮӡ�ļ����Ʊ���
::������
set variableName=WMFileName
::Ĭ�ϱ���ֵ
set defaultVariableValue=logo.png
::��������
set variableDescription=ˮӡ�ļ�����
set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
if [%WMFileName%] == [] (
	set %variableName%=%defaultVariableValue%
)

::ˮӡX��ʼλ�ñ���
::������
set variableName=WMPlaceX
::Ĭ�ϱ���ֵ
set defaultVariableValue=10
::��������
set variableDescription=ˮӡX��ʼλ��
set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
if [%WMPlaceX%] == [] (
	set %variableName%=%defaultVariableValue%
)

::ˮӡY��ʼλ�ñ���
::������
set variableName=WMPlaceY
::Ĭ�ϱ���ֵ
set defaultVariableValue=15
::��������
set variableDescription=ˮӡY��ʼλ��
set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
if [%WMPlaceY%] == [] (
	set %variableName%=%defaultVariableValue%
)

::����Ŀ¼����
::������
set variableName=inputdir
::Ĭ�ϱ���ֵ
set defaultVariableValue=.
::��������
set variableDescription=����Ŀ¼
set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
if [%inputdir%] == [] (
	set %variableName%=%defaultVariableValue%
)

::����Ŀ¼����
::������
set variableName=outputdir
::Ĭ�ϱ���ֵ
set defaultVariableValue=.\output
::��������
set variableDescription=����Ŀ¼
set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
if [%outputdir%] == [] (
	set %variableName%=%defaultVariableValue%
)

:: ����Ԥ������

::ˮӡͼƬ��ȱ���
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=width %WMFileName% >> _temp_width.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_width.txt) do @set WMw=%%i
del _temp_width.txt
::ˮӡͼƬ�߶ȱ���
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height %WMFileName% >> _temp_height.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_height.txt) do @set WMh=%%i
del _temp_height.txt

:: ִ����

mkdir %outputdir%
ffmpeg -i %inputdir%\%videoFileName% -vf "[in]delogo=x=%WMPlaceX%:y=%WMPlaceY%:w=%WMw%:h=%WMh%[a];movie=%WMFileName%,scale=%WMw%:%WMh%[watermark];[a][watermark] overlay=%WMPlaceX%:%WMPlaceY% [out]" %outputdir%\%videoFileName%
