
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")

--遍历所有材质
for material in model:each_material() do 
    --遍历材质里所有图层
    for layer in material:each_layer() do 

        --遍历图层属性 将所有boolean类型的值改为true
        for k, v in pairs(layer) do 
            print('\t',layer, k, v)
            if type(v) == 'boolean' then 
                layer[k] = true
            end
        end 

        --设置动画id 为非静态id 根据字符串 使用指定帧数
        local animated_texture_id = layer.animated_texture_id
        animated_texture_id:from_string([[
0:0
100:100
200:200
        ]])
        
        --打印
        print(animated_texture_id:to_string())


    end 
    material:close()
end 


model:save("xxx.mdx")

model:close()