
local lib = require 'modellib'
local module = require 'modellib.module'
local ffi = require 'ffi'
local stormlib = require 'map.stormlib'
local uni = require 'map.unicode'

require 'util.utility'
print('===============================')
print('')
print('')
print('阿7哥哥的模型提取器 一键生成模型地图 有空的可以加一下群692125060')
print('')
print('')
print('===============================')


--local mpq = stormlib.open(fs.path[[C:\Users\Administrator\Desktop\demo.w3m]])
local inputpath = arg[2]

local outpath = arg[3] or arg[2]

local max_count = arg[4] or 500

local mpq = stormlib.open(fs.path(inputpath), true)

local temp = fs.get(fs.DIR_TEMP) / "lua-model"

-- --在临时路径下创建一张文件夹地图
-- function create_map()
--     fs.remove_all(temp)
--     fs.create_directories(temp)
--     local source_path = [[resource\empty]]
--     for index, filepath in ipairs(seach_file(fs.path(source_path))) do 
--         local temp_path = temp / (filepath:string():sub(source_path:len() + 2, -1))
--         fs.create_directories(temp_path:parent_path())
--         fs.copy_file(filepath, temp_path)
--     end 
-- end 

--将文件输出到文件夹地图里
function write_file(path, buf)
    local temp_path = temp / path
    fs.create_directories(temp_path:parent_path())
    io.save(temp_path, buf)
end 



local model_list = {}

local current_index = 0

--解压文件
function export_file()
    local num = 0

    local function each_file(path)

        local name = path:filename():string()
        local ext = path:extension():string()

        if ext ~= ".mdx" then 
            return 
        end 

        num = num + 1 

        if num < current_index then 
            return 
        end 

        local buf = mpq:load_file(path:string())
        if not buf then 
            return 
        end 
        

        current_index = current_index + 1

        if current_index % max_count == 0 then --限制数量上限 提前打包一次
            --生成新物编
            make_unit_data()
            --打包地图
            pack_map()

            model_list = {}

            --创建新地图 接着继续
            create_map()
            --解压文件
            export_file()
        end 

        local filename = Md5(buf) .. '.mdx'

        --打开模型
        local model = lib.model.open_by_memory(name, buf)


        if model == nil then 
            return 
        end 

        local test = lib.model.open_by_memory(name, model:save_to_memory(filename))
        --如果保存后打不开的 也放弃
        if test == nil then 
            return 
        end 

        local bone_parent = {}
        for bone in model:each_bone() do 
            bone_parent[bone.parent_id] = bone
        end 
        --遍历丝带 如果丝带上面绑定了骨骼 则该模型是必崩的模型
        for ribbon in model:each_ribbon() do 
            if bone_parent[ribbon.object_id] then 
                print('跳过崩溃模型', filename)
                return 
            end 
        end 

        --遍历动画 如果开始帧跟结束帧是一样的 删除该动画
        for sequence in model:each_sequence() do 
            if sequence.interval.x == sequence.interval.y then 
                sequence.interval.y = sequence.interval.y + 1
                print('修正错误帧动画', filename, uni.a2u(sequence.name))
            end 
        end 

        write_file(fs.path('resource') / filename, model:save_to_memory(filename))

        --迭代器 遍历模型所有贴图
        for texture in model:each_texture() do 
            local texture_path = texture.path 
            local buf = mpq:load_file(texture_path)
            if buf then 
                write_file(fs.path('resource') / texture_path, buf)
            end 
        end 
        model:close()

        table.insert(model_list, filename)
    end 

    for index, path in ipairs(mpq:seach_file()) do 
        each_file(path)
    end 
    
end 

--构造单位物编
function make_unit_data()

local str = [[
[h%03d]
_parent = "ewsp"
-- 名字
Name = "h%03d"
-- 模型文件
file = %q
-- 高度
moveHeight = 100.0000

]]
    local buf = {}
    for index = 0, max_count do 
        local filename = model_list[index]
        if filename then 
            local s = str:format(index, index, filename)
            buf[#buf + 1] = s
        end 
    end 
    write_file(fs.path[[table\unit.ini]], table.concat(buf))
end 

pack_index = 0

function pack_map()
    
    local name = outpath:sub(1, -5)
    pack_index = pack_index + 1
    name = name .. '__' .. pack_index .. '.w3x'
   
    local out = fs.path(name)
    local cmd = string.format(
        'resource\\w3x2lni_v2.4.1\\w2l.exe obj %q',
        temp:string()
    )
    print(out:string())
    os.execute(cmd)

    fs.remove(out)
    fs.copy_file(fs.path(temp:string() .. '.w3x'), out)
end 


--创建新地图
create_map()

--解压文件
export_file()

--生成新物编
make_unit_data()

--打包地图
pack_map()

print('finish')