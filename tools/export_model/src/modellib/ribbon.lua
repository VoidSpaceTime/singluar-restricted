
local cdef = [[
    

	HANDLE CreateRibbon();
	HANDLE CopyRibbon(HANDLE ribbonhandle);
	void CloseRibbon(HANDLE ribbonhandle, bool del);
	HANDLE GetRibbonByModel(HANDLE modelhandle, int index);


	const char* GetRibbonName(HANDLE  ribbonhandle);
	void SetRibbonName(HANDLE  ribbonhandle, const char* name);
	int GetRibbonObjectId(HANDLE  ribbonhandle);
	void SetRibbonObjectId(HANDLE  ribbonhandle, int value);
	int GetRibbonParentId(HANDLE  ribbonhandle);
	void SetRibbonParentId(HANDLE  ribbonhandle, int value);
	INTERPOLATOR_HANDLE GetRibbonTranslation(HANDLE  ribbonhandle);
	void SetRibbonTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE ribbonhandle);
	INTERPOLATOR_HANDLE GetRibbonRotation(HANDLE  ribbonhandle);
	void SetRibbonRotation(HANDLE camhandle, INTERPOLATOR_HANDLE ribbonhandle);
	INTERPOLATOR_HANDLE GetRibbonScaling(HANDLE  ribbonhandle);
	void SetRibbonScaling(HANDLE camhandle, INTERPOLATOR_HANDLE ribbonhandle);
	bool GetRibbonDontInheritTranslation(HANDLE  ribbonhandle);
	void SetRibbonDontInheritTranslation(HANDLE  ribbonhandle, bool value);
	bool GetRibbonDontInheritRotation(HANDLE  ribbonhandle);
	void SetRibbonDontInheritRotation(HANDLE  ribbonhandle, bool value);
	bool GetRibbonDontInheritScaling(HANDLE  ribbonhandle);
	void SetRibbonDontInheritScaling(HANDLE  ribbonhandle, bool value);
	bool GetRibbonBillboarded(HANDLE  ribbonhandle);
	void SetRibbonBillboarded(HANDLE  ribbonhandle, bool value);
	bool GetRibbonBillboardedLockX(HANDLE  ribbonhandle);
	void SetRibbonBillboardedLockX(HANDLE  ribbonhandle, bool value);
	bool GetRibbonBillboardedLockY(HANDLE  ribbonhandle);
	void SetRibbonBillboardedLockY(HANDLE  ribbonhandle, bool value);
	bool GetRibbonBillboardedLockZ(HANDLE  ribbonhandle);
	void SetRibbonBillboardedLockZ(HANDLE  ribbonhandle, bool value);
	bool GetRibbonCameraAnchored(HANDLE  ribbonhandle);
	void SetRibbonCameraAnchored(HANDLE  ribbonhandle, bool value);
	VECTOR3* GetRibbonPivotPoint(HANDLE  ribbonhandle);
	void SetRibbonPivotPoint(HANDLE  ribbonhandle, VECTOR3* value);
	int GetRibbonType(HANDLE  ribbonhandle);
	void SetRibbonType(HANDLE  ribbonhandle, int value);



	INTERPOLATOR_HANDLE GetRibbonHeightAbove(HANDLE  ribbonhandle);
	void SetRibbonHeightAbove(HANDLE  ribbonhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetRibbonHeightBelow(HANDLE  ribbonhandle);
	void SetRibbonHeightBelow(HANDLE  ribbonhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetRibbonAlpha(HANDLE  ribbonhandle);
	void SetRibbonAlpha(HANDLE  ribbonhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetRibbonColor(HANDLE  ribbonhandle);
	void SetRibbonColor(HANDLE  ribbonhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetRibbonTextureSlot(HANDLE  ribbonhandle);
	void SetRibbonTextureSlot(HANDLE  ribbonhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetRibbonVisibility(HANDLE  ribbonhandle);
	void SetRibbonVisibility(HANDLE  ribbonhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	float GetRibbonEmissionRate(HANDLE  ribbonhandle);
	void SetRibbonEmissionRate(HANDLE  ribbonhandle, float value);
	float GetRibbonLifeSpan(HANDLE  ribbonhandle);
	void SetRibbonLifeSpan(HANDLE  ribbonhandle, float value);
	float GetRibbonGravity(HANDLE  ribbonhandle);
	void SetRibbonGravity(HANDLE  ribbonhandle, float value);
	int GetRibbonRows(HANDLE  ribbonhandle);
	void SetRibbonRows(HANDLE  ribbonhandle, int value);
	int GetRibbonColumns(HANDLE  ribbonhandle);
	void SetRibbonColumns(HANDLE  ribbonhandle, int value);
	int GetRibbonMaterialId(HANDLE  ribbonhandle);;
	void SetRibbonMaterialId(HANDLE  ribbonhandle, int value);
	int GetRibbonHasBug(HANDLE  ribbonhandle);
	void SetRibbonHasBug(HANDLE  ribbonhandle, bool value);

]]

local modellib = require 'modellib.modellib'


return modellib.register_class('ribbon', cdef)