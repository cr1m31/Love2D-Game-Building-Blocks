local gateEditor = {}

local gates = {}
local isDrawing = false
local startX, startY = 0, 0
local selectedDirection = "east"
local selectedTargetMap = "map-2"
local selectedTargetGate = "west"

function gateEditor.setGateParams(direction, targetMap, targetGate)
    selectedDirection = direction
    selectedTargetMap = targetMap
    selectedTargetGate = targetGate
end

function gateEditor.mousepressed(x, y, button)
    if button == 1 then
        startX, startY = x, y
        isDrawing = true
        currentGate = {
            x = x,
            y = y,
            direction = selectedDirection,
            targetMap = selectedTargetMap,
            targetGate = selectedTargetGate
        }
    end
end


function gateEditor.mousereleased(x, y, button)
    if button == 1 and isDrawing and currentGate then
        isDrawing = false
        local width = math.abs(x - currentGate.x)
        local height = math.abs(y - currentGate.y)

        if width >= 8 and height >= 8 then
            currentGate.width = width
            currentGate.height = height
            currentGate.x = math.min(currentGate.x, x)
            currentGate.y = math.min(currentGate.y, y)

            if not gates[currentGate.direction] then
                gates[currentGate.direction] = {}
            end
            table.insert(gates[currentGate.direction], currentGate)
        end

        currentGate = nil
    end
end


function gateEditor.draw()
    for dir, gateList in pairs(gates) do
        for _, g in ipairs(gateList) do
            love.graphics.setColor(0, 1, 0, 0.4)
            love.graphics.rectangle("fill", g.x, g.y, g.width, g.height)
            love.graphics.setColor(0, 1, 0)
            love.graphics.rectangle("line", g.x, g.y, g.width, g.height)
        end
    end

    if isDrawing then
        local x = math.min(startX, love.mouse.getX())
        local y = math.min(startY, love.mouse.getY())
        local w = math.abs(love.mouse.getX() - startX)
        local h = math.abs(love.mouse.getY() - startY)

        love.graphics.setColor(1, 1, 0, 0.3)
        love.graphics.rectangle("fill", x, y, w, h)
        love.graphics.setColor(1, 1, 0)
        love.graphics.rectangle("line", x, y, w, h)
    end

    love.graphics.setColor(1, 1, 1)
end

function gateEditor.getGates()
    return gates
end

return gateEditor
