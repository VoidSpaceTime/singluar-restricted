Classes = Classes or {}
function CLink(this, name, method, ...)
    if (name == nil or method == nil) then
        return
    end
    return Class(name).public().get(method)(this, ...)
end

function Class(name)
    if (type(name) == "table") then
        name = name.__NAME__
    end
    if (type(name) ~= "string") then
        return
    end
    local this = Classes[name]
    if (this == nil) then
        this = { __NAME__ = name, __INHERIT__ = nil, __CONSTRUCT__ = nil, __INITIAL__ = nil, __PUBLIC__ = nil,
            __PRIVATE__ = nil, __FACADES__ = Array(), __DESTROY__ = nil, __EXEC__ = nil, __FORMATTER__ = nil,
            __LIMITER__ = nil, }
        Classes[name] = this
        this.name = function() return this.__NAME__ end
        this.facades = function() return this.__FACADES__ end
        this.inherit = function(modify)
            if (type(modify) == "string") then
                this.__INHERIT__ = modify
                return this
            end
            return this.__INHERIT__
        end
        this.construct = function(modify) if (type(modify) == "function") then
                this.__CONSTRUCT__ = modify
                return this
            end
            return this.__CONSTRUCT__
        end
        this.public = function(key, modify)
            if (type(key) == "string" and type(modify) == "function") then
                if (this.__PUBLIC__ == nil) then
                    this.__PUBLIC__ = Array()
                end
                this.__PUBLIC__.set(key, modify)
                return this
            end
            return this.__PUBLIC__
        end
        this.private = function(key, modify)
            if (type(key) == "string" and type(modify) == "function") then
                if (this.__PRIVATE__ == nil) then
                    this.__PRIVATE__ = Array()
                end
                this.__PRIVATE__.set(key, modify)
                return this
            end
            return this.__PRIVATE__
        end
        this.initial = function(modify) if (type(modify) == "function") then this.__INITIAL__ = modify return this end
            return this.__INITIAL__
        end
        this.destroy = function(modify) if (type(modify) == "function") then this.__DESTROY__ = modify return this end
            return this.__DESTROY__
        end
        this.exec = function(key, modify) if (type(key) == "string" and type(modify) == "function") then
                if (this.__EXEC__ == nil) then
                    this.__EXEC__ = Array()
                end
                this.__EXEC__.set(key, modify)
                return this
            end
            return this.__EXEC__
        end
        this.formatter = function(key, modify) if (type(key) == "string" and type(modify) == "function") then
                if (this.__FORMATTER__ == nil) then this.__FORMATTER__ = {} end
                this.__FORMATTER__[key] = modify
                return this
            end
            return this.__FORMATTER__
        end
        this.limiter = function(key, modify)
            if (type(key) == "string" and type(modify) == "function") then
                if (this.__LIMITER__ == nil) then this.__LIMITER__ = {} end
                this.__LIMITER__[key] = modify
                return this
            end
            return this.__LIMITER__
        end
    end
    return this
end
