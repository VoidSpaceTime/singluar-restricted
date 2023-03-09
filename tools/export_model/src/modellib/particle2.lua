
local cdef = [[
	

	HANDLE CreateParticle2();
	HANDLE CopyParticle2(HANDLE particle2handle);
	void CloseParticle2(HANDLE particle2handle, bool del);
	HANDLE GetParticle2ByModel(HANDLE modelhandle, int index);

	const char* GetParticle2Name(HANDLE  particle2handle);
	void SetParticle2Name(HANDLE  particle2handle, const char* name);
	int GetParticle2ObjectId(HANDLE  particle2handle);
	void SetParticle2ObjectId(HANDLE  particle2handle, int value);
	int GetParticle2ParentId(HANDLE  particle2handle);
	void SetParticle2ParentId(HANDLE  particle2handle, int value);
	INTERPOLATOR_HANDLE GetParticle2Translation(HANDLE  particle2handle);
	void SetParticle2Translation(HANDLE camhandle, INTERPOLATOR_HANDLE particle2handle);
	INTERPOLATOR_HANDLE GetParticle2Rotation(HANDLE  particle2handle);
	void SetParticle2Rotation(HANDLE camhandle, INTERPOLATOR_HANDLE particle2handle);
	INTERPOLATOR_HANDLE GetParticle2Scaling(HANDLE  particle2handle);
	void SetParticle2Scaling(HANDLE camhandle, INTERPOLATOR_HANDLE particle2handle);
	bool GetParticle2DontInheritTranslation(HANDLE  particle2handle);
	void SetParticle2DontInheritTranslation(HANDLE  particle2handle, bool value);
	bool GetParticle2DontInheritRotation(HANDLE  particle2handle);
	void SetParticle2DontInheritRotation(HANDLE  particle2handle, bool value);
	bool GetParticle2DontInheritScaling(HANDLE  particle2handle);
	void SetParticle2DontInheritScaling(HANDLE  particle2handle, bool value);
	bool GetParticle2Billboarded(HANDLE  particle2handle);
	void SetParticle2Billboarded(HANDLE  particle2handle, bool value);
	bool GetParticle2BillboardedLockX(HANDLE  particle2handle);
	void SetParticle2BillboardedLockX(HANDLE  particle2handle, bool value);
	bool GetParticle2BillboardedLockY(HANDLE  particle2handle);
	void SetParticle2BillboardedLockY(HANDLE  particle2handle, bool value);
	bool GetParticle2BillboardedLockZ(HANDLE  particle2handle);
	void SetParticle2BillboardedLockZ(HANDLE  particle2handle, bool value);
	bool GetParticle2CameraAnchored(HANDLE  particle2handle);
	void SetParticle2CameraAnchored(HANDLE  particle2handle, bool value);
	VECTOR3* GetParticle2PivotPoint(HANDLE  particle2handle);
	void SetParticle2PivotPoint(HANDLE  particle2handle, VECTOR3* value);
	int GetParticle2Type(HANDLE  particle2handle);
	void SetParticle2Type(HANDLE  particle2handle, int value);



	int GetParticle2FilterMode(HANDLE  particle2handle);
	void SetParticle2FilterMode(HANDLE  particle2handle, int filter_mode);
	INTERPOLATOR_HANDLE GetParticle2Speed(HANDLE  particle2handle);
	void SetParticle2Speed(HANDLE  particle2handle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticle2Variation(HANDLE  particle2handle);
	void SetParticle2Variation(HANDLE  particle2handle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticle2Latitude(HANDLE  particle2handle);
	void SetParticle2Latitude(HANDLE  particle2handle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticle2Gravity(HANDLE  particle2handle);
	void SetParticle2Gravity(HANDLE  particle2handle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticle2Visibility(HANDLE  particle2handle);
	void SetParticle2Visibility(HANDLE  particle2handle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticle2EmissionRate(HANDLE  particle2handle);
	void SetParticle2EmissionRate(HANDLE  particle2handle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticle2Width(HANDLE  particle2handle);
	void SetParticle2Width(HANDLE  particle2handle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticle2Length(HANDLE  particle2handle);
	void SetParticle2Length(HANDLE  particle2handle, INTERPOLATOR_HANDLE interpolatorhandle);
	VECTOR3* GetParticle2SegmentColor1(HANDLE  particle2handle);
	void SetParticle2SegmentColor1(HANDLE  particle2handle, VECTOR3* value);
	VECTOR3* GetParticle2SegmentColor2(HANDLE  particle2handle);
	void SetParticle2SegmentColor2(HANDLE  particle2handle, VECTOR3* value);
	VECTOR3* GetParticle2SegmentColor3(HANDLE  particle2handle);
	void SetParticle2SegmentColor3(HANDLE  particle2handle, VECTOR3* value);
	VECTOR3* GetParticle2Alpha(HANDLE  particle2handle);
	void SetParticle2Alpha(HANDLE  particle2handle, VECTOR3* value);
	VECTOR3* GetParticle2ParticleScaling(HANDLE  particle2handle);
	void SetParticle2ParticleScaling(HANDLE  particle2handle, VECTOR3* value);
	VECTOR3* GetParticle2HeadLifeSpan(HANDLE  particle2handle);
	void SetParticle2HeadLifeSpan(HANDLE  particle2handle, VECTOR3* value);
	VECTOR3* GetParticle2HeadDecay(HANDLE  particle2handle);
	void SetParticle2HeadDecay(HANDLE  particle2handle, VECTOR3* value);
	VECTOR3* GetParticle2TailLifeSpan(HANDLE  particle2handle);
	void SetParticle2TailLifeSpan(HANDLE  particle2handle, VECTOR3* value);
	VECTOR3* GetParticle2TailDecay(HANDLE  particle2handle);
	void SetParticle2TailDecay(HANDLE  particle2handle, VECTOR3* value);
	int GetParticle2Rows(HANDLE  particle2handle);
	void SetParticle2Rows(HANDLE  particle2handle, int value);
	int GetParticle2Columns(HANDLE  particle2handle);
	void SetParticle2Columns(HANDLE  particle2handle, int value);
	int GetParticle2TextureId(HANDLE  particle2handle);
	void SetParticle2TextureId(HANDLE  particle2handle, int value);
	int GetParticle2PriorityPlane(HANDLE  particle2handle);
	void SetParticle2PriorityPlane(HANDLE  particle2handle, int value);
	int GetParticle2ReplaceableId(HANDLE  particle2handle);
	void SetParticle2ReplaceableId(HANDLE  particle2handle, int value);
	float GetParticle2Time(HANDLE  particle2handle);
	void SetParticle2Time(HANDLE  particle2handle, float value);
	float GetParticle2LifeSpan(HANDLE  particle2handle);
	void SetParticle2LifeSpan(HANDLE  particle2handle, float value);
	float GetParticle2TailLength(HANDLE  particle2handle);
	void SetParticle2TailLength(HANDLE  particle2handle, float value);
	bool GetParticle2SortPrimitivesFarZ(HANDLE  particle2handle);
	void SetParticle2SortPrimitivesFarZ(HANDLE  particle2handle, bool value);
	bool GetParticle2LineEmitter(HANDLE  particle2handle);
	void SetParticle2LineEmitter(HANDLE  particle2handle, bool value);
	bool GetParticle2ModelSpace(HANDLE  particle2handle);
	void SetParticle2ModelSpace(HANDLE  particle2handle, bool value);
	bool GetParticle2AlphaKey(HANDLE  particle2handle);
	void SetParticle2AlphaKey(HANDLE  particle2handle, bool value);
	bool GetParticle2Unshaded(HANDLE  particle2handle);
	void SetParticle2Unshaded(HANDLE  particle2handle, bool value);
	bool GetParticle2Unfogged(HANDLE  particle2handle);
	void SetParticle2Unfogged(HANDLE  particle2handle, bool value);
	bool GetParticle2XYQuad(HANDLE  particle2handle);
	void SetParticle2XYQuad(HANDLE  particle2handle, bool value);
	bool GetParticle2Squirt(HANDLE  particle2handle);
	void SetParticle2Squirt(HANDLE  particle2handle, bool value);
	bool GetParticle2Head(HANDLE  particle2handle);
	void SetParticle2Head(HANDLE  particle2handle, bool value);
	bool GetParticle2Tail(HANDLE  particle2handle);
	void SetParticle2Tail(HANDLE  particle2handle, bool value);
	float GetParticle2CurrentEmission(HANDLE  particle2handle);
	void SetParticle2CurrentEmission(HANDLE  particle2handle, float value);

]]

local modellib = require 'modellib.modellib'


return modellib.register_class('particle2', cdef)