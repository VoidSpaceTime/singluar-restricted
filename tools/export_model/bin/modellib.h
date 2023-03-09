//--[[
#ifdef MODELLIB_EXPORTS 
	#include "stdafx.h"
#endif // MODELLIB_EXPORTS

extern "C" {
//]]

	typedef void* HANDLE;
	typedef void* INTERPOLATOR_HANDLE;

	struct VECTOR2 {
		float x, y;
	};

	struct VECTOR3 {
		float x, y, z;
	};

	struct VECTOR4 {
		float x, y, z, w;
	};

//--[[
#ifdef MODELLIB_EXPORTS 
#else
//]]
	struct EXTENT
	{
		float radius;
		VECTOR3 min;
		VECTOR3 max;
	};

	struct SEQUENCE_TIME
	{
		int time;
		int interval_start;
		int interval_end;
	};


	struct INTERPOLATOR_NODE
	{
		int time;
		VECTOR4 vector;
		VECTOR4 in_tan;
		VECTOR4 out_tan;
	};

//--[[
#endif // MODELLIB_EXPORTS
//]]
	const char* Md5(const char* buffer, size_t size);
	unsigned int StringHash(const char* str);


	//config
	bool InitMpqResource();
	bool LoadAllReplaceableTextures();



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


	//model
	HANDLE CreateModel();
	HANDLE OpenModel(const char* path);
	HANDLE OpenModelByMemory(const char* name, const char* moemory, int size);
	const char* SaveModelToMemory(HANDLE handle, const char* path, int* size);
	void ClearReturnBuffer();

	bool SaveModel(HANDLE handle, const char* path);
	void CloseModel(HANDLE handle, bool del);
	HANDLE CopyModel(HANDLE handle);

	void ModelCalculateBoundsRadius(HANDLE handle);


	//Ä£ÐÍÈÝÆ÷
	int GetModelTextureSize(HANDLE modelhandle);
	bool AddModelTexture(HANDLE modelhandle, HANDLE texhandle);
	bool RemoveModelTexture(HANDLE modelhandle, HANDLE  texhandle);

	int GetModelMaterialSize(HANDLE modelhandle);
	bool AddModelMaterial(HANDLE modelhandle, HANDLE mathandle);
	bool RemoveModelMaterial(HANDLE modelhandle, HANDLE  mathandle);





	//texture
	HANDLE CreateTexture();
	HANDLE CopyTexture(HANDLE texhandle);
	HANDLE GetTextureByModel(HANDLE modelhandle, int index);



	void CloseTexture(HANDLE texhandle, bool del);
	const char* GetTexturePath(HANDLE texhandle);
	void SetTexturePath(HANDLE texhandle, const char* path);
	bool GetTextureWrapWidth(HANDLE texhandle);
	void SetTextureWrapWidth(HANDLE texhandle, bool flag);
	bool GetTextureWrapHeight(HANDLE texhandle);
	void SetTextureWrapHeight(HANDLE texhandle, bool flag);
	int GetTextureReplaceableId(HANDLE texhandle);
	void SetTextureReplaceableId(HANDLE texhandle, int id);
	int GetTextureWidth(HANDLE texhandle);
	int GetTextureHeight(HANDLE texhandle);


	//material
	HANDLE CreateMaterial();
	HANDLE CopyMaterial(HANDLE mathandle);
	void CloseMaterial(HANDLE mathandle, bool del);
	HANDLE GetMaterialByModel(HANDLE modelhandle, int index);

	int GetMaterialPriorityPlane(HANDLE mathandle);
	void SetMaterialPriorityPlane(HANDLE mathandle, int PriorityPlane);
	bool GetMaterialConstantColor(HANDLE mathandle);
	void SetMaterialConstantColor(HANDLE mathandle, bool ConstantColor);
	bool GetMaterialSortPrimitivesFarZ(HANDLE mathandle);
	void SetMaterialSortPrimitivesFarZ(HANDLE mathandle, bool SortPrimitivesFarZ);
	bool GetMaterialFullResolution(HANDLE mathandle);
	void SetMaterialFullResolution(HANDLE mathandle, bool FullResolution);


	//²ÄÖÊÍ¼²ãÈÝÆ÷
	int GetMaterialLayerSize(HANDLE mathandle);
	bool AddMaterialLayer(HANDLE mathandle, HANDLE layerhandle);
	bool RemoveMaterialLayer(HANDLE mathandle, HANDLE  layerhandle);


	HANDLE CreateLayer();
	HANDLE CopyLayer(HANDLE layerhandle);
	void CloseLayer(HANDLE layerhandle, bool del);
	HANDLE GetLayerByMaterial(HANDLE mathandle, int index);


	int GetLayerFilterMode(HANDLE  layerhandle);
	void SetLayerFilterMode(HANDLE  layerhandle, int filter_mode);

	INTERPOLATOR_HANDLE GetLayerAnimatedTextureId(HANDLE  layerhandle);
	void SetLayerAnimatedTextureId(HANDLE  layerhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetLayerAlpha(HANDLE  layerhandle);
	void SetLayerAlpha(HANDLE layerhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	int GetLayerTextureId(HANDLE  layerhandle);
	void SetLayerTextureId(HANDLE  layerhandle, int textureid);
	int GetLayerTextureAnimationId(HANDLE  layerhandle);
	void SetLayerTextureAnimationId(HANDLE  layerhandle, int animationid);
	bool GetLayerUnshaded(HANDLE  layerhandle);
	void SetLayerUnshaded(HANDLE  layerhandle, bool flag);
	bool GetLayerUnfogged(HANDLE  layerhandle);
	void SetLayerUnfogged(HANDLE  layerhandle, bool flag);
	bool GetLayerTwoSided(HANDLE  layerhandle);
	void SetLayerTwoSided(HANDLE  layerhandle, bool flag);
	bool GetLayerSphereEnvironmentMap(HANDLE  layerhandle);
	void SetLayerSphereEnvironmentMap(HANDLE  layerhandle, bool flag);
	bool GetLayerNoDepthTest(HANDLE  layerhandle);
	void SetLayerNoDepthTest(HANDLE  layerhandle, bool flag);
	bool GetLayerNoDepthSet(HANDLE  layerhandle);
	void SetLayerNoDepthSet(HANDLE  layerhandle, bool flag);





	HANDLE CreateCamera();
	HANDLE CopyCamera(HANDLE camhandle);
	void CloseCamera(HANDLE camhandle, bool del);
	HANDLE GetCameraByModel(HANDLE modelhandle, int index);

	int GetModelCameraSize(HANDLE modelhandle);
	bool AddModelCamera(HANDLE modelhandle, HANDLE camhandle);
	bool RemoveModelCamera(HANDLE modelhandle, HANDLE  camhandle);



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


	HANDLE CreateSequence();
	HANDLE CopySequence(HANDLE seqhandle);
	void CloseSequence(HANDLE seqhandle, bool del);
	HANDLE GetSequenceByModel(HANDLE modelhandle, int index);
	int GetModelSequenceSize(HANDLE modelhandle);
	bool AddModelSequence(HANDLE modelhandle, HANDLE seqhandle);
	bool RemoveModelSequence(HANDLE modelhandle, HANDLE  seqhandle);



	const char* GetSequenceName(HANDLE  seqhandle);
	void SetSequenceName(HANDLE  seqhandle, const char* name);
	float GetSequenceRarity(HANDLE  seqhandle);
	void SetSequenceRarity(HANDLE  seqhandle, float value);
	float GetSequenceMoveSpeed(HANDLE  seqhandle);
	void SetSequenceMoveSpeed(HANDLE  seqhandle, float value);
	bool GetSequenceNonLooping(HANDLE  seqhandle);
	void SetSequenceNonLooping(HANDLE  seqhandle, bool value);
	VECTOR2* GetSequenceInterval(HANDLE  seqhandle);
	void SetSequenceInterval(HANDLE  seqhandle, VECTOR2* value);
	EXTENT* GetSequenceExtent(HANDLE  seqhandle);
	void SetSequenceExtent(HANDLE  seqhandle, EXTENT* value);





	HANDLE CreateBone();
	HANDLE CopyBone(HANDLE bonehandle);
	void CloseBone(HANDLE bonehandle, bool del);
	HANDLE GetBoneByModel(HANDLE modelhandle, int index);
	int GetModelBoneSize(HANDLE modelhandle);
	bool AddModelBone(HANDLE modelhandle, HANDLE bonehandle);
	bool RemoveModelBone(HANDLE modelhandle, HANDLE  bonehandle);


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




	HANDLE CreateAttachment();
	HANDLE CopyAttachment(HANDLE attachmenthandle);
	void CloseAttachment(HANDLE attachmenthandle, bool del);
	HANDLE GetAttachmentByModel(HANDLE modelhandle, int index);
	int GetModelAttachmentSize(HANDLE modelhandle);
	bool AddModelAttachment(HANDLE modelhandle, HANDLE attachmenthandle);
	bool RemoveModelAttachment(HANDLE modelhandle, HANDLE  attachmenthandle);


	const char* GetAttachmentName(HANDLE  attachmenthandle);
	void SetAttachmentName(HANDLE  attachmenthandle, const char* name);
	int GetAttachmentObjectId(HANDLE  attachmenthandle);
	void SetAttachmentObjectId(HANDLE  attachmenthandle, int value);
	int GetAttachmentParentId(HANDLE  attachmenthandle);
	void SetAttachmentParentId(HANDLE  attachmenthandle, int value);
	INTERPOLATOR_HANDLE GetAttachmentTranslation(HANDLE  attachmenthandle);
	void SetAttachmentTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE attachmenthandle);
	INTERPOLATOR_HANDLE GetAttachmentRotation(HANDLE  attachmenthandle);
	void SetAttachmentRotation(HANDLE camhandle, INTERPOLATOR_HANDLE attachmenthandle);
	INTERPOLATOR_HANDLE GetAttachmentScaling(HANDLE  attachmenthandle);
	void SetAttachmentScaling(HANDLE camhandle, INTERPOLATOR_HANDLE attachmenthandle);
	bool GetAttachmentDontInheritTranslation(HANDLE  attachmenthandle);
	void SetAttachmentDontInheritTranslation(HANDLE  attachmenthandle, bool value);
	bool GetAttachmentDontInheritRotation(HANDLE  attachmenthandle);
	void SetAttachmentDontInheritRotation(HANDLE  attachmenthandle, bool value);
	bool GetAttachmentDontInheritScaling(HANDLE  attachmenthandle);
	void SetAttachmentDontInheritScaling(HANDLE  attachmenthandle, bool value);
	bool GetAttachmentBillboarded(HANDLE  attachmenthandle);
	void SetAttachmentBillboarded(HANDLE  attachmenthandle, bool value);
	bool GetAttachmentBillboardedLockX(HANDLE  attachmenthandle);
	void SetAttachmentBillboardedLockX(HANDLE  attachmenthandle, bool value);
	bool GetAttachmentBillboardedLockY(HANDLE  attachmenthandle);
	void SetAttachmentBillboardedLockY(HANDLE  attachmenthandle, bool value);
	bool GetAttachmentBillboardedLockZ(HANDLE  attachmenthandle);
	void SetAttachmentBillboardedLockZ(HANDLE  attachmenthandle, bool value);
	bool GetAttachmentCameraAnchored(HANDLE  attachmenthandle);
	void SetAttachmentCameraAnchored(HANDLE  attachmenthandle, bool value);
	VECTOR3* GetAttachmentPivotPoint(HANDLE  attachmenthandle);
	void SetAttachmentPivotPoint(HANDLE  attachmenthandle, VECTOR3* value);
	int GetAttachmentType(HANDLE  attachmenthandle);
	void SetAttachmentType(HANDLE  attachmenthandle, int value);



	const char* GetAttachmentPath(HANDLE  attachmenthandle);
	void SetAttachmentPath(HANDLE  attachmenthandle, const char* value);
	INTERPOLATOR_HANDLE GetAttachmentVisibility(HANDLE  attachmenthandle);
	void SetAttachmentVisibility(HANDLE  attachmenthandle, INTERPOLATOR_HANDLE interpolatorhandle);
	int GetAttachmentId(HANDLE  attachmenthandle);
	void SetAttachmentId(HANDLE  attachmenthandle, int value);





	HANDLE CreateCollisionshape();
	HANDLE CopyCollisionshape(HANDLE collisionshapehandle);
	void CloseCollisionshape(HANDLE collisionshapehandle, bool del);
	HANDLE GetCollisionshapeByModel(HANDLE modelhandle, int index);
	int GetModelCollisionshapeSize(HANDLE modelhandle);
	bool AddModelCollisionshape(HANDLE modelhandle, HANDLE collisionshapehandle);
	bool RemoveModelCollisionshape(HANDLE modelhandle, HANDLE  collisionshapehandle);


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
	int GetCollisionshapeVertexSize(HANDLE collisionshapehandle);
	bool AddCollisionshapVertex(HANDLE collisionshapehandle, VECTOR3* vec3);
	bool RemoveCollisionshapVertex(HANDLE collisionshapehandle, int index);






	HANDLE CreateEventobject();
	HANDLE CopyEventobject(HANDLE eventobjecthandle);
	void CloseEventobject(HANDLE eventobjecthandle, bool del);
	HANDLE GetEventobjectByModel(HANDLE modelhandle, int index);
	int GetModelEventobjectSize(HANDLE modelhandle);
	bool AddModelEventobject(HANDLE modelhandle, HANDLE eventobjecthandle);
	bool RemoveModelEventobject(HANDLE modelhandle, HANDLE  eventobjecthandle);


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





	int GetEventTrackByEventobject(HANDLE eventobjecthandle, int index);
	int GetEventobjectEventTrackSize(HANDLE eventobjecthandle);
	bool AddEventobjectEventTrack(HANDLE eventobjecthandle, int value);
	bool RemoveEventobjectEventTrack(HANDLE eventobjecthandle, int index);





	HANDLE CreateHelper();
	HANDLE CopyHelper(HANDLE helperhandle);
	void CloseHelper(HANDLE helperhandle, bool del);
	HANDLE GetHelperByModel(HANDLE modelhandle, int index);
	int GetModelHelperSize(HANDLE modelhandle);
	bool AddModelHelper(HANDLE modelhandle, HANDLE helperhandle);
	bool RemoveModelHelper(HANDLE modelhandle, HANDLE  helperhandle);


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





	HANDLE CreateLight();
	HANDLE CopyLight(HANDLE lighthandle);
	void CloseLight(HANDLE lighthandle, bool del);
	HANDLE GetLightByModel(HANDLE modelhandle, int index);
	int GetModelLightSize(HANDLE modelhandle);
	bool AddModelLight(HANDLE modelhandle, HANDLE lighthandle);
	bool RemoveModelLight(HANDLE modelhandle, HANDLE  lighthandle);


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





	HANDLE CreateParticle();
	HANDLE CopyParticle(HANDLE particlehandle);
	void CloseParticle(HANDLE particlehandle, bool del);
	HANDLE GetParticleByModel(HANDLE modelhandle, int index);
	int GetModelParticleSize(HANDLE modelhandle);
	bool AddModelParticle(HANDLE modelhandle, HANDLE particlehandle);
	bool RemoveModelParticle(HANDLE modelhandle, HANDLE  particlehandle);


	const char* GetParticleName(HANDLE  particlehandle);
	void SetParticleName(HANDLE  particlehandle, const char* name);
	int GetParticleObjectId(HANDLE  particlehandle);
	void SetParticleObjectId(HANDLE  particlehandle, int value);
	int GetParticleParentId(HANDLE  particlehandle);
	void SetParticleParentId(HANDLE  particlehandle, int value);
	INTERPOLATOR_HANDLE GetParticleTranslation(HANDLE  particlehandle);
	void SetParticleTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE particlehandle);
	INTERPOLATOR_HANDLE GetParticleRotation(HANDLE  particlehandle);
	void SetParticleRotation(HANDLE camhandle, INTERPOLATOR_HANDLE particlehandle);
	INTERPOLATOR_HANDLE GetParticleScaling(HANDLE  particlehandle);
	void SetParticleScaling(HANDLE camhandle, INTERPOLATOR_HANDLE particlehandle);
	bool GetParticleDontInheritTranslation(HANDLE  particlehandle);
	void SetParticleDontInheritTranslation(HANDLE  particlehandle, bool value);
	bool GetParticleDontInheritRotation(HANDLE  particlehandle);
	void SetParticleDontInheritRotation(HANDLE  particlehandle, bool value);
	bool GetParticleDontInheritScaling(HANDLE  particlehandle);
	void SetParticleDontInheritScaling(HANDLE  particlehandle, bool value);
	bool GetParticleBillboarded(HANDLE  particlehandle);
	void SetParticleBillboarded(HANDLE  particlehandle, bool value);
	bool GetParticleBillboardedLockX(HANDLE  particlehandle);
	void SetParticleBillboardedLockX(HANDLE  particlehandle, bool value);
	bool GetParticleBillboardedLockY(HANDLE  particlehandle);
	void SetParticleBillboardedLockY(HANDLE  particlehandle, bool value);
	bool GetParticleBillboardedLockZ(HANDLE  particlehandle);
	void SetParticleBillboardedLockZ(HANDLE  particlehandle, bool value);
	bool GetParticleCameraAnchored(HANDLE  particlehandle);
	void SetParticleCameraAnchored(HANDLE  particlehandle, bool value);
	VECTOR3* GetParticlePivotPoint(HANDLE  particlehandle);
	void SetParticlePivotPoint(HANDLE  particlehandle, VECTOR3* value);
	int GetParticleType(HANDLE  particlehandle);
	void SetParticleType(HANDLE  particlehandle, int value);

	INTERPOLATOR_HANDLE GetParticleEmissionRate(HANDLE  particlehandle);
	void SetParticleEmissionRate(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleGravity(HANDLE  particlehandle);
	void SetParticleGravity(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleLongitude(HANDLE  particlehandle);
	void SetParticleLongitude(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleLatitude(HANDLE  particlehandle);
	void SetParticleLatitude(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleVisibility(HANDLE  particlehandle);
	void SetParticleVisibility(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleParticleLifeSpan(HANDLE  particlehandle);
	void SetParticleParticleLifeSpan(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleParticleInitialVelocity(HANDLE  particlehandle);
	void SetParticleParticleInitialVelocity(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	const char* GetParticleParticleFileName(HANDLE  particlehandle);
	void SetParticleParticleFileName(HANDLE  particlehandle, const char* name);
	bool GetParticleEmitterUsesMdl(HANDLE  particlehandle);
	void SetParticleEmitterUsesMdl(HANDLE  particlehandle, bool value);
	bool GetParticleEmitterUsesTga(HANDLE  particlehandle);
	void SetParticleEmitterUsesTga(HANDLE  particlehandle, bool value);
	bool GetParticleHasBug(HANDLE  particlehandle);
	void SetParticleHasBug(HANDLE  particlehandle, bool value);



	HANDLE CreateParticle2();
	HANDLE CopyParticle2(HANDLE particle2handle);
	void CloseParticle2(HANDLE particle2handle, bool del);
	HANDLE GetParticle2ByModel(HANDLE modelhandle, int index);
	int GetModelParticle2Size(HANDLE modelhandle);
	bool AddModelParticle2(HANDLE modelhandle, HANDLE particle2handle);
	bool RemoveModelParticle2(HANDLE modelhandle, HANDLE  particle2handle);


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





	HANDLE CreateRibbon();
	HANDLE CopyRibbon(HANDLE ribbonhandle);
	void CloseRibbon(HANDLE ribbonhandle, bool del);
	HANDLE GetRibbonByModel(HANDLE modelhandle, int index);
	int GetModelRibbonSize(HANDLE modelhandle);
	bool AddModelRibbon(HANDLE modelhandle, HANDLE ribbonhandle);
	bool RemoveModelRibbon(HANDLE modelhandle, HANDLE  ribbonhandle);


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

//--[[
}
//]]