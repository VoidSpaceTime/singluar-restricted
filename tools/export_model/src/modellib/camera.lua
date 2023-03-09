
local cdef = [[

	HANDLE CreateCamera();
	HANDLE CopyCamera(HANDLE camhandle);
    void CloseCamera(HANDLE camhandle, bool del);
    HANDLE GetCameraByModel(HANDLE modelhandle, int index);

    const char* GetCameraName(HANDLE  camhandle);
	void SetCameraName(HANDLE  camhandle, const char* name);
	VECTOR3* GetCameraSource(HANDLE  camhandle);
	void SetCameraSource(HANDLE  camhandle, VECTOR3* value);
	VECTOR3* GetCameraTarget(HANDLE  camhandle);
	void SetCameraTarget(HANDLE  camhandle, VECTOR3* value);
	float GetCameraFieldOfView(HANDLE  camhandle);
	void SetCameraFieldOfView(HANDLE  camhandle, float value);
	float GetCameraNearDistance(HANDLE  camhandle);
	void SetCameraNearDistance(HANDLE  camhandle, float value);
	float GetCameraFarDistance(HANDLE  camhandle);
	void SetCameraFarDistance(HANDLE  camhandle, float value);
    
    INTERPOLATOR_HANDLE GetCameraSourceTranslation(HANDLE  camhandle);
	void SetCameraSourceTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetCameraTargetTranslation(HANDLE  camhandle);
	void SetCameraTargetTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetCameraRotation(HANDLE  camhandle);
	void SetCameraTargetRotation(HANDLE camhandle, INTERPOLATOR_HANDLE interpolatorhandle);
]]

local modellib = require 'modellib.modellib'

return modellib.register_class('camera', cdef)