local lib = require 'modellib'
local module = require 'modellib.module'
local ffi = require 'ffi'
local stormlib = require 'map.stormlib'
local uni = require 'map.unicode'

require 'util.utility'
require "filesystem"

string = string or {}

-- 是否中文
function isContainChinese(str)
    local utf8_len = #str
    local len = string.len(str)
    if utf8_len ~= len then
        return true
    end
    for i = 1, len do
        local byte = string.byte(str, i)
        if byte > 127 then
            return true
        end
    end
    return false
end

-- 替换中文
function replaceChinese(str)
    local new_str = ""
    for i = 1, string.len(str) do
        local byte = string.byte(str, i)
        if byte > 127 then
            new_str = new_str .. string.char(math.random(97, 122))
        else
            new_str = new_str .. string.char(byte)
        end
    end
    return new_str
end

--- 替换字符串
---@param str string
---@return string
function string.replace(str, pattern, repl)
    local res = string.gsub(str, pattern, repl)
    return res
end

function ergodic(v)
    for key, value in pairs(v) do
        print(key, value)
    end
end

local inputpath = arg[2]
local outpath = arg[3] or arg[2]

local slua_path = 'F:\\Games\\war3map\\singluar_J'
local sluatextures = "war3mapTextures"
local sluaModel = "war3mapModel"
----------------------------------------------------------------------
--- 获取原生mpq文件,判断是否存在
local war3_path = [[D:\\Game\\Warcraft III Frozen Throne]] --war3根目录路径

-- local stormlib = require 'ffi.stormlib'
-- local fs
-- if not pcall(function()
--     fs = require 'bee.filesystem'
-- end) then
--     require 'filesystem'
--     fs = _G['fs']
-- end
local mpqs = {}

