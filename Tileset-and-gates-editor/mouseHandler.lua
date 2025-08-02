local mouseHandlerModule = {}

local dragging = false
local dragOffsetX = 0
local dragOffsetY = 0

function mouseHandlerModule.drag(rect)
    local x, y = love.mouse.getPosition()

    if love.mouse.isDown(1) then
        if not dragging and checkIfMouseIsInsideRectangle(x, y, rect) then
            -- Start dragging and store offset from rectangle top-left
            dragging = true
            dragOffsetX = x - rect.x
            dragOffsetY = y - rect.y
        end

        if dragging then
            -- Apply stored offset while dragging
            rect.x = x - dragOffsetX
            rect.y = y - dragOffsetY
        end
    else
        -- Stop dragging when mouse released
        dragging = false
    end
end

function checkIfMouseIsInsideRectangle(mousex, mousey, rect)
    return mousex > rect.x and
           mousex < rect.x + rect.width and
           mousey > rect.y and
           mousey < rect.y + rect.height
end

return mouseHandlerModule
