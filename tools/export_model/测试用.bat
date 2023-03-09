cd /d %~dp0

:: 第3个参数是 地图路径 第4个参数是输出路径 第5个参数是每个图的上限数量
bin\lua.exe src\main.lua test "%1" "%1" 500

pause