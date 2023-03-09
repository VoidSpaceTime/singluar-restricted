
local lib = require 'modellib'

--打开模型 --支持mdx mdl 路径
local model = lib.model.open("units\\other\\DranaiAkama\\DranaiAkama.mdx")



for event in model:each_eventobject() do 
    print(event.name)
    --for key, value in pairs(event) do 
    --    print(key, value)
    --end

    for int in event:each_event_track() do 
        print(int)
    end
end 

model:save("xxx.mdx")

model:close()