@echo off
::ˮӡͼƬ����
set /p WM=ˮӡͼƬ���ƣ�
::ˮӡͼƬ���
set /p WMw=ˮӡͼƬ��ȣ�
::ˮӡͼƬ�߶�
set /p WMh=ˮӡͼƬ�߶ȣ�
::��Ƶ����
set /p videotype=��Ƶ���ͣ�
::����ļ���׺
set /p outputsuffix=�����ļ���׺��
::������Ƶ��ַ
set /p inputpath=������Ƶ��ַ��
::�����Ƶ��ַ
set /p outputpath=�����Ƶ��ַ��
::������Ƶ����
set /p InVideo=������Ƶ���ƣ�
::������Ƶ���
set /p MainW=������Ƶ��ȣ�
::������Ƶ�߶�
set /p MainH=������Ƶ�߶ȣ�
ffmpeg -i %inputpath%%InVideo%.%videotype% -vf "[in]delogo=x=%MainW%-%WMw%-10:y=10:w=%WMw%:h=%WMh%[a];movie=%WM%,scale=%WMw%:%WMh%[watermark];[a][watermark] overlay=main_w-overlay_w-10:10 [out]" %outputpath%%InVideo%_%outputsuffix%.%videotype%