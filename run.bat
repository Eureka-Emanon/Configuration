@echo off
set "ROOT=%~dp0"

:: 设置 HOME 为 U 盘上的Home
set "HOME=%ROOT%Home"

:: 把 Emacs 的 bin 目录加入 PATH（确保 Emacs 能找到自己的 DLL）
set "PATH=%ROOT%Windows\emacs-30.2\bin;%PATH%"

:: 启动 Emacs
start "" "%ROOT%Windows\emacs-30.2\bin\runemacs.exe"
