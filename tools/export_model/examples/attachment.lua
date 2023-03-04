
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")



for node in model:each_attachment() do 
    print(node.name)
    for key, value in pairs(node) do 
        print(key, value)
    end
end 

model:save("xxx.mdx")

model:close()