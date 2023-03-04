
local cdef = [[
	INTERPOLATOR_HANDLE CreateInterpolator();
	INTERPOLATOR_HANDLE CopyInterpolator(INTERPOLATOR_HANDLE interhandle);
	void CloseInterpolator(INTERPOLATOR_HANDLE interhandle, bool del);
	void InterpolatorClear(INTERPOLATOR_HANDLE interhandle);
	int GetInterpolatorSize(INTERPOLATOR_HANDLE interhandle);
	INTERPOLATOR_NODE* GetInterpolatorNode(INTERPOLATOR_HANDLE interhandle, int index);
	bool GetInterpolatorIsStatic(INTERPOLATOR_HANDLE interhandle);
	int GetInterpolatorDataType(INTERPOLATOR_HANDLE interhandle);
	void SetInterpolatorDataType(INTERPOLATOR_HANDLE interhandle, int type);
	int GetInterpolatorType(INTERPOLATOR_HANDLE interhandle);
	void SetInterpolatorType(INTERPOLATOR_HANDLE interhandle, int type);
	void SetInterpolatorGlobalSequenceId(INTERPOLATOR_HANDLE interhandle, int sequence_id);
	int GetInterpolatorGlobalSequenceId(INTERPOLATOR_HANDLE interhandle);
	const char* GetInterpolatorString(INTERPOLATOR_HANDLE interhandle);
	bool SetInterpolatorString(INTERPOLATOR_HANDLE interhandle, const char* str);

	float GetInterpolatorStaticScalar(INTERPOLATOR_HANDLE interhandle, SEQUENCE_TIME* time);
	bool GetInterpolatorVector2(INTERPOLATOR_HANDLE interhandle, SEQUENCE_TIME* time, VECTOR2* result);
	bool GetInterpolatorVector3(INTERPOLATOR_HANDLE interhandle, SEQUENCE_TIME* time, VECTOR3* result);
	bool GetInterpolatorVector4(INTERPOLATOR_HANDLE interhandle, SEQUENCE_TIME* time, VECTOR4* result);
	bool SetInterpolatorStaticScalar(INTERPOLATOR_HANDLE interhandle, float value, const char* name);
	bool SetInterpolatorStaticScalarInt(INTERPOLATOR_HANDLE interhandle, int value, const char* name);
	bool SetInterpolatorStaticVector2(INTERPOLATOR_HANDLE interhandle, VECTOR2* value, const char* name);
	bool SetInterpolatorStaticVector3(INTERPOLATOR_HANDLE interhandle, VECTOR3* value, const char* name);
	bool SetInterpolatorStaticVector4(INTERPOLATOR_HANDLE interhandle, VECTOR4* value, const char* name);
]]


local module = require 'modellib.module'


local modellib = require 'modellib.modellib'


local interpolator = modellib.register_class('interpolator', cdef)

interpolator._name = ""

local new = interpolator.new 

--@name: string 例如 对象为 .color 的属性时 名字应该为 Color 
function interpolator.new(name)
    if name == nil then 
        print("构造新的插值器必须填名字, 名字必须是所属对象 属性名的 大驼峰格式", debug.traceback())
        return 
    end

    local object = new()
    object._name = name 
    return object
end 

function interpolator.open(owner, handle, name)
 
    local object = interpolator.all_interpolator_map[tonumber(handle)]
    if object then 
        return object
    end 

    object = setmetatable({handle = handle, owner = owner}, interpolator)

    object._name = name

    interpolator.all_interpolator_map[tonumber(handle)] = object
    return object
end 


function interpolator:clear_node()
    module.InterpolatorClear(self.handle)
end

function interpolator:get_nodes_size()
    return module.GetInterpolatorSize(self.handle)
end

function interpolator:get_node(index)
    return module.c2object['INTERPOLATOR_NODE*'](module.GetInterpolatorNode(self.handle, index))
end

function interpolator:is_static()
    return module.GetInterpolatorIsStatic(self.handle)
end

local type_map = { 
    'NONE', 'SCALAR', 'SCALAR_INT', 'VECTOR2', 'VECTOR3', 'VECTOR4',
    ['NONE'] = 1, ['SCALAR'] = 2, ['SCALAR_INT'] = 3, ['VECTOR2'] = 4, ['VECTOR3'] = 5, ['VECTOR4'] = 6,
}
--获取该插值器储存的数据类型 
function interpolator:get_data_type()
    local type_index = module.GetInterpolatorDataType(self.handle)
    return type_map[type_index + 1]
end

--设置插值器的储存数据类型
function interpolator:set_data_type(name)
    local index = type_map[name] or type_map['NONE']
    module.SetInterpolatorDataType(self.handle, index - 1)
