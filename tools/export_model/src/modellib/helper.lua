
local cdef = [[


   
	HANDLE CreateHelper();
	HANDLE CopyHelper(HANDLE helperhandle);
	void CloseHelper(HANDLE helperhandle, bool del);
	HANDLE GetHelperByModel(HANDLE modelhandle, int index);


	const char* GetHelperName(HANDLE  helperhandle);
	void SetHelperName(HANDLE  helperhandle, const char* name);
	int GetHelperObjectId(HANDLE  helperhandle);
	void SetHelperObjectId(HANDLE  helperhandle, int value);
	int GetHelperParentId(HANDLE  helperhandle);
	void SetHelperParentId(HANDLE  helperhandle, int value);
	INTERPOLATOR_HANDLE GetHelperTranslation(HANDLE  helperhandle);
	void SetHelperTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE helperhandle);
	INTERPOLATOR_HANDLE GetHelperRotation(HANDLE  helperhandle);
	void SetHelperRotation(HANDLE camhandle, INTERPOLATOR_HANDLE helperhandle);
	INTERPOLATOR_HANDLE GetHelperScaling(HANDLE  helperhandle);
	void SetHelperScaling(HANDLE camhandle, INTERPOLATOR_HANDLE helperhandle);
	bool GetHelperDontInheritTranslation(HANDLE  helperhandle);
	void SetHelperDontInheritTranslation(HANDLE  helperhandle, bool value);
	bool GetHelperDontInheritRotation(HANDLE  helperhandle);
	void SetHelperDontInheritRotation(HANDLE  helperhandle, bool value);
	bool GetHelperDontInheritScaling(HANDLE  helperhandle);
	void SetHelperDontInheritScaling(HANDLE  helperhandle, bool value);
	bool GetHelperBillboarded(HANDLE  helperhandle);
	void SetHelperBillboarded(HANDLE  helperhandle, bool value);
	bool GetHelperBillboardedLockX(HANDLE  helperhandle);
	void SetHelperBillboardedLockX(HANDLE  helperhandle, bool value);
	bool GetHelperBillboardedLockY(HANDLE  helperhandle);
	void SetHelperBillboardedLockY(HANDLE  helperhandle, bool value);
	bool GetHelperBillboardedLockZ(HANDLE  helperhandle);
	void SetHelperBillboardedLockZ(HANDLE  helperhandle, bool value);
	bool GetHelperCameraAnchored(HANDLE  helperhandle);
	void SetHelperCameraAnchored(HANDLE  helperhandle, bool value);
	VECTOR3* GetHelperPivotPoint(HANDLE  helperhandle);
	void SetHelperPivotPoint(HANDLE  helperhandle, VECTOR3* value);
	int GetHelperType(HANDLE  helperhandle);
	void SetHelperType(HANDLE  helperhandle, int value);


]]

local modellib = require 'modellib.modellib'


return modellib.register_class('helper', cdef)