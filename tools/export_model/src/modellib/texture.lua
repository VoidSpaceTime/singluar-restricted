
local cdef = [[

    

    HANDLE CreateTexture();
    HANDLE CopyTexture(HANDLE texhandle);
    void CloseTexture(HANDLE texhandle, bool del);
    HANDLE GetTextureByModel(HANDLE modelhandle, int index);

    
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
]]

local modellib = require 'modellib.modellib'

return modellib.register_class('texture', cdef)