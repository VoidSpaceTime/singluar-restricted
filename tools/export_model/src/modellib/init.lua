local modellib = require 'modellib.modellib'

local module = require 'modellib.module'

require 'modellib.contariner'

local components = {
    'interpolator','model', 'texture', 'material', 'layer', 'camera', 'sequence',
    'attachment', 'bone', 'collisionshape','eventobject', 'helper', 'light', 
    'particle', 'particle2', 'ribbon'
}

--加载指定模块 并注册元方法
for index, component in ipairs(components) do 
    modellib[component] = require ('modellib.' .. component)
end 

--如果是内嵌在地图里
if rawget(module, 'load') then 
    function modellib.model.open(path)
        local memory = module.load(path)
        if memory == nil then
            local file_type = path:sub(path:len() - 3,path:len()):lower()
            if file_type == '.mdl' then
                path = path:sub(1,path:len() - 4) .. '.mdx'
                memory = module.load(path)
            elseif file_type == '.mdx' then
                path = path:sub(1,path:len() - 4) .. '.mdl'
                memory = module.load(path)
            end
        end
        if memory == nil then 
            return 
        end 
        local handle = module.OpenModelByMemory(path, memory, memory:len())
        if handle == module.object2c['nil']() then
            return
        end
        return setmetatable({handle = handle, path = path}, modellib.model)
    end
end




return modellib