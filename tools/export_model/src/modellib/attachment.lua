
local cdef = [[

	HANDLE CreateAttachment();
	HANDLE CopyAttachment(HANDLE attachmenthandle);
	void CloseAttachment(HANDLE attachmenthandle, bool del);
	HANDLE GetAttachmentByModel(HANDLE modelhandle, int index);



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
]]

local modellib = require 'modellib.modellib'


return modellib.register_class('attachment', cdef)