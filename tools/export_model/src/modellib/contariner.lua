
local cdef = [[

    //贴图容器
    int GetModelTextureSize(HANDLE handle);
    bool AddModelTexture(HANDLE modelhandle, HANDLE texhandle);
    bool RemoveModelTexture(HANDLE modelhandle, HANDLE  texhandle);

    //材质容器
    int GetModelMaterialSize(HANDLE modelhandle);
    bool AddModelMaterial(HANDLE modelhandle, HANDLE mathandle);
    bool RemoveModelMaterial(HANDLE modelhandle, HANDLE  mathandle);


    //材质图层容器
	int GetMaterialLayerSize(HANDLE mathandle);
	bool AddMaterialLayer(HANDLE mathandle, HANDLE layerhandle);
	bool RemoveMaterialLayer(HANDLE mathandle, HANDLE  layerhandle);


    //镜头容器
    
	int GetModelCameraSize(HANDLE modelhandle);
	bool AddModelCamera(HANDLE modelhandle, HANDLE camhandle);
    bool RemoveModelCamera(HANDLE modelhandle, HANDLE  camhandle);
    
    //动作容器
    int GetModelSequenceSize(HANDLE modelhandle);
	bool AddModelSequence(HANDLE modelhandle, HANDLE seqhandle);
    bool RemoveModelSequence(HANDLE modelhandle, HANDLE  seqhandle);

    //节点容器
    int GetModelNodeSize(HANDLE modelhandle);
	bool AddModelNode(HANDLE modelhandle, HANDLE nodehandle);
    bool RemoveModelNode(HANDLE modelhandle, HANDLE  nodehandle);
    
    //骨骼容器
    int GetModelBoneSize(HANDLE modelhandle);
	bool AddModelBone(HANDLE modelhandle, HANDLE bonehandle);
    bool RemoveModelBone(HANDLE modelhandle, HANDLE  bonehandle);

    //附加点容器
    int GetModelAttachmentSize(HANDLE modelhandle);
	bool AddModelAttachment(HANDLE modelhandle, HANDLE attachmenthandle);
    bool RemoveModelAttachment(HANDLE modelhandle, HANDLE  attachmenthandle);
    
    //碰撞容器
    int GetModelCollisionshapeSize(HANDLE modelhandle);
	bool AddModelCollisionshape(HANDLE modelhandle, HANDLE collisionshapehandle);
    bool RemoveModelCollisionshape(HANDLE modelhandle, HANDLE  collisionshapehandle);
    

    //碰撞盒子的顶点容器
    int GetCollisionshapeVertexSize(HANDLE collisionshapehandle);
	bool AddCollisionshapVertex(HANDLE collisionshapehandle, VECTOR3* vec3);
    bool RemoveCollisionshapVertex(HANDLE collisionshapehandle, int index);

    //事件容器
    int GetModelEventobjectSize(HANDLE modelhandle);
	bool AddModelEventobject(HANDLE modelhandle, HANDLE eventobjecthandle);
    bool RemoveModelEventobject(HANDLE modelhandle, HANDLE  eventobjecthandle);
    
    //事件监听id容器
    int GetEventTrackByEventobject(HANDLE eventobjecthandle, int index);
	int GetEventobjectEventTrackSize(HANDLE eventobjecthandle);
	bool AddEventobjectEventTrack(HANDLE eventobjecthandle, int value);
	bool RemoveEventobjectEventTrack(HANDLE eventobjecthandle, int index);


    //帮助体容器
    int GetModelHelperSize(HANDLE modelhandle);
	bool AddModelHelper(HANDLE modelhandle, HANDLE helperhandle);
	bool RemoveModelHelper(HANDLE modelhandle, HANDLE  helperhandle);

    //高光
    int GetModelLightSize(HANDLE modelhandle);
	bool AddModelLight(HANDLE modelhandle, HANDLE lighthandle);
    bool RemoveModelLight(HANDLE modelhandle, HANDLE  lighthandle);
    
    //粒子
    int GetModelParticleSize(HANDLE modelhandle);
	bool AddModelParticle(HANDLE modelhandle, HANDLE particlehandle);
    bool RemoveModelParticle(HANDLE modelhandle, HANDLE  particlehandle);
    
    //粒子2
    int GetModelParticle2Size(HANDLE modelhandle);
	bool AddModelParticle2(HANDLE modelhandle, HANDLE particle2handle);
	bool RemoveModelParticle2(HANDLE modelhandle, HANDLE  particle2handle);

    //丝带容器
    int GetModelRibbonSize(HANDLE modelhandle);
	bool AddModelRibbon(HANDLE modelhandle, HANDLE ribbonhandle);
	bool RemoveModelRibbon(HANDLE modelhandle, HANDLE  ribbonhandle);
]]


