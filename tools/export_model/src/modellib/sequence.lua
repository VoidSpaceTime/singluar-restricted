
local cdef = [[

    HANDLE CreateSequence();
	HANDLE CopySequence(HANDLE seqhandle);
	void CloseSequence(HANDLE seqhandle, bool del);
	HANDLE GetSequenceByModel(HANDLE modelhandle, int index);

    
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

]]


local modellib = require 'modellib.modellib'

return modellib.register_class('sequence', cdef)