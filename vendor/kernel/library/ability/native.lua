-- ability = ability or {}
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
        -- J.UnitMakeAbilityPermanent(targerUnit.handle(), true, id)
    else
        J.UnitAddAbility(targerUnit.handle(), id)
        time.setTimeout(duration, function(t)
            t.destroy()
            J.UnitRemoveAbility(targerUnit.handle(), id)
        end)
    end
end
