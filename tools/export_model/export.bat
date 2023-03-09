cd /d %~dp0
:: 第3个参数是 地图路径 第4个参数是输出路径 第5个参数是每个图的上限数量
bin\lua.exe src\main.lua export_model "C:\Users\Administrator\Desktop\6A5F6477D4EA9B4BB9DD148FF15A752D.w3x" "C:\Users\Administrator\Desktop\test.w3x" 500

pause