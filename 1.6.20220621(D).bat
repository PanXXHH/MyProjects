@echo off
::CONST
set AWM_CORE_VERSION=1.6.20220621
::GLOBAL
set skipDefaultVariable=False
::PRELOAD
setlocal EnableDelayedExpansion

::变量输入区（必填）

::要处理的视频名称
::变量名
set variableName=videoFileName
::变量描述
set variableDescription=要处理的视频名称
:videoFileName
set /p %variableName%=输入%variableDescription%（必填）：
if not defined %variableName% (
	echo "本参数为必填参数"
	goto %variableName%
)

::变量输入区（选填）

::水印文件名称变量
::变量名
set variableName=WMFileName
::默认变量值
set defaultVariableValue=logo.png
::变量描述
set variableDescription=水印文件名称
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
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

::水印图片宽度
::变量名
set variableName=WMw
::默认变量值
set defaultVariableValue=default
::变量描述
set variableDescription=水印图片宽度【default为图片宽度】
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
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

::水印图片高度
::变量名
set variableName=WMh
::默认变量值
set defaultVariableValue=default
::变量描述
set variableDescription=水印图片高度【default为图片高度】
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
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

::水印X起始位置变量
::变量名
set variableName=WMPlaceX
::默认变量值
set defaultVariableValue=10
::变量描述
set variableDescription=水印X起始位置
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
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

::水印Y起始位置变量
::变量名
set variableName=WMPlaceY
::默认变量值
set defaultVariableValue=15
::变量描述
set variableDescription=水印Y起始位置
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
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

::导入目录变量
::变量名
set variableName=inputdir
::默认变量值
set defaultVariableValue=.
::变量描述
set variableDescription=导入目录
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
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

::导出目录变量
::变量名
set variableName=outputdir
::默认变量值
set defaultVariableValue=.\output
::变量描述
set variableDescription=导出目录
if [%skipDefaultVariable%] == [True] (
	set %variableName%=%defaultVariableValue%
)else (
	set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
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

:: 变量预处理区

if not [%WMw%] == [default] goto skip_get_WMw
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=width %WMFileName% >> _temp_width.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_width.txt) do @set WMw=%%i
del _temp_width.txt
:skip_get_WMw
::水印图片高度变量
if not [%WMh%] == [default] goto skip_get_WMh
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height %WMFileName% >> _temp_height.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_height.txt) do @set WMh=%%i
del _temp_height.txt
:skip_get_WMh

:: 执行区

mkdir %outputdir%
ffmpeg -i %inputdir%\%videoFileName% -vf "[in]delogo=x=%WMPlaceX%:y=%WMPlaceY%:w=%WMw%:h=%WMh%[a];movie=%WMFileName%,scale=%WMw%:%WMh%[watermark];[a][watermark] overlay=%WMPlaceX%:%WMPlaceY% [out]" %outputdir%\%videoFileName%