local module = require 'modellib.module'

local modellib = require 'modellib.modellib'


--给模块注册容器 
--class: object  model|texture|materiable 这些模块 
--child_name: string 子模块名  
--[[
    --例如
    modellib.contariner(modellib.model, 'texture') 
    会生成一套  容器模板
        model:get_texture_by_model(index):texture
        model:get_texture_size():int
        model:add_texture(texture):bool
        model:remove_texture(texture):bool
        model:clear_texture():bool
        model:each_texture() --iterator

]]

function modellib.contariner(class, child_name)
    local class_name = class.type

    local class_name2 = class_name:sub(1, 1):upper() .. class_name:sub(2, class_name:len()) --首字母转大写

    local child_name2 = child_name:sub(1, 1):upper() .. child_name:sub(2, child_name:len()) --首字母转大写
    
    local name = class_name2 .. child_name2

    local get_child = 'get_' .. child_name
    local get_child_size = 'get_' .. child_name .. '_size'

    --查询容器尺寸
    class[get_child_size] = function (self)
        return module['Get'.. name .. 'Size'](self.handle)
    end 

    --获取容器指定索引元素
    class[get_child] = function (self, index)
        local object = modellib[child_name].open(self, index)
        self:contariner_add(object, index)
        return object
    end 


    --为容器添加新元素
    class['add_' .. child_name] = function (self, object)
        if object.owner then 
            print('对象已经有所属模型 需要new 或者 copy一个新的对象', debug.traceback())
            return
        end 
        object.owner = self

        local bool = module['Add'.. name](self.handle, object.handle)

        if bool then 
            local index = self[get_child_size](self) - 1
            self:contariner_add(object, index)
        end 
        return bool
    end 

    --为容器删除指定元素
    class['remove_' .. child_name] = function (self, object)
        if object.owner ~= self then 
            return 
        end 
        local bool = module['Remove'.. name](self.handle, object.handle)
        self:contariner_remove(object)
        object:close()
    end


    --容器迭代器
    class['each_' .. child_name] = function (self)
        local size = self[get_child_size](self) 

        local result = {}
        for i = 0, size - 1 do 
            table.insert(result,  self[get_child](self, i))
        end 

        local n = 0
    	return function (t, v)
    		n = n + 1
    		return t[n]
    	end, result
    end 

    --清空容器
    class['clear_' .. child_name] = function (self)
        for object in self['each_' .. child_name](self) do 
            self['remove_' .. child_name](self, object)
        end 
    end


    
    function class:contariner_add(object)
        if object == nil or object.type == nil then 
            return 
        end 
    
        local contariner = rawget(self,object.type .. '_contariner')
        if contariner == nil then 
            contariner = {}
            self[object.type .. '_contariner'] = contariner
        end 
    
        contariner[object] = true
    end
    
    function class:contariner_remove(object)
        if object == nil or object.type == nil then 
            return 
        end 
    
        local contariner = rawget(self,object.type .. '_contariner')
        if contariner == nil then 
            return 
        end 
        contariner[object] = nil
    end

    local function pairs2(self, key)
        return function (self, key)
             return next(self, key)
         end, self, nil
     end

    local close = class.close
    if class.real_close == nil then 
        class.real_close = close
        function class:close()
            close(self)

            for key, value in pairs2(self) do 
                if key:find('_contariner') and type(value) == 'table' then 
                    for object in pairs2(value) do 
                        object:close()
                    end 
                end
                self[key] = nil
            end 
        end 
    end
end 

