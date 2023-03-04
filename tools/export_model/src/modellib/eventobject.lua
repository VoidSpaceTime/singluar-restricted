
local cdef = [[


	HANDLE CreateEventobject();
	HANDLE CopyEventobject(HANDLE eventobjecthandle);
	void CloseEventobject(HANDLE eventobjecthandle, bool del);
	HANDLE GetEventobjectByModel(HANDLE modelhandle, int index);



	const char* GetEventobjectName(HANDLE  eventobjecthandle);
	void SetEventobjectName(HANDLE  eventobjecthandle, const char* name);
	int GetEventobjectObjectId(HANDLE  eventobjecthandle);
	void SetEventobjectObjectId(HANDLE  eventobjecthandle, int value);
	int GetEventobjectParentId(HANDLE  eventobjecthandle);
	void SetEventobjectParentId(HANDLE  eventobjecthandle, int value);
	INTERPOLATOR_HANDLE GetEventobjectTranslation(HANDLE  eventobjecthandle);
	void SetEventobjectTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE eventobjecthandle);
	INTERPOLATOR_HANDLE GetEventobjectRotation(HANDLE  eventobjecthandle);
	void SetEventobjectRotation(HANDLE camhandle, INTERPOLATOR_HANDLE eventobjecthandle);
	INTERPOLATOR_HANDLE GetEventobjectScaling(HANDLE  eventobjecthandle);
	void SetEventobjectScaling(HANDLE camhandle, INTERPOLATOR_HANDLE eventobjecthandle);
	bool GetEventobjectDontInheritTranslation(HANDLE  eventobjecthandle);
	void SetEventobjectDontInheritTranslation(HANDLE  eventobjecthandle, bool value);
	bool GetEventobjectDontInheritRotation(HANDLE  eventobjecthandle);
	void SetEventobjectDontInheritRotation(HANDLE  eventobjecthandle, bool value);
	bool GetEventobjectDontInheritScaling(HANDLE  eventobjecthandle);
	void SetEventobjectDontInheritScaling(HANDLE  eventobjecthandle, bool value);
	bool GetEventobjectBillboarded(HANDLE  eventobjecthandle);
	void SetEventobjectBillboarded(HANDLE  eventobjecthandle, bool value);
	bool GetEventobjectBillboardedLockX(HANDLE  eventobjecthandle);
	void SetEventobjectBillboardedLockX(HANDLE  eventobjecthandle, bool value);
	bool GetEventobjectBillboardedLockY(HANDLE  eventobjecthandle);
	void SetEventobjectBillboardedLockY(HANDLE  eventobjecthandle, bool value);
	bool GetEventobjectBillboardedLockZ(HANDLE  eventobjecthandle);
	void SetEventobjectBillboardedLockZ(HANDLE  eventobjecthandle, bool value);
	bool GetEventobjectCameraAnchored(HANDLE  eventobjecthandle);
	void SetEventobjectCameraAnchored(HANDLE  eventobjecthandle, bool value);
	VECTOR3* GetEventobjectPivotPoint(HANDLE  eventobjecthandle);
	void SetEventobjectPivotPoint(HANDLE  eventobjecthandle, VECTOR3* value);
	int GetEventobjectType(HANDLE  eventobjecthandle);
	void SetEventobjectType(HANDLE  eventobjecthandle, int value);

    

]]

local modellib = require 'modellib.modellib'

local module = require 'modellib.module'
local modellib = require 'modellib.modellib'

local class = modellib.register_class('eventobject', cdef)


function class:get_event_track_size()
    return module.GetEventobjectEventTrackSize(self.handle)
end

--@return vec3
function class:get_event_track(index)
    return module.c2object['VECTOR3*'](module.GetEventTrackByEventobject(self.handle, index))
end

function class:remove_event_track(index)
    return module.RemoveEventobjectEventTrack(self.handle, index)
end

function class:add_event_track(vec3)
    module.AddEventobjectEventTrack(self.handle,  module.object2c['VECTOR3*'](vec3 or {}))
end

function class:each_event_track()
    local size = self:get_event_track_size()

    local result = {}
    for i = 0, size - 1 do 
        table.insert(result,  self:get_event_track(i))
    end 
    local n = 0
    return function (t, v)
        n = n + 1
        return t[n]
    end, result
end 


return class