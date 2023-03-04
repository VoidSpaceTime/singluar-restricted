
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")



--for particle2 in model:each_particle2() do 
    --print(particle2, particle2.name)
    --for key, value in pairs(particle2) do 
    --    print(key, value)
    --end
--end 

--新建一张空贴图
local texture = lib.texture.new()

--设置贴图路径
texture.path = "xxx.blp"

--添加贴图给模型
model:add_texture(texture)


local particle2 = lib.particle2.new()

particle2.name = "test_particle2"

particle2.texture_id = model:get_texture_size() - 1

for key, value in pairs(particle2) do 
    print(key, value)
end


model:add_particle2(particle2)

model:save("xxx.mdx")

model:close()