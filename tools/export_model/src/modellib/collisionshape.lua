
local cdef = [[

	
	HANDLE CreateCollisionshape();
	HANDLE CopyCollisionshape(HANDLE collisionshapehandle);
	void CloseCollisionshape(HANDLE collisionshapehandle, bool del);
	HANDLE GetCollisionshapeByModel(HANDLE modelhandle, int index);



	const char* GetCollisionshapeName(HANDLE  collisionshapehandle);
	void SetCollisionshapeName(HANDLE  collisionshapehandle, const char* name);
	int GetCollisionshapeObjectId(HANDLE  collisionshapehandle);
	void SetCollisionshapeObjectId(HANDLE  collisionshapehandle, int value);
	int GetCollisionshapeParentId(HANDLE  collisionshapehandle);
	void SetCollisionshapeParentId(HANDLE  collisionshapehandle, int value);
	INTERPOLATOR_HANDLE GetCollisionshapeTranslation(HANDLE  collisionshapehandle);
	void SetCollisionshapeTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE collisionshapehandle);
	INTERPOLATOR_HANDLE GetCollisionshapeRotation(HANDLE  collisionshapehandle);
	void SetCollisionshapeRotation(HANDLE camhandle, INTERPOLATOR_HANDLE collisionshapehandle);
	INTERPOLATOR_HANDLE GetCollisionshapeScaling(HANDLE  collisionshapehandle);
	void SetCollisionshapeScaling(HANDLE camhandle, INTERPOLATOR_HANDLE collisionshapehandle);
	bool GetCollisionshapeDontInheritTranslation(HANDLE  collisionshapehandle);
	void SetCollisionshapeDontInheritTranslation(HANDLE  collisionshapehandle, bool value);
	bool GetCollisionshapeDontInheritRotation(HANDLE  collisionshapehandle);
	void SetCollisionshapeDontInheritRotation(HANDLE  collisionshapehandle, bool value);
	bool GetCollisionshapeDontInheritScaling(HANDLE  collisionshapehandle);
	void SetCollisionshapeDontInheritScaling(HANDLE  collisionshapehandle, bool value);
	bool GetCollisionshapeBillboarded(HANDLE  collisionshapehandle);
	void SetCollisionshapeBillboarded(HANDLE  collisionshapehandle, bool value);
	bool GetCollisionshapeBillboardedLockX(HANDLE  collisionshapehandle);
	void SetCollisionshapeBillboardedLockX(HANDLE  collisionshapehandle, bool value);
	bool GetCollisionshapeBillboardedLockY(HANDLE  collisionshapehandle);
	void SetCollisionshapeBillboardedLockY(HANDLE  collisionshapehandle, bool value);
	bool GetCollisionshapeBillboardedLockZ(HANDLE  collisionshapehandle);
	void SetCollisionshapeBillboardedLockZ(HANDLE  collisionshapehandle, bool value);
	bool GetCollisionshapeCameraAnchored(HANDLE  collisionshapehandle);
	void SetCollisionshapeCameraAnchored(HANDLE  collisionshapehandle, bool value);
	VECTOR3* GetCollisionshapePivotPoint(HANDLE  collisionshapehandle);
	void SetCollisionshapePivotPoint(HANDLE  collisionshapehandle, VECTOR3* value);
	int GetCollisionshapeType(HANDLE  collisionshapehandle);
	void SetCollisionshapeType(HANDLE  collisionshapehandle, int value);


	
	float GetCollisionshapeBoundsRadius(HANDLE  collisionshapehandle);
	void SetCollisionshapeBoundsRadius(HANDLE  collisionshapehandle, float value);
    VECTOR3* GetVertexByCollisionshape(HANDLE collisionshapehandle, int index);
    


    
]] 


local module = require 'modellib.module'
local modellib = require 'modellib.modellib'

local class = modellib.register_class('collisionshape', cdef)


function class:get_vertex_size()
    return module.GetCollisionshapeVertexSize(self.handle)
end

--@return vec3
function class:get_vertex(index)
    return module.c2object['VECTOR3*'](module.GetVertexByCollisionshape(self.handle, index))
end

function class:remove_vertex(index)
    return module.RemoveCollisionshapVertex(self.handle, index)
end

function class:add_vertex(vec3)
    module.AddCollisionshapVertex(self.handle,  module.object2c['VECTOR3*'](vec3 or {}))
end

function class:each_vertex()
    local size = self:get_vertex_size()

    local result = {}
    for i = 0, size - 1 do 
        table.insert(result,  self:get_vertex(i))
    end 
    local n = 0
    return function (t, v)
        n = n + 1
        return t[n]
    end, result
end 



local map = { 
    'NONE', 'BOX', 'SPHERE',
    ['NONE'] = 1, ['BOX'] = 2, ['SPHERE'] = 3,
}

local get_type = class.get_type
--获取碰撞的类型 
function class:get_type()
    local index = get_type(self)
    return map[index + 1]
end

local set_type = class.set_type
--设置碰撞的类型
function class:set_type(name)
    local index = map[name] or map['NONE']
    set_type(self, index - 1)
end 


return class