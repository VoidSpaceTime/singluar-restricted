
local cdef = [[

    HANDLE CreateLayer();
	HANDLE CopyLayer(HANDLE layerhandle);
	void CloseLayer(HANDLE layerhandle, bool del);
	HANDLE GetLayerByMaterial(HANDLE mathandle, int index);


    int GetLayerFilterMode(HANDLE  layerhandle);
	void SetLayerFilterMode(HANDLE  layerhandle, int filter_mode);
	int GetLayerTextureId(HANDLE  layerhandle);
	void SetLayerTextureId(HANDLE  layerhandle, int textureid);
	int GetLayerTextureAnimationId(HANDLE  layerhandle);
	void SetLayerTextureAnimationId(HANDLE  layerhandle, int animationid);
	bool GetLayerUnshaded(HANDLE layerhandle);
	void SetLayerUnshaded(HANDLE layerhandle, bool flag);
	bool GetLayerUnfogged(HANDLE layerhandle);
	void SetLayerUnfogged(HANDLE layerhandle, bool flag);
	bool GetLayerTwoSided(HANDLE layerhandle);
	void SetLayerTwoSided(HANDLE layerhandle, bool flag);
	bool GetLayerSphereEnvironmentMap(HANDLE layerhandle);
	void SetLayerSphereEnvironmentMap(HANDLE layerhandle, bool flag);
	bool GetLayerNoDepthTest(HANDLE layerhandle);
	void SetLayerNoDepthTest(HANDLE layerhandle, bool flag);
	bool GetLayerNoDepthSet(HANDLE layerhandle);
    void SetLayerNoDepthSet(HANDLE layerhandle, bool flag);
    

    INTERPOLATOR_HANDLE GetLayerAnimatedTextureId(HANDLE  layerhandle);
	void SetLayerAnimatedTextureId(HANDLE  layerhandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetLayerAlpha(HANDLE  layerhandle);
	void SetLayerAlpha(HANDLE layerhandle, INTERPOLATOR_HANDLE interpolatorhandle);
]]


local modellib = require("modellib.modellib")

return modellib.register_class('layer', cdef)