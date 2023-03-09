
local lib = require 'modellib'

--将模型转换为ui模型的参数

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("Units\\Creeps\\tuskarLord\\tuskarLord.mdl")

model:make_ui_model()

model:save("ui.mdx") --内存另存为mdx文件

model:close() --关闭模型 回收内存


