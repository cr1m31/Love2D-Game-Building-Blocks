local gateEditor = {}

local gates = {}
local isDrawing = false
local startX, startY = 0, 0
local currentGate = nil

function gateEditor.mousepressed(x, y, button)
    if button ~= 1 then return end

    -- Block drawing if interacting with UI
    if editorMenu.mousepressed(x, y, button) or tilesetManager.mousepressed(x, y, button) then
        return
    end

    startX, startY = x, y
    isDrawing = true
    currentGate = { x = x, y = y, width = 0, height = 0 }
end


function gateEditor.mousereleased(x, y, button)
    if button == 1 and isDrawing and currentGate then
        isDrawing = false

        local w = math.abs(x - startX)
        local h = math.abs(y - startY)

        if w >= 8 and h >= 8 then
            currentGate.x = math.min(startX, x)
            currentGate.y = math.min(startY, y)
            currentGate.width = w
            currentGate.height = h
            table.insert(gates, currentGate)
        end
        currentGate = nil
    end
end

function gateEditor.draw()
    -- Draw existing gates
    love.graphics.setColor(0, 1, 0, 0.4)
    for _, g in ipairs(gates) do
        love.graphics.rectangle("fill", g.x, g.y, g.width, g.height)
    end

    love.graphics.setColor(0, 1, 0)
    for _, g in ipairs(gates) do
        love.graphics.rectangle("line", g.x, g.y, g.width, g.height)
    end

    -- Draw currently drawing gate
    if isDrawing and currentGate then
        local mx, my = love.mouse.getPosition()
        local x = math.min(startX, mx)
        local y = math.min(startY, my)
        local w = math.abs(mx - startX)
        local h = math.abs(my - startY)

        love.graphics.setColor(1, 1, 0, 0.3)
        love.graphics.rectangle("fill", x, y, w, h)
        love.graphics.setColor(1, 1, 0)
        love.graphics.rectangle("line", x, y, w, h)
    end

    love.graphics.setColor(1, 1, 1)
end

function gateEditor.deleteGateAt(x, y)
    for i = #gates, 1, -1 do
        local g = gates[i]
        if x >= g.x and x <= g.x + g.width and y >= g.y and y <= g.y + g.height then
            table.remove(gates, i)
            return true
        end
    end
    return false
end

return gateEditor
