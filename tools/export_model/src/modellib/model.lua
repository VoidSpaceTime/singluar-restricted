
local cdef = [[

    bool InitMpqResource();
    bool LoadAllReplaceableTextures();
    const char* EncodeBase64(const char* buffer, int size, int* ret);
	const char* DecodeBase64(const char* buffer, int size, int* ret);
    const char* Md5(const char* buffer, size_t size);

	HANDLE CreateModel();
    HANDLE OpenModel(const char* FileName);
    bool SaveModel(HANDLE handle, const char* path);
	void CloseModel(HANDLE handle, bool del);
    HANDLE CopyModel(HANDLE handle);

    void ModelCalculateBoundsRadius(HANDLE handle);
    
    HANDLE OpenModelByMemory(const char* path, const char* memory, int size);
    const char* SaveModelToMemory(HANDLE handle, const char* path, int* size);
]]



local modellib = require 'modellib.modellib'

local module = require("modellib.module")

local model = modellib.register_class('model', cdef)
module.InitMpqResource()

module.LoadAllReplaceableTextures()

function model.open(path)
	local handle = module.OpenModel(path)
    if handle == module.object2c['nil']() then
        local file_type = path:sub(path:len() - 3,path:len()):lower()
        if file_type == '.mdl' then
            path = path:sub(1,path:len() - 4) .. '.mdx'
            handle = module.OpenModel(path)
        elseif file_type == '.mdx' then
            path = path:sub(1,path:len() - 4) .. '.mdl'
            handle = module.OpenModel(path)
        end
    end

	if handle == module.object2c['nil']() then
		return
	end

	return setmetatable({handle = handle, path = path}, model)
end

function model.encode_base64(memory)
    local int = module.object2c['int*'](0)
    local buffer = module.EncodeBase64(memory, memory:len(), int)
    local memory = module.c2object['string'](buffer, module.c2object['int*'](int))
    module.ClearReturnBuffer()
    return memory
end 

function model.decode_base64(memory)
    local int = module.object2c['int*'](0)
    local buffer = module.DecodeBase64(memory, memory:len(), int)
    local memory = module.c2object['string'](buffer, module.c2object['int*'](int))
    module.ClearReturnBuffer()
    return memory
end 

function Md5(memory)    
    return module.c2object['string'](module.Md5(memory, memory:len()))
end 


--@path: string 'namme.mdx' | 'name.mdl'
--@memory: string  model data
function model.open_by_memory(path, memory)
    local handle = module.OpenModelByMemory(path, memory, memory:len())
    if handle == module.object2c['nil']() then
		return
	end
	return setmetatable({handle = handle, path = path}, model)
end

function model:calculate_bounds_radius()
    module.ModelCalculateBoundsRadius(self.handle)
end 

--保存模型
function model:save(path)
    module.SaveModel(self.handle, path)
end 

--@path: string 'name.mdx' | 'name.mdl'
--@return string  当后缀是mdx 时 返回的是二进制数据  后缀是mdl 时 返回的是文本模型数据
function model:save_to_memory(path)
    local int = module.object2c['int*'](0)
    local buffer = module.SaveModelToMemory(self.handle, path, int)
    local memory = module.c2object['string'](buffer, module.c2object['int*'](int))
    module.ClearReturnBuffer()
    return memory
end 

--另存为ui模型
function model:make_ui_model()
    --遍历所有材质图层 将图层改为无阴影
    for material in self:each_material() do 
        for layer in material:each_layer() do 
            layer.unshaded = true
        end
    end 

    --粒子发射器缩小1000倍
    for particle2 in self:each_particle2() do 
        local scaling = particle2.particle_scaling
        scaling.x = scaling.x / 2000
        scaling.y = scaling.y / 2000
        scaling.z = scaling.z / 2000
    end

    --所有动画的最小最大范围改为0
    for sequence in self:each_sequence() do 
        sequence.extent = {
            min = {0, 0, 0},
            max = {0, 0, 0}
        }
    end

    --删除所有镜头
    self:clear_camera()

    --重算点范围
    self:calculate_bounds_radius()

    return self
end


