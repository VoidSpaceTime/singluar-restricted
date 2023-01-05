---@private
---@return {_id}
_unit = function(_v) SINGLUAR_SETTING(_SET_UNIT(_v)) end

---@private
---@return {_id}
_ability = function(_v) SINGLUAR_SETTING(_SET_ABILITY(_v)) end

---@private
---@return {_id}
_destructable = function(_v) SINGLUAR_SETTING(_SET_DESTRUCTABLE(_v)) end

--- 只支持组件包
---@type fun(typeName:string):void
_assets_selection = function(typeName) end

--- 只支持ttf
---@type fun(ttfName:string):void
_assets_font = function(ttfName) end

--- 只支持tga
---@type fun(tga:string):void
_assets_loading = function(tga) end

--- 只支持tga
---@type fun(tga:string):void
_assets_preview = function(tga) end

--- 原生首符号加:冒号
--- 只支持tga
---@type fun(path:string, alias:string|nil):void
_assets_icon = function(path, alias)
    if (path) then
        path = string.trim(string.gsub(path, "%.tga", ""))
        alias = alias or path
        SINGLUAR_ICON[alias] = path
    end
end

--[[-- 可破坏物
    fogVis:number,  -- 迷雾中可见动画
    showInMM:number,    -- 是否在小地图上显示
    occH:number,    -- 闭塞高度
    colorR:number,  --红
    colorG:number,--绿
    colorB:number,--蓝
    minScale:number,-- 最小比例
    maxScale:number, -- 最大比例
    numVal:number, -- 模型样式总数
    selectable:boolean -- 游戏中可选择
    selcircsize -- 选择圈大小
]]
--[[ 单位   选择圈多 0.5是32，1应该是64 坐标

    unitSound      = "", --单位声音
    scale          = 1, --选择缩放
    modelScale     = 1, --模型缩放
    dmgpt1         = "", --攻击类型1
    backSw1        = 0.64, -- 攻击动画回复点  发动攻击效果到完成攻击动作所需要的时间,该值大于(攻击间隔-动画伤害点)攻击完成后可以通过发布其他命令手动取消
    movetp         = MOVE_TYPE_FOOT, --移动类型
    moveHeight     = 0, -- 进决定动画模型的飞行高度,与穿越地形无关
    sight          = 1000, --视野范围 白天
    cool1          = 1, --攻速间隔,不会超过每秒45.6击
    targs1         = "notself,debris,alive,ground,nonancient,nonhero,nonsapper,ancient,mechanical,structure,vulnerable,air,ward,item,organic,sapper", -- 目标类型
    Art            = "", --显示图标
    -------
    collision      = 32 , --单位的实际体积大小,而非显示大小比如碰撞体积大的单位经过窄的路口会被堵住
    selZ           = 0, --选择圈高度
    occH           = 128, --单位站在有闭塞高度的非联盟建筑或可破坏物旁边会有局部实现被阻挡成锥形,就是所谓的闭塞,将该值设为0将不会有此效果
    unitShadow     = "", --单位时阴影/可以用原生/贴图
    buildingShadow = "", --建筑形态时阴影
    fatLOS         = 0, --勾选该项则单位可以在不可见区域被显示. bool
    targType       = "", --作为目标类型
    hideOnMinimap  = 1, --隐藏小地图显示 bool
    canSleep       = 0, --是否允许在夜晚睡眠,仅对中立敌对有效 bool
    moveFloor      = 0, -- 最小飞行高度
    ------- 测试性质
   -- PathTextures\\StoneWall3Path.tga    -- 石头墙 丨
   -- PathTextures\\StoneWall4Path.tga      -- 石头墙 丿
   -- PathTextures\\StoneWall2Path.tga     -- 石头墙 乀
   -- PathTextures\\StoneWall1Path.tga     -- 石头墙 一

    pathTex = "PathTextures\\StoneWall3Path.tga"
]]
--- 原生首符号加:冒号
--- 只支持mdx,自动贴图路径必须war3mapTextures开头，文件放入assets/war3mapTextures内
---@alias noteAssetsModelUnitOptions {unitSound:string,scale:number,modelScale:number,dmgpt1:number,backSw1:number,movetp:string,moveHeight:number,sight:number,cool1:number,targs1:string,Art:string}
---@alias noteAssetsModelItemOptions {unitSound:string,scale:number,modelScale:number,Art:string,movetp:string,moveHeight:number,sight:number}
---@alias noteAssetsModelDestOptions {fogVis:number,showInMM:number,occH:number,colorR:number,colorG:number,colorB:number,minScale:number,maxScale:number,numVal:number,selectable:boolean}
---@type fun(path:string, alias:string|nil, class:string|nil|"'unit'"|"'item'"|"'destructable'", options:noteAssetsModelUnitOptions|noteAssetsModelItemOptions|noteAssetsModelDestOptions):void
_assets_model = function(path, alias, class, options)
    if (path) then
        class = class or "common"
        path = string.gsub(path, "%.mdx", "")
        path = string.gsub(path, "%.mdl", "")
        path = string.trim(path)
        alias = alias or path
        SINGLUAR_MODEL[alias] = path
        if (class == "unit") then
            options = options or {}
            if (options.Art ~= nil) then
                local pa = string.trim(string.gsub(options.Art, "%.tga", ""))
                if (SINGLUAR_ICON[pa] == nil) then
                    _assets_icon(options.Art)
                end
            end
            _unit({})
            SINGLUAR_MODEL_U[alias] = path
        elseif (class == "item") then
            options = options or {}
            if (options.Art ~= nil) then
                local pa = string.trim(string.gsub(options.Art, "%.tga", ""))
                if (SINGLUAR_ICON[pa] == nil) then
                    _assets_icon(options.Art)
                end
            end
            _unit({})
            SINGLUAR_MODEL_I[alias] = path
        elseif (class == "destructable") then
            _destructable({})
            SINGLUAR_MODEL_D[alias] = path
        end
    end
end

--- 不支持原生音频！
--- 只支持mp3，不建议使用推荐以外其他规格否则质量下降且有可能无法播放
--- 音效荐：48000HZ 192K 单
--- 音乐荐：48000HZ 320K 单
---@type fun(path:string, alias:string|nil, soundType:string | "vcm"| "v3d" | "bgm" | "vwp"):void
_assets_sound = function(path, alias, soundType)
    if (path) then
        path = string.trim(string.gsub(path, "%.mp3", ""))
        alias = alias or path
        SINGLUAR_SOUND[soundType][alias] = path
    end
end

--- 只支持UI套件
--- UI套件需按要求写好才能被正确调用！
---@type fun(kit:string):void
_assets_ui = function(kit) end
