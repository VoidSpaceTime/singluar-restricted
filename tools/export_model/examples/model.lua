
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("Units\\Creeps\\tuskarLord\\tuskarLord.mdl")


local model2 = model:copy() -- 复制构造

model2:close() --关闭模型 回收内存

model:save("xxx.mdx") --内存另存为mdx文件

model:save("xxx2.mdl") --内存另存为mdl文件

model:close()