@echo off
set AWM_CORE_VERSION = 1.2.20220620
::变量输入区（必填）

::要处理的视频名称
:videoFileName
set /p videoFileName=输入要处理的视频名称：
if [%videoFileName%] == [] (
	echo "本参数为必填参数"
	goto videoFileName
)

::变量输入区（选填）

::水印文件名称
set /p WMFileName=输入水印文件名称（默认：logo.png）：
if [%WMFileName%] == [] (
	set WMFileName=logo.png
)
::水印X起始位置
set /p WMPlaceX=输入水印X起始位置（默认：10）：
if [%WMPlaceX%] == [] (
	set WMPlaceX=10
)
::水印Y起始位置
set /p WMPlaceY=输入水印Y起始位置（默认：15）：
if [%WMPlaceY%] == [] (
	set WMPlaceY=15
)
::导入目录
set /p inputdir=输入导入目录（默认：.）：
if [%inputdir%] == [] (
	set inputdir=.
)
::导出目录
set /p outputdir=输入导出目录（默认：.\output）：
if [%outputdir%] == [] (
	set outputdir=.\output
)

:: 变量预处理区

::水印图片宽度
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=width %WMFileName% >> _temp_width.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_width.txt) do @set WMw=%%i
del _temp_width.txt
::水印图片高度
ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height %WMFileName% >> _temp_height.txt
FOR /f "tokens=5 delims==_" %%i in (_temp_height.txt) do @set WMh=%%i
del _temp_height.txt

mkdir %outputdir%
ffmpeg -i %inputdir%\%videoFileName% -vf "[in]delogo=x=%WMPlaceX%:y=%WMPlaceY%:w=%WMw%:h=%WMh%[a];movie=%WMFileName%,scale=%WMw%:%WMh%[watermark];[a][watermark] overlay=%WMPlaceX%:%WMPlaceY% [out]" %outputdir%\%videoFileName%