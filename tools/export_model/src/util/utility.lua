local unicode = require 'unicode'

local std_print = print 
local utils = {}

function print(...)
    local args = {...}
    local count = select('#', ...)
    for i = 1, count do 
        local s = unicode.u2a(tostring(args[i]))
        args[i] = s 
    end 

    std_print(table.unpack(args))
end 
io.std_print = std_print

function io.load(file_path)
    local name 
    if type(file_path) == 'string' then 
        name = file_path 
    else 
        name = file_path:string()
    end 
    local f, e = io.open(name, "rb")
    if f then
        if f:read(3) ~= '\xEF\xBB\xBF' then
            f:seek('set')
        end
        local content = f:read 'a'
        f:close()
        return content
    else
        return false, e
    end
end

function io.save(file_path, content)
    local name 
    if type(file_path) == 'string' then 
        name = file_path 
    else 
        name = file_path:string()
    end 

    local f, e = io.open(name, "wb")
    if f then
        f:write(content)
        f:close()
        return true
    else
        return false, e
    end
end




--将lua表编码成字符串
function utils.encode(tbl)
    local type = type
    local pairs = pairs
    local format = string.format
    local find = string.find
    local tostring = tostring
    local tonumber = tonumber
    local mark = {}
    local buf = {}
    local count = 0
    local function dump(v)
        local tp = type(v)
        if mark[v] then
            error('表结构中有循环引用')
        end
        mark[v] = true
        buf[#buf+1] = '{'
        local ator = pairs 
        if #v > 0 then 
            ator = ipairs
        end
        for k, v in ator(v) do
            count = count + 1
            --if count > 1000 then
            --    error('表太大了')
            --end
            local tp = type(k)
            if tp == 'number' then
                if ator == pairs then 
                    buf[#buf+1] = format('[%s]=', k)
                end 
            elseif tp == 'string' then
                if find(k, '[^%w_]') then
                    buf[#buf+1] = format('[%q]=', k)
                else
                    buf[#buf+1] = k..'='
                end
            else
                error('不支持的键类型：'..tp)
            end
            local tp = type(v)
            if tp == 'table' then
                dump(v)
                buf[#buf+1] = ','
            elseif tp == 'number' then
                buf[#buf+1] = format('%q,', v)
            elseif tp == 'string' then
                buf[#buf+1] = format('%q,', v)
            elseif tp == 'boolean' then
                buf[#buf+1] = format('%s,', v)
            else
                log.error('不支持的值类型：'..tp)
            end
        end
        buf[#buf+1] = '}'
    end
    dump(tbl)
    return table.concat(buf)
end

--将字符串 加载为lua表
function utils.decode(buf)
    local f, err = load('return '..buf)
    if not f then
        print(err)
        return nil
    end
    local suc, res = pcall(f)
    if not suc then
        print(res)
        return nil
    end
    return res
end


function sortpairs(t)
    local mt
    local func
    local sort = {}
    for k, v in pairs(t) do
        sort[#sort+1] = {k, v}
    end
    table.sort(sort, function (a, b)
        return a[1] < b[1]
    end)
    local n = 1
    return function()
        local v = sort[n]
        if not v then
            return
        end
        n = n + 1
        return v[1], v[2]
    end
end

function split(str, p) 
    local rt = {} 
    str:gsub('[^'..p..']+',  function (w) 
        table.insert(rt, w) 
    end) 
    return rt 
end

function get_table_size(tbl)
    local count = 0 
    for key,value in pairs(tbl) do
        count = count + 1
    end
    return count
end


function absolute_path(path)
    if not path then
        return
    end
    path = fs.path(path)
    if not path:is_absolute() then
        return fs.absolute(path, base)
    end
    return fs.absolute(path)
end

function copy_file(path, target_path)
    local str = io.load(path)
    if str then 
        local parent = target_path:parent_path()
        if fs.is_directory(parent) == false then 
            fs.create_directories(parent)
        end 
        io.save(target_path, str)
    end
end 


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

return utils