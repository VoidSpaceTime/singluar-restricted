
local cdef = [[



	HANDLE CreateLight();
	HANDLE CopyLight(HANDLE lighthandle);
	void CloseLight(HANDLE lighthandle, bool del);
	HANDLE GetLightByModel(HANDLE modelhandle, int index);


	const char* GetLightName(HANDLE  lighthandle);
	void SetLightName(HANDLE  lighthandle, const char* name);
	int GetLightObjectId(HANDLE  lighthandle);
	void SetLightObjectId(HANDLE  lighthandle, int value);
	int GetLightParentId(HANDLE  lighthandle);
	void SetLightParentId(HANDLE  lighthandle, int value);
	INTERPOLATOR_HANDLE GetLightTranslation(HANDLE  lighthandle);
	void SetLightTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE lighthandle);
	INTERPOLATOR_HANDLE GetLightRotation(HANDLE  lighthandle);
	void SetLightRotation(HANDLE camhandle, INTERPOLATOR_HANDLE lighthandle);
	INTERPOLATOR_HANDLE GetLightScaling(HANDLE  lighthandle);
	void SetLightScaling(HANDLE camhandle, INTERPOLATOR_HANDLE lighthandle);
	bool GetLightDontInheritTranslation(HANDLE  lighthandle);
	void SetLightDontInheritTranslation(HANDLE  lighthandle, bool value);
	bool GetLightDontInheritRotation(HANDLE  lighthandle);
	void SetLightDontInheritRotation(HANDLE  lighthandle, bool value);
	bool GetLightDontInheritScaling(HANDLE  lighthandle);
	void SetLightDontInheritScaling(HANDLE  lighthandle, bool value);
	bool GetLightBillboarded(HANDLE  lighthandle);
	void SetLightBillboarded(HANDLE  lighthandle, bool value);
	bool GetLightBillboardedLockX(HANDLE  lighthandle);
	void SetLightBillboardedLockX(HANDLE  lighthandle, bool value);
	bool GetLightBillboardedLockY(HANDLE  lighthandle);
	void SetLightBillboardedLockY(HANDLE  lighthandle, bool value);
	bool GetLightBillboardedLockZ(HANDLE  lighthandle);
	void SetLightBillboardedLockZ(HANDLE  lighthandle, bool value);
	bool GetLightCameraAnchored(HANDLE  lighthandle);
	void SetLightCameraAnchored(HANDLE  lighthandle, bool value);
	VECTOR3* GetLightPivotPoint(HANDLE  lighthandle);
	void SetLightPivotPoint(HANDLE  lighthandle, VECTOR3* value);
	int GetLightType(HANDLE  lighthandle);
	void SetLightType(HANDLE  lighthandle, int value);


	INTERPOLATOR_HANDLE GetLightAttenuationStart(HANDLE  lighthandle);
	void SetLightAttenuationStart(HANDLE  lighthandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetLightAttenuationEnd(HANDLE  lighthandle);
	void SetLightAttenuationEnd(HANDLE  lighthandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetLightColor(HANDLE  lighthandle);
	void SetLightColor(HANDLE  lighthandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetLightIntensity(HANDLE  lighthandle);
	void SetLightIntensity(HANDLE  lighthandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetLightAmbientColor(HANDLE  lighthandle);
	void SetLightAmbientColor(HANDLE  lighthandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetLightAmbientIntensity(HANDLE  lighthandle);
	void SetLightAmbientIntensity(HANDLE  lighthandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetLightVisibility(HANDLE  lighthandle);
	void SetLightVisibility(HANDLE  lighthandle, INTERPOLATOR_HANDLE interpolatorhandle);
	
]]

local modellib = require 'modellib.modellib'


return modellib.register_class('light', cdef)