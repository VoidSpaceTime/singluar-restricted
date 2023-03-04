
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")



for collisionshape in model:each_collisionshape() do 
    print(collisionshape)
    for key, value in pairs(collisionshape) do 
        print(key, value)
    end
end 


local collisionshape = lib.collisionshape.new()
collisionshape.name = "test_BOX"
collisionshape.type = 'BOX'
for vec3 in collisionshape:each_vertex() do 
    vec3.x = 1
    vec3.y = 2
    vec3.z = 3
end
model:add_collisionshape(collisionshape)


local collisionshape = lib.collisionshape.new()

collisionshape.name = "test_SPHERE"
collisionshape.type = 'SPHERE'
collisionshape:remove_vertex(1)--球体不需要第2个三角形 需要删掉
for vec3 in collisionshape:each_vertex() do 
    vec3.x = 1
    vec3.y = 2
    vec3.z = 3
end
model:add_collisionshape(collisionshape)

model:save("xxx.mdx")

model:close()