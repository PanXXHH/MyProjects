@echo off
::CONST
set AWM_CORE_VERSION=1.5.20220621
::GLOBAL
set skipDefaultVariable=False
::PRELOAD
setlocal EnableDelayedExpansion

::���������������

::Ҫ�������Ƶ����
::������
set variableName=videoFileName
::��������
set variableDescription=Ҫ�������Ƶ����
:videoFileName
set /p %variableName%=����%variableDescription%�������
if not defined %variableName% (
	echo "������Ϊ�������"
	goto %variableName%
)

::������������ѡ�

::ˮӡ�ļ����Ʊ���
::������
set variableName=WMFileName
::Ĭ�ϱ���ֵ
set defaultVariableValue=logo.png
::��������
set variableDescription=ˮӡ�ļ�����
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
	if not defined %variableName% (
		set %variableName%=%defaultVariableValue%
	)else (
		call set "variableValue=%%%variableName%%%"
		if [!variableValue!] == [-d] (
			set %variableName%=%defaultVariableValue%
			set skipDefaultVariable=True
		)
	)
)

::ˮӡX��ʼλ�ñ���
::������
set variableName=WMPlaceX
::Ĭ�ϱ���ֵ
set defaultVariableValue=10
::��������
set variableDescription=ˮӡX��ʼλ��
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
	if not defined %variableName% (
		set %variableName%=%defaultVariableValue%
	)else (
		call set "variableValue=%%%variableName%%%"
		if [!variableValue!] == [-d] (
			set %variableName%=%defaultVariableValue%
			set skipDefaultVariable=True
		)
	)
)

::ˮӡY��ʼλ�ñ���
::������
set variableName=WMPlaceY
::Ĭ�ϱ���ֵ
set defaultVariableValue=15
::��������
set variableDescription=ˮӡY��ʼλ��
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
	if not defined %variableName% (
		set %variableName%=%defaultVariableValue%
	)else (
		call set "variableValue=%%%variableName%%%"
		if [!variableValue!] == [-d] (
			set %variableName%=%defaultVariableValue%
			set skipDefaultVariable=True
		)
	)
)

::����Ŀ¼����
::������
set variableName=inputdir
::Ĭ�ϱ���ֵ
set defaultVariableValue=.
::��������
set variableDescription=����Ŀ¼
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
	if not defined %variableName% (
		set %variableName%=%defaultVariableValue%
	)else (
		call set "variableValue=%%%variableName%%%"
		if [!variableValue!] == [-d] (
			set %variableName%=%defaultVariableValue%
			set skipDefaultVariable=True
		)
	)
)

::����Ŀ¼����
::������
set variableName=outputdir
::Ĭ�ϱ���ֵ
set defaultVariableValue=.\output
::��������
set variableDescription=����Ŀ¼
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=����%variableDescription%��Ĭ�ϣ�%defaultVariableValue%����
	if not defined %variableName% (
		set %variableName%=%defaultVariableValue%
	)else (
		call set "variableValue=%%%variableName%%%"
		if [!variableValue!] == [-d] (
			set %variableName%=%defaultVariableValue%
			set skipDefaultVariable=True
		)
	)
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