package.cpath = package.cpath .. ';bin/?.dll;'
package.path = package.path .. ';'

local function add_path(path)
    package.path = package.path .. path .. '/?.lua;'
    package.path = package.path .. path .. '/?/init.lua;'
end

add_path('src')
add_path('src/util')
add_path('src/map')

require 'filesystem'


if arg[1] == 'pack' then           --打包成内置插件
    require 'pack'
elseif arg[1] == 'encryption' then --加密地图
    require 'encryption'
elseif arg[1] == 'testanimation' then
    require 'animate'
elseif arg[1] == 'export_model' then
    require 'export_model'
elseif arg[1] == 'test' then
    require 'rename_modle'
end