end 

local interpolator_type = {
    'NONE', 'LINEAR', 'HERMITE', 'BEZIER',
    ['NONE'] = 1,['LINEAR'] = 2,['HERMITE'] = 3,['BEZIER'] = 4,
}

--获取该插值器储存的类型 
function interpolator:get_type()
    local type_index = module.GetInterpolatorType(self.handle)
    return interpolator_type[type_index + 1]
end

--设置插值器的类型
function interpolator:set_type(name)
    local index = interpolator_type[name] or interpolator_type['NONE']
    module.SetInterpolatorType(self.handle, index - 1)
end 


--获取全局动画id
function interpolator:get_global_sequence_id()
    return module.GetInterpolatorGlobalSequenceId(self.handle)
end

--设置全局动画id
function interpolator:set_global_sequence_id(id)
    module.SetInterpolatorGlobalSequenceId(self.handle, id)
end

--将插值器转换为字符串 只有非静态插值器才可以转换
function interpolator:to_string()
    return module.c2object['string'](module.GetInterpolatorString(self.handle))
end
--给插值器设置字符串 设置了之后 改变为 非静态插值器
function interpolator:from_string(string)
    return module.SetInterpolatorString(self.handle, tostring(string))
end

--获取缩放倍率
--@time: nil | SEQUENCE_TIME对象 | table{ time:integer, intervalStart:integer, intervalEnd:ingeger}
--@return number 缩放
function interpolator:get_scalar(time)
    return module.GetInterpolatorStaticScalar(self.handle, module.object2c['SEQUENCE_TIME*'](time))
end


--获取数据
--@time: nil | SEQUENCE_TIME对象 | table{ time:integer, intervalStart:integer, intervalEnd:ingeger}
--@return VECTOR2 包含2值
function interpolator:get_vec2(time)
    local vec2 = module.object2c['VECTOR2*']({})
    module.GetInterpolatorVector2(self.handle, module.object2c['SEQUENCE_TIME*'](time), vec2)
    return vec2
end


--获取数据
--@time: nil | SEQUENCE_TIME对象 | table{ time:integer, intervalStart:integer, intervalEnd:ingeger}
--@return VECTOR3 包含3值
function interpolator:get_vec3(time)
    local vec3 = module.object2c['VECTOR3*']({})
    module.GetInterpolatorVector3(self.handle, module.object2c['SEQUENCE_TIME*'](time), vec3)
    return vec3
end


--获取数据
--@time: nil | SEQUENCE_TIME对象 | table{ time:integer, intervalStart:integer, intervalEnd:ingeger}
--@return VECTOR4 包含3值
function interpolator:get_vec4(time)
    local vec4 = module.object2c['VECTOR4*']({})
    module.GetInterpolatorVector4(self.handle, module.object2c['SEQUENCE_TIME*'](time), vec4)
    return vec4
end


--设置缩放倍率
--@vaule: number
--@name: string  不用填 封装层自动填入该参数
--@return number 缩放
function interpolator:set_scalar(value, name)
    self._name = name or self._name
    module.SetInterpolatorStaticScalar(self.handle, value, self._name)
end

--设置缩放倍率
--@vaule: number
--@name: string 不用填 封装层自动填入该参数
--@return number 缩放
function interpolator:set_scalar_int(value, name)
    self._name = name or self._name
    module.SetInterpolatorStaticScalarInt(self.handle, value, self._name)
end


--设置静态数据
--@vec2: VECTOR2 | array[2] | {x, y}
--@name: string
--@return bool 是否设置成功 只有静态插值器 才可以设置数值
function interpolator:set_vec2(vec2, name)
    self._name = name or self._name
    return module.SetInterpolatorStaticVector2(self.handle, module.object2c['VECTOR2*'](vec2), self._name)
end

--设置静态数据
--@vec3: VECTOR3 | array[3] | {x, y, z}
--@name: string 不用填 封装层自动填入该参数
--@return bool 是否设置成功 只有静态插值器 才可以设置数值
function interpolator:set_vec3(vec3, name)
    self._name = name or self._name
    return module.SetInterpolatorStaticVector3(self.handle, module.object2c['VECTOR3*'](vec3), self._name)
end

--设置静态数据
--@vec4: VECTOR4 | array[4] | {x, y, z, w}
--@name: string 不用填 封装层自动填入该参数
--@return bool 是否设置成功 只有静态插值器 才可以设置数值
function interpolator:set_vec4(vec4, name)
    self._name = name or self._name
    return module.SetInterpolatorStaticVector4(self.handle, module.object2c['VECTOR4*'](vec4), self._name)
end


return interpolator