function model:add_exception(index)
    index = index or 1 

    --添加一个新的贴图
    local texture = modellib.texture.new()
    texture.replaceable_id = 1 
     --贴图添加给模型
    self:add_texture(texture)

    --创建新的材质
    local material = modellib.material.new()
    --创建新的图层
    local layer = modellib.layer.new()
    --图层绑定贴图
    layer.texture_id = self:get_texture_size() - 1
    
    --图层添加给材质
    material:add_layer(layer)
    --材质添加给模型
    self:add_material(material)

    local material_id = self:get_material_size() - 1
    local function add_ribbon(parent_id)
        --创建一个丝带
        local ribbon = modellib.ribbon.new()
        --丝带绑定材质
        ribbon.material_id = material_id
        ribbon.rows = 9999
        ribbon.columns = 9999
        if index == 1 then 
            ribbon.emission_rate = 99
            ribbon.life_span = 99999998430675.0*1000
            ribbon.gravity = 99999998430675.0*1000
        elseif index == 2 then 
            ribbon.emission_rate = 9999
            ribbon.life_span = 10000000000
            ribbon.gravity = 100000000000
        end 

        if parent_id then 
            ribbon.parent_id = parent_id
        end 
        --丝带添加给模型
        self:add_ribbon(ribbon)
        
        return ribbon
    end 

    --给所有骨骼加上一个丝带
    for bone in self:each_bone() do 
        local ribbon = add_ribbon(bone.object_id)
        ribbon.name = bone.name
    end
   
    add_ribbon()
end 

function model:remove_exception()
    local material_id 

    for ribbon in self:each_ribbon() do 
        if ribbon.rows == 9999 and ribbon.columns == 9999 then 
            material_id = ribbon.material_id
            --删除丝带
            self:remove_ribbon(ribbon)
        end
    end 

    if material_id then
        --把添加的 材质 图层 贴图都删掉
        local material = self:get_material(material_id)
        if material then 
            local layer = material:get_layer(0)
            if layer then 
                local texture = self:get_texture(layer.texture_id)
                if texture then 
                    self:remove_texture(texture)
                end
                material:remove_layer(layer)
            end
            self:remove_material(material)
        end 
    end
end

function model:add_editor_exception()
    local ribbon = modellib.ribbon.new()
    ribbon.alpha:from_string [[
        0:0
        1:1
    ]]
    ribbon.alpha:set_data_type('SCALAR')
    ribbon.alpha:set_type('LINEAR')
    ribbon.has_bug = true
    ribbon.name = '007加密软件'
    self:add_ribbon(ribbon)


    local particle = modellib.particle.new()
    local emission_rate = particle.emission_rate
    emission_rate:from_string [[
        0:0
        1:1
    ]]
    emission_rate:set_data_type('SCALAR')
    emission_rate:set_type('LINEAR')
    particle.has_bug = true
    particle.name = '007加密软件'
    self:add_particle(particle)
end 

function model:remove_editor_exception()
    for ribbon in self:each_ribbon() do 
        if ribbon.has_bug then
            if ribbon.name == '007加密软件' then  
                self:remove_ribbon(ribbon) 
            else 
                ribbon.has_bug = false
            end
        end
    end 

    for particle in self:each_particle() do 
        if particle.has_bug then
            if particle.name == '007加密软件' then  
                self:remove_particle(particle) 
            else 
                particle.has_bug = false
            end
        end
    end 
end 


modellib.contariner(model, 'texture') --注册贴图容器
modellib.contariner(model, 'material') --注册材质容器
modellib.contariner(model, 'camera') --注册镜头容器
modellib.contariner(model, 'sequence') --注册动作容器

modellib.contariner(model, 'attachment') --注册附加点容器
modellib.contariner(model, 'bone') --注册骨骼容器
modellib.contariner(model, 'collisionshape') --注册碰撞容器
modellib.contariner(model, 'eventobject') --注册事件容器
modellib.contariner(model, 'helper') --注册帮助体容器
modellib.contariner(model, 'light') --注册光照容器
modellib.contariner(model, 'particle') --注册粒子容器
modellib.contariner(model, 'particle2') --注册粒子2容器
modellib.contariner(model, 'ribbon') --注册丝带容器

return model
