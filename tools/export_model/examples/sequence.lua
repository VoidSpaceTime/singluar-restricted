
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")


for sequence in model:each_sequence() do 
    for k, v in pairs(sequence) do 
        if type(v) == 'number' then 
            sequence[k] = 999
        end 
    end 
    sequence.name = sequence.name .. '_test'
    sequence.interval = {555, 666}
    sequence.extent = {
        radius = 888,
        min = {2, 2, 2},
        max = {3, 3, 3},
    }

    for key, value in pairs(sequence) do 
        print(key, value)
    end
end 



model:save("xxx.mdx")

model:close()