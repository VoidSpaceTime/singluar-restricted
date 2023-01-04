function Inherit(this, options) 
    local inh = {}
    local c = Class(this)
    local afterInitial = c.afterInitial
    while (c ~= nil) do
        table.insert(inh, c.name())
        if (c.inherit() == nil) then
            break
        end
        c = Class(c.inherit())
    end
    for i = 1, #inh, 1 do
        local construct = Class(inh[i]).construct()
        if (construct ~= nil) then
            construct(this, options)
        end
    end
    for i = #inh, 1, -1 do
        Method(this, inh[i])
    end
    for i = #inh, 1, -1 do local initial = Class(inh[i]).initial()
        if (initial ~= nil) then
            initial(this)
        end
    end
    PropReExec(this)
    if (afterInitial ~= nil) then afterInitial(this) end
end

function Method(this, name)
    if (name == nil) then return end
    if (this.__NAME__ == name) then 
        local private = Class(name)
            .private()
        if (private ~= nil) then
            private.forEach(function(key, value) this[key] = function(...)
                    return value(this, ...)
                end
            end)
        end
    end
    local public = Class(name).public()
    if (public ~= nil) then public.forEach(function(key, value)
            this[key] = function(...) return value(this, ...) end
        end)
    end
    Class(this).facades().set(this.__ID__, 1)
end

function Object(name, options)
    must(name ~= nil)
    local protect = false
    local static
    if (options ~= nil) then
        if (type(options.protect) == "boolean") then
            protect = options.protect
        end
        if (type(options.static) == "table" and #options.static == 2) then
            static = options.static
        end
    end
    if (static ~= nil) then
        local tc = bop.static[static[1] .. static[2]]
        if (tc ~= nil) then
            return tc
        end
    end
    local this = { __HANDLE__ = nil, __STATIC__ = static, __PROTECT__ = protect, __NAME__ = name, __ID__ = bopID(name),
        __PROP__ = {}, }
    bop.i2o[this.__ID__] = this
    if (this.__STATIC__ ~= nil) then
        bop.static[this.__STATIC__[1] .. this.__STATIC__[2]] = this
    end
    this.id = function() return this.__ID__
    end
    this.isDestroy = function()
        return bop.i2o[this.__ID__] == nil
    end
    this.destroy = function(delay)
        if (this.__PROTECT__ == true) then
            print(this.__ID__ .. "IsProtecting")
            return
        end
        delay = delay or 0
        if (delay < 0) then delay = 0 end
        local cls = function()
            href(this, nil)
            if (this.__STATIC__ ~= nil) then
                bop.static[this.__STATIC__[1] .. this.__STATIC__[2]] = nil
            end
            local c = Class(this)
            while (c ~= nil) do local dy = c.destroy()
                if (type(dy) == "function") then dy(this) end
                if (c.inherit() == nil) then break end
                c = Class(c.inherit())
            end
            Class(this).facades().set(this.__ID__, nil)
            bop.i2o[this.__ID__] = nil
        end
        if (delay == 0) then
            cls()
        else
            time.setTimeout(delay, function(_) cls() end)
        end
    end
    this.prop = function(key, modify, duration)
        if (type(duration) ~= "number") then duration = 0 end
        if (type(modify) == "string") then
            local durc = string.explode(";", modify)
            if (#durc == 2) then
                local durc2 = tonumber(durc[2])
                if (type(durc2) == "number") then
                    duration = math.max(0, durc2)
                    modify = durc[1]
                end
            end
        end
        return Prop(this, key, modify, duration)
    end
    this.raise = function(key, modify, duration)
        local rKey = "<RAISE>" .. key
        if (modify) then
            return this.prop(rKey, modify, duration)
        end
        return this.prop(rKey) or 0
    end
    this.mutation = function(key, modify, duration)
        local mKey = "<MUTATION>" .. key
        if (modify) then
            return this.prop(mKey, modify, duration)
        end
        return this.prop(mKey) or 0
    end
    this.superposition = function(key, modify, duration)
        local sKey = "<SUPERPOSITION>" .. key
        if (modify) then
            return this.prop(sKey, modify, duration)
        end
        return this.prop(sKey) or 0
    end
    Inherit(this, options)
    return this
end
