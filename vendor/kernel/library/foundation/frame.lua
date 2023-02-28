frame = frame or {}


---@param evtData table 表,包含触发玩家,触发frame
---@param qty number 点击次数
---@param duration number|nil 点击延时
---@param fun fun(evtData:{triggerFrame:table,triggerPlayer:table}) 若执行
function frame.click_qty(evtData, qty, duration, fun)
    local key = "ClickQTY"
    duration = duration or 0.8
    qty = qty or 2
    -- 双击条件
    local prop = evtData.triggerFrame.prop(key .. evtData.triggerPlayer.index()) or 1
    evtData.triggerFrame.prop(key .. evtData.triggerPlayer.index(), prop + 1)
    time.setTimeout(duration, function(curTimer)
        evtData.triggerFrame.prop(key .. evtData.triggerPlayer.index(), "-=1")
        curTimer.destroy()
    end)
    if qty <= prop then
        if type(fun) == "function" then
            fun(evtData)
        end
    end
end