war3_path = fs.path(war3_path)
for _, mpqname in ipairs {
    'War3Patch.mpq',
    'War3xLocal.mpq',
    'War3x.mpq',
    'War3Local.mpq',
    'War3.mpq',
} do
    mpqs[#mpqs + 1] = stormlib.open(war3_path / mpqname, true)
    -- print(war3_path / mpqname, war3_path, mpqname)
end

--判断文件路径是否在MPQ里
function IsFileInMPQ(name)
    for _, mpq in ipairs(mpqs) do
        if mpq:has_file(name:gsub('\\\\', '\\')) then
            return true
        end
    end
    return false
end

-- print(IsFileInMPQ([[Units\Creeps\HeroTinkerFactory\TinkerBuilding.blp]]))
----------------------------------------------------------------------

----------------------------------------------------------------------
-- 遍历文件目录内所有文件 返回表
function seach_file(path)
    local file_list = {}
    local function input_file(path)
        table.insert(file_list, path)
    end

    local function seach_file2(path)
        --遍历文件目录
        for child in path:list_directory() do
            --如果是文件夹 则再进入一层

            if fs.is_directory(child) then
                local name = child:filename():string()
                if name ~= '.git' and name ~= '.svn' then
                    seach_file2(child)
                end
            else
                --否则 直接处理文件
                input_file(child)
            end
        end
    end
    seach_file2(path)
    return file_list
end

----------------------------------------------------------------------
-- local temp = fs.get(fs.DIR_TEMP) / "lua-model"

-- --在临时路径下创建一个文件夹
-- function create_tmpfile()
--     fs.remove_all(temp)
--     fs.create_directories(temp)
--     print(temp,"临时文件的地址")
-- end
local toTextuersS
local toModelS
if inputpath then
    -- string.replace(p:string(), "\\", "\\\\")
    -- local outputFilesPath = fs.path(inputpath:parent_path() / (inputpath:filename():string() .. "_outPutModel"))
    local tmppath = fs.path(fs.path(inputpath):parent_path():string() ..
        "\\" .. (fs.path(inputpath):stem():string() .. "_extract"))
    fs.remove_all(tmppath)
    fs.create_directories(fs.path(tmppath / sluatextures))
    fs.create_directories(fs.path(tmppath / sluaModel))

    toTextuersS = fs.path(tmppath / sluatextures):string()
    toModelS = fs.path(tmppath / sluaModel)
end


local filter = {
    -- [".exe"] = true,
    -- [".blp"] = true,
    [".mdl"] = true,
    [".mdx"] = true,
}
local modelIdx = 1
-- 模型贴图为模型名字的拓展
function renameMdxTexture(modelP, isExpand)
    -- local model = lib.model.open(modelP:string())
    local model = lib.model.open(string.replace(modelP:string(), "\\", "\\\\"))
    if model == nil then
        print("nil", modelIdx, modelP:string())
        modelIdx = modelIdx + 1
        return
    end
    local modelF = modelP
    -- 文件名_序号
    local str = modelF:stem():string() .. modelIdx
    -- 是否存在中文, 替换中文
    if isContainChinese(str) then
        str = replaceChinese(str)
    end

    -- print(str)

    print("save", str, modelIdx, modelP:string())
    -- 模型储存路径
    local model_path_to = fs.path(toModelS / (str .. ".mdx"))
    model:save(model_path_to:string())
    local index = 0
    --迭代器 遍历模型所有贴图
    for texture in model:each_texture() do
        -- for key, value in pairs(texture) do
        --     print('\t', key, value)
        -- end
        -- print(texture, texture.path)
        -- 判断模型纹理是否是原生的
        if not IsFileInMPQ(texture.path) then
            -- 判断纹理文件是否存在
            -- print(modelF:parent_path() / fs.path(texture.path), fs.exists(modelF:parent_path() / fs.path(texture.path)),
            --     fs.path(slua_path .. "\\assets\\" .. texture.path),
            --     fs.exists(fs.path(slua_path .. "\\assets\\" .. texture.path)), "存在")
            -- 拼接贴图路径
            local texture_path = fs.path(modelF:parent_path() / texture.path)
            local texture_path2 = fs.path(modelF:parent_path() / string.lower(texture.path))
            -- 若贴图存在 同一路径,或slua路径
            local falg = false
            if fs.exists(texture_path2) == true and fs.is_directory(texture_path) == false then
                texture_path = texture_path2
                falg = true
            elseif fs.exists(texture_path) == true then
                falg = true
            end
            if (string.lower(texture_path:extension():string()) == ".blp" or string.lower(texture_path:extension():string()) == ".tag")
                and falg == true then
                falg = true
            else
                falg = false
            end
            if falg
            -- or fs.exists(fs.path(slua_path .. "\\assets\\" .. texture.path))
            then
                -- -- 更改成数值试试
                -- local toPath = fs.path(((modelIdx .. "_" .. index) .. ".blp"))
                --     :string()
                -- local copyPath = fs.path((modelF:stem():string() .. "_" .. index) ..
                --         fs.path(texture.path):extension():string())
                --     :string()
                -----------------
                -- local copyPath = fs.path((modelIdx .. "_" .. index) .. fs.path(texture.path):extension():string()):string()
                -- local tmppath = fs.path(modelF:parent_path() / fs.path(texture.path))
                -- -- 计划适用于slua
                -- if fs.exists(fs.path(slua_path .. "\\assets\\" .. texture.path)) then
                --     tmppath = fs.path(slua_path .. "\\assets\\" .. texture.path)
                --     copyPath = fs.path((modelF:stem():string() .. "_" .. index) ..
                --         fs.path(texture.path):extension():string()):string()
                -- end
                -- if fs.exists(tmppath) and not fs.is_directory(tmppath) and not fs.exists(fs.path((toTextuersS .. '\\' .. copyPath))) then
                --     -- print(tmppath, fs.path((toTextuersS .. '\\' .. copyPath)))
                --     fs.copy_file(tmppath, fs.path((toTextuersS .. '\\' .. copyPath)))
                -- end
                -- texture.path = toPath
                ----------------- 这段重写
                -- -- 定义贴图名字
                -- local copyPath = fs.path((modelF:stem():string() .. "_" .. index) ..
                --     fs.path(modelF:parent_path() / texture.path):extension():string()):string()
                -- -- 获取贴图路径
                -- local tmppath = fs.path(modelF:parent_path() / texture.path)
                -- if fs.exists(tmppath) == true then
                --     fs.copy_file(tmppath, fs.path(toTextuersS .. "\\" .. copyPath), true)
                -- end
                -- print(texture_path:string())

                -- 重新命名 模型中贴图路径
                -- local toPath = fs.path((sluatextures .. "\\" .. (modelF:stem():string() .. "_" .. index) .. ".blp"))
                local toPath = fs.path((sluatextures .. "\\" .. (str .. "_" .. index) .. ".blp"))
                -- 复制贴图到整理好的贴图文件
                -- if fs.exists(toPath) then

                -- end
                local toPath_ = fs.path(toTextuersS .. "\\" .. ((str .. "_" .. index) .. ".blp"))
                -- print("texture", texture_path, toPath_)
                fs.copy_file(texture_path, toPath_)

                texture.path = toPath:string()
            else
                print("贴图不存在", modelF, fs.path(modelF:parent_path() / texture.path))
                -- return
            end
        end
        index = index + 1
    end
    model:close()
    modelIdx = modelIdx + 1
end

-- local mf = lib.model.open(fs.path("D:\\Games\\魔兽\\singluar\\assets\\war3mapModel\\Construct\\Construct_Art_2.mdx"))
-- local mf = lib.model.open("Construct_antenna.mdx")
-- renameMdxTexture(mf)
-- inputpath = inputpath or fs.path('D:\\Games\\魔兽\\singluar\\tools\\export_model')

-- local p = fs.path("Construct_antenna.mdx")
-- print(fs.absolute(p), fs.path(p:parent_path() / "dasfdasf.mdx"))

-- F:\Games\war3map\singluar_J\tools\export_model  F:\Games\war3map\singluar_J\tools       cccc
-- print(fs.current_path(),fs.current_path():parent_path(), "cccc")

-- F:\Games\war3map\singluar_J\tools\export_model\Construct_antenna.mdx
-- print(fs.absolute(p),"abs")

-- fs.rename(fs.path([[F:\Games\war3map\singluar_J\tools\export_model\Construct_antenna.mdx]]),
--     fs.path([[F:\Games\war3map\singluar_J\tools\export_model\1231231.mdx]]))

-- print(fs.exists(fs.path("Construct_antenna.mdx")),fs.path("Construct_antenna.mdx"), fs.path("1231231.mdx"))
-- fs.rename(fs.path("Construct_antenna.mdx"), fs.path("1231231.mdx")) -- 重命名可用


-- renameMdxTexture(p:string())
-- print(fs.exists(fs.path("F:\\Games\\war3map\\singluar_J\\assets\\war3mapTextures\\Construct_Generators_5_1.blp")))

-- 打印路径
-- Construct_antenna.mdx   p:filename()
-- Construct_antenna        p:stem()
-- .mdx    p:extension()

---- 遍历文件
local filesTable = seach_file(fs.path(inputpath))
for index, file in ipairs(filesTable) do
    if filter[file:extension():string()] then
        -- print(index, file, "file")
        --     -- local model = lib.model.open(file:string())
        -- if file ~= nil then
        renameMdxTexture(file)
        -- end
    end
end

-- ----------------------------------------------------------------------
-- -- 打印绑定元表的函数
-- for key, value in pairs(getmetatable(fs)) do
--     if type(value) == "table" then
--         ergodic(value)
--     end
--     print(key, value)
-- end
