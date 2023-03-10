local lib = require 'modellib'
local module = require 'modellib.module'
local ffi = require 'ffi'
local stormlib = require 'map.stormlib'
local uni = require 'map.unicode'


local inputpath = arg[2]

local outpath = arg[3] or arg[2]
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

-- local temp = fs.get(fs.DIR_TEMP) / "lua-model"

-- --在临时路径下创建一个文件夹
-- function create_tmpfile()
--     fs.remove_all(temp)
--     fs.create_directories(temp)
--     print(temp,"临时文件的地址")
-- end

local filter = {
    -- [".exe"] = true,
    -- [".blp"] = true,
    -- [".mdl"] = true,
    [".mdx"] = true,
}


-- 重命名模型贴图为模型名字的拓展
function renameMdxTexture(model, isExpand)
    --迭代器 遍历模型所有贴图
    for texture in model:each_texture() do
        -- for key, value in pairs(texture) do
        --     print('\t', key, value)
        -- end
        print(texture, texture.path)
        -- 判断模型纹理是否是原生的

        -- 如果不是判断模型纹理地址是否存在，不存在则不处理模型路劲

    end
end

-- local mf = lib.model.open(fs.path("D:\\Games\\魔兽\\singluar\\assets\\war3mapModel\\Construct\\Construct_Art_2.mdx"))
local mf = lib.model.open("Construct_antenna.mdx")
renameMdxTexture(mf)
inputpath = inputpath or 'D:\\Games\\魔兽\\singluar\\tools\\export_model\\bin'

function ergodic(v)
    for key, value in pairs(v) do
        print(key, value)
    end
end

-- 打印绑定元表的函数
-- for key, value in pairs(getmetatable(mf)) do
--     if type(value) == "table" then
--         -- ergodic(value)
--     end
--     print(key, value)
-- end
