
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")



--for particle in model:each_particle() do 
    --print(particle, particle.name)
    --for key, value in pairs(particle) do 
    --    print(key, value)
    --end
--end 

local particle = lib.particle.new()

particle.name = "test_particle"

particle.file_name = "xx.blp"

for key, value in pairs(particle) do 
    print(key, value)
end


model:add_particle(particle)

model:save("xxx.mdx")

model:close()