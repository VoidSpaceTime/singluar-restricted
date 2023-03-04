
local ffi = require 'ffi'

local file = io.open([[bin\modellib.h]], "rb")
if file == nil then 
    error("缺少头文件modellib.h")
end 
local cdef = file:read("*all")
file:close()

local dll = ffi.load("modellib")

cdef = cdef:gsub('//%-%-%[%[.-%]%]', '')
ffi.cdef(cdef)


local module = {}

setmetatable(module, module)

function module:__index(name)
    return dll[name]
end 


--lua参数转换为 c 参数
module.object2c = {
    ['nil'] = function (value)
        return ffi.NULL
    end,

    ['int*'] = function (value)
        return ffi.cast('int*', ffi.new('unsigned char[?]', 4))
    end,

    ['string'] = function (value)
        return tostring(value)
    end,

    ['VECTOR2*'] = function (v)
        if v == nil then 
            v = ffi.NULL
        elseif type(v) == 'table' then 
            local vec2 = ffi.new('struct VECTOR2')
            vec2.x = v.x or v[1] or 0
            vec2.y = v.y or v[2] or 0
            return vec2
        end
        return v
    end,


    ['VECTOR3*'] = function (v)
        if v == nil then 
            v = ffi.NULL
        elseif type(v) == 'table' then 
            local vec3 = ffi.new('struct VECTOR3')
            vec3.x = v.x or v[1] or 0
            vec3.y = v.y or v[2] or 0
            vec3.z = v.z or v[3] or 0
            return vec3
        end
        return v
    end,

    ['VECTOR4*'] = function (v)
        if v == nil then 
            v = ffi.NULL
        elseif type(v) == 'table' then 
            local vec4 = ffi.new('struct VECTOR4')
            vec4.x = v.x or v[1] or 0
            vec4.y = v.y or v[2] or 0
            vec4.z = v.z or v[3] or 0
            vec4.w = v.w or v[4] or 0
            return vec4
        end
        return v
    end,

    ['EXTENT*'] = function (v)
        if v == nil then 
            v = ffi.NULL
        else
            local extent = v 
            if type(v) == 'table' then 
                extent = ffi.new('struct EXTENT')
            end
            extent.radius = v.radius or 0
            extent.min = module.object2c['VECTOR3*'](v.min or {0, 0, 0})
            extent.max = module.object2c['VECTOR3*'](v.max or {0, 0, 0})
            return extent
        end
        return v
    end,


    ['INTERPOLATOR_NODE*'] = function (v)
        local extent = v 
        if type(v) == 'table' then 
            extent = ffi.new('struct INTERPOLATOR_NODE')
        end
        extent.vector = module.object2c['VECTOR4*'](v.vector or {})
        extent.in_tan = module.object2c['VECTOR4*'](v.in_tan or {})
        extent.out_tan = module.object2c['VECTOR4*'](v.out_tan or {})
        return v
    end,
    

    ['SEQUENCE_TIME*'] = function (v)
        if v == nil then 
            return ffi.NULL 
        elseif type(v) == 'table' then 
            local time = ffi.new('struct SEQUENCE_TIME')
            time.time = v.time or v[1] or 0
            time.interval_start = v.interval_start or v[2] or 0
            time.interval_end = v.interval_end or v[3] or 0
            return v
        end

        return v
    end,


    ['INTERPOLATOR_HANDLE'] = function (v)
        if type(v) == 'table' then 
            return v.handle or 0 
        end 
        return v
    end,
}

--c参数 转换为lua参数
module.c2object = {
    ['nil'] = function (value)
        return nil
    end,

    ['int*'] = function (v)
        local ptr = ffi.cast('unsigned char*', v)
        local int = ptr[3] * 0x1000000 + ptr[2] * 0x10000 + ptr[1] * 0x100 + ptr[0]
        return int
    end,

    ['string'] = function (value, length)
        return ffi.string(value, length)
    end,

    ['VECTOR2*'] = function (v)
        if v == ffi.NULL then 
            return nil 
        end
        return v
    end,

    ['VECTOR3*'] = function (v)
        if v == ffi.NULL then 
            return nil 
        end
        return v
    end,

    ['EXTENT*'] = function (v)
        if v == ffi.NULL then 
            return nil 
        end
        return v
    end,

    ['SEQUENCE_TIME*'] = function (v)
        if v == ffi.NULL then 
            return nil 
        end
        return v
    end,

    ['INTERPOLATOR_NODE*'] = function (v)
        if v == ffi.NULL then 
            return nil 
        end
        return v
    end,

}

return module