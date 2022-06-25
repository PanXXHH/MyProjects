@echo off
::水印图片名称
set /p WM=水印图片名称：
::水印图片宽度
set /p WMw=水印图片宽度：
::水印图片高度
set /p WMh=水印图片高度：
::视频类型
set /p videotype=视频类型：
::输出文件后缀
set /p outputsuffix=生成文件后缀：
::输入视频地址
set /p inputpath=输入视频地址：
::输出视频地址
set /p outputpath=输出视频地址：
::输入视频名称
set /p InVideo=输入视频名称：
::输入视频宽度
set /p MainW=输入视频宽度：
::输入视频高度
set /p MainH=输入视频高度：
ffmpeg -i %inputpath%%InVideo%.%videotype% -vf "[in]delogo=x=%MainW%-%WMw%-10:y=10:w=%WMw%:h=%WMh%[a];movie=%WM%,scale=%WMw%:%WMh%[watermark];[a][watermark] overlay=main_w-overlay_w-10:10 [out]" %outputpath%%InVideo%_%outputsuffix%.%videotype%