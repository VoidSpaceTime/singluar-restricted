---@private
_SET_UNIT = function(_v)
    _v._class = "unit"
    if (_v._parent == nil) then
        _v._parent = "ogru"
    end
    return _v
end

---@private
_SET_ABILITY = function(_v)
    _v._class = "ability"
    if (_v._parent == nil) then
        _v._parent = "ANcl"
    end
    return _v
end

---@private
_SET_DESTRUCTABLE = function(_v)
    _v._class = "destructable"
    if (_v._parent == nil) then
        -- _v._parent = "BTsc" -- 原生 支撑柱
        _v._parent = "LTbs"
    end
    return _v
end
