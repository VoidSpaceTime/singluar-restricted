
local cdef = [[


    HANDLE CreateBone();
	HANDLE CopyBone(HANDLE bonehandle);
	void CloseBone(HANDLE bonehandle, bool del);
	HANDLE GetBoneByModel(HANDLE modelhandle, int index);

    const char* GetBoneName(HANDLE  bonehandle);
	void SetBoneName(HANDLE  bonehandle, const char* name);
	int GetBoneObjectId(HANDLE  bonehandle);
	void SetBoneObjectId(HANDLE  bonehandle, int value);
	int GetBoneParentId(HANDLE  bonehandle);
	void SetBoneParentId(HANDLE  bonehandle, int value);
	INTERPOLATOR_HANDLE GetBoneTranslation(HANDLE  bonehandle);
	void SetBoneTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE bonehandle);
	INTERPOLATOR_HANDLE GetBoneRotation(HANDLE  bonehandle);
	void SetBoneRotation(HANDLE camhandle, INTERPOLATOR_HANDLE bonehandle);
	INTERPOLATOR_HANDLE GetBoneScaling(HANDLE  bonehandle);
	void SetBoneScaling(HANDLE camhandle, INTERPOLATOR_HANDLE bonehandle);
	bool GetBoneDontInheritTranslation(HANDLE  bonehandle);
	void SetBoneDontInheritTranslation(HANDLE  bonehandle, bool value);
	bool GetBoneDontInheritRotation(HANDLE  bonehandle);
	void SetBoneDontInheritRotation(HANDLE  bonehandle, bool value);
	bool GetBoneDontInheritScaling(HANDLE  bonehandle);
	void SetBoneDontInheritScaling(HANDLE  bonehandle, bool value);
	bool GetBoneBillboarded(HANDLE  bonehandle);
	void SetBoneBillboarded(HANDLE  bonehandle, bool value);
	bool GetBoneBillboardedLockX(HANDLE  bonehandle);
	void SetBoneBillboardedLockX(HANDLE  bonehandle, bool value);
	bool GetBoneBillboardedLockY(HANDLE  bonehandle);
	void SetBoneBillboardedLockY(HANDLE  bonehandle, bool value);
	bool GetBoneBillboardedLockZ(HANDLE  bonehandle);
	void SetBoneBillboardedLockZ(HANDLE  bonehandle, bool value);
	bool GetBoneCameraAnchored(HANDLE  bonehandle);
	void SetBoneCameraAnchored(HANDLE  bonehandle, bool value);
	VECTOR3* GetBonePivotPoint(HANDLE  bonehandle);
	void SetBonePivotPoint(HANDLE  bonehandle, VECTOR3* value);
	int GetBoneType(HANDLE  bonehandle);
    void SetBoneType(HANDLE  bonehandle, int value);
    
    int GetBoneGeosetId(HANDLE  bonehandle);
	void SetBoneGeosetId(HANDLE  bonehandle, int value);
	int GetBoneGeosetAnimationId(HANDLE  bonehandle);
	void SetBoneGeosetAnimationId(HANDLE  bonehandle, int value);
]]

local modellib = require 'modellib.modellib'


return modellib.register_class('bone', cdef)