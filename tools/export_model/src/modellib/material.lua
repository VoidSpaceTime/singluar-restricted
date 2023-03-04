
local cdef = [[

    HANDLE CreateMaterial();
    HANDLE CopyMaterial(HANDLE mathandle);
    HANDLE GetMaterialByModel(HANDLE modelhandle, int index);
    void CloseMaterial(HANDLE mathandle, bool del);

    int GetMaterialPriorityPlane(HANDLE mathandle);
	void SetMaterialPriorityPlane(HANDLE mathandle, int PriorityPlane);
	bool GetMaterialConstantColor(HANDLE mathandle);
	void SetMaterialConstantColor(HANDLE mathandle, bool ConstantColor);
	bool GetMaterialSortPrimitivesFarZ(HANDLE mathandle);
	void SetMaterialSortPrimitivesFarZ(HANDLE mathandle, bool SortPrimitivesFarZ);
	bool GetMaterialFullResolution(HANDLE mathandle);
    void SetMaterialFullResolution(HANDLE mathandle, bool FullResolution);


]]

local modellib = require 'modellib.modellib'

local material = modellib.register_class('material', cdef)

--材质有 多层图层
modellib.contariner(material, 'layer')

return material