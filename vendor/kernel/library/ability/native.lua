-- ability = ability or {}
---添加原生技能
---@param targerUnit Unit
---@param id string|number
---@param duration number|nil
ability.addNative = function(targerUnit, id, duration)
    duration = duration or 0
    if (type(id) == "string") then
        id = c2i(id)
    end
    if (duration == nil or duration <= 0) then
        J.UnitAddAbility(targerUnit.handle(), id)
        J.UnitMakeAbilityPermanent(targerUnit.handle(), true, id)
    else
        J.UnitAddAbility(targerUnit.handle(), id)
        J.UnitMakeAbilityPermanent(targerUnit.handle(), true, id)
        time.setTimeout(duration, function(t)
            t.destroy()
            J.UnitRemoveAbility(targerUnit.handle(), id)
        end)
    end
end

local Terrain_prop = Array()
---设置地形可通行状态
---例:设置'建造'通行状态为开,则该点可以建造建筑.一个单元点范围为32x32.
---@param x any
---@param y any
---@param pathingType any
---@param flag any
ability.SetTerrainPathable = function(x, y, pathingType, flag)
    -- local x = math.fmod (1266,  32 )
    x = math.round(x / 32) * 32
    y = math.round(y / 32) * 32
    J.SetTerrainPathable(x, y, pathingType, flag)
    local str = string.implode("|", { x, y, pathingType })
    if Terrain_prop.get(str) then
        if flag then
            Terrain_prop.set(str, 1)
        else
            Terrain_prop.set(str, 0)
        end
    end
end
--- 地形叠加态
---@param x number
---@param y number
---@param type any
---@param modify string
---@return string
ability.Superposition_Terrain = function(x, y, type, modify)
    if x % 32 ~= 0 and y % 32 ~= 0 then
        x = math.round(x / 32) * 32
        y = math.round(y / 32) * 32
    end
    if not RectPlayable.isBorder(x, y) then
        local str = string.implode("|", { x, y, type })
        local tmp = Terrain_prop.get(str) or 1
        if Terrain_prop.get(str) then
            local val, dif = math.cale(modify, Terrain_prop.get(str))
            Terrain_prop.set(str, val)
        else
            local flag
            if type == PATHING_TYPE_WALKABILITY then -- 地面    复杂度太高了
                flag = terrain.isWalkable(x, y)
            elseif type == PATHING_TYPE_FLYABILITY then -- 空中
                flag = terrain.isWalkableFly(x, y)
            elseif type == PATHING_TYPE_BUILDABILITY then -- 可建造地面
                flag = terrain.isWalkableBuild(x, y)
            elseif type == PATHING_TYPE_PEONHARVESTPATHING then -- 矿工采集可通行
                flag = terrain.isWalkablePeonHarvest(x, y)
            elseif type == PATHING_TYPE_BLIGHTPATHING then -- 荒芜地表
                flag = terrain.isWalkableBlight(x, y)
            elseif type == PATHING_TYPE_FLOATABILITY then -- 可通行海面
                flag = terrain.isWalkableWater(x, y)
            elseif type == PATHING_TYPE_AMPHIBIOUSPATHING then -- 两栖单位可通行
                flag = terrain.isWalkableAmphibious(x, y)
            end
            local i
            if flag then i = 1 else i = 0 end
            Terrain_prop.set(str, math.cale(modify, i))
        end
        if (tmp < 1 and Terrain_prop.get(str) < 1) or (tmp >= 1 and Terrain_prop.get(str) >= 1) then
        elseif (tmp < 1 and Terrain_prop.get(str) >= 1) then -- 获得效果
            ability.SetTerrainPathable(x, y, type, true)
        elseif (tmp >= 1 and Terrain_prop.get(str) < 1) then -- 关闭效果
            ability.SetTerrainPathable(x, y, type, false)
        end
        return str
    end
end
