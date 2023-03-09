
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")


--清空所有镜头
model:clear_camera()

----镜头
for i = 1, 10 do 
    local camera = lib.camera.new()

    camera.name = "name" .. i 

    camera.source = {7, 8, 9}
    camera.target = camera.source

    print(camera.source, camera.source.x, camera.source.y, camera.source.z)
    print(camera.target, camera.target.x, camera.target.y, camera.target.z)

    model:add_camera(camera)
end 

for camera in model:each_camera() do 
    for key, value in pairs(camera) do 
        print(key, value)
    end
end

model:save("xxx.mdx")

model:close()