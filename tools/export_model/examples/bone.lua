
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")



for bone in model:each_bone() do 
    print(bone)
    for key, value in pairs(bone) do 
        print(key, value)
    end
end 

model:save("xxx.mdx")

model:close()