
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")



--for light in model:each_light() do 
    --print(light, light.name)
    --for key, value in pairs(light) do 
    --    print(key, value)
    --end
--end 

local light = lib.light.new()

light.name = "test_light"


light.color:set_vec3({0.5, 0.5, 0.5})

for key, value in pairs(light) do 
    print(key, value)
end




model:add_light(light)

model:save("xxx.mdx")

model:close()