
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")



--for ribbon in model:each_ribbon() do 
    --print(ribbon, ribbon.name)
    --for key, value in pairs(ribbon) do 
    --    print(key, value)
    --end
--end 

local ribbon = lib.ribbon.new()


for key, value in pairs(ribbon) do 
    print(key, value)
end


model:add_ribbon(ribbon)

model:save("xxx.mdx")

model:close()