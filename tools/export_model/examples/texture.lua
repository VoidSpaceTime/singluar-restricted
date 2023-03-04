
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")


--迭代器 遍历模型所有贴图
for texture in model:each_texture() do 
    print(texture)

    for key, value in pairs(texture) do 
        print('\t', key, value)
    end

    --删除模型贴图
    model:remove_texture(texture)
end

--删除所有贴图 等同 循环 remove_texture
model:clear_texture()

--新建一张空贴图
local texture = lib.texture.new()

--设置贴图路径
texture.path = "xxx.blp"

--设置贴图id
texture.replaceable_id = 5

--添加贴图给模型
model:add_texture(texture)

model:save("xxx.mdx")

model:close()