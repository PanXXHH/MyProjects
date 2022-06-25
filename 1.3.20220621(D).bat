@echo off
set AWM_CORE_VERSION = 1.3.20220621

::变量输入区（必填）

::要处理的视频名称
:videoFileName
set /p videoFileName=输入要处理的视频名称：
if [%videoFileName%] == [] (
	echo "本参数为必填参数"
	goto videoFileName
)

::变量输入区（选填）

::水印文件名称变量
::变量名
set variableName=WMFileName
::默认变量值
set defaultVariableValue=logo.png
::变量描述
set variableDescription=水印文件名称
set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
if [%WMFileName%] == [] (
	set %variableName%=%defaultVariableValue%
)

::水印X起始位置变量
::变量名
set variableName=WMPlaceX
::默认变量值
set defaultVariableValue=10
::变量描述
set variableDescription=水印X起始位置
set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
if [%WMPlaceX%] == [] (
	set %variableName%=%defaultVariableValue%
)

::水印Y起始位置变量
::变量名
set variableName=WMPlaceY
::默认变量值
set defaultVariableValue=15
::变量描述
set variableDescription=水印Y起始位置
set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
if [%WMPlaceY%] == [] (
	set %variableName%=%defaultVariableValue%
)

::导入目录变量
::变量名
set variableName=inputdir
::默认变量值
set defaultVariableValue=.
::变量描述
set variableDescription=导入目录
set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
if [%inputdir%] == [] (
	set %variableName%=%defaultVariableValue%
)

::导出目录变量
::变量名
set variableName=outputdir
::默认变量值
set defaultVariableValue=.\output
::变量描述
set variableDescription=导出目录
set /p %variableName%=输入%variableDescription%（默认：%defaultVariableValue%）：
if [%outputdir%] == [] (
	set %variableName%=%defaultVariableValue%
)

:: 变量预处理区

::水印图片宽度变量
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=width %WMFileName% >> _temp_width.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_width.txt) do @set WMw=%%i
del _temp_width.txt
::水印图片高度变量
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height %WMFileName% >> _temp_height.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_height.txt) do @set WMh=%%i
del _temp_height.txt

:: 执行区

mkdir %outputdir%
ffmpeg -i %inputdir%\%videoFileName% -vf "[in]delogo=x=%WMPlaceX%:y=%WMPlaceY%:w=%WMw%:h=%WMh%[a];movie=%WMFileName%,scale=%WMw%:%WMh%[watermark];[a][watermark] overlay=%WMPlaceX%:%WMPlaceY% [out]" %outputdir%\%videoFileName%
