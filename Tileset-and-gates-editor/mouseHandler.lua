local mouseHandlerModule = {}

local dragging = false
local dragOffsetX = 0
local dragOffsetY = 0

local lastClickX, lastClickY, lastClickButton = nil, nil, nil
local lastReleaseX, lastReleaseY, lastReleaseButton = nil, nil, nil

function mouseHandlerModule.drag(rect)
    local x, y = love.mouse.getPosition()

    if love.mouse.isDown(1) then
        if not dragging and mouseHandlerModule.checkIfMouseIsInsideRectangle(x, y, rect) then
            dragging = true
            dragOffsetX = x - rect.x
            dragOffsetY = y - rect.y
        end

        if dragging then
            rect.x = x - dragOffsetX
            rect.y = y - dragOffsetY
        end
    else
        dragging = false
    end
end

function mouseHandlerModule.mousepressed(x, y, button)
    lastClickX = x
    lastClickY = y
    lastClickButton = button
end

function mouseHandlerModule.mousereleased(x, y, button)
    lastReleaseX = x
    lastReleaseY = y
    lastReleaseButton = button
end

function mouseHandlerModule.checkIfMouseReleasedInRectangle(rect)
    if lastReleaseButton == 1 and lastReleaseX and lastReleaseY then
        if mouseHandlerModule.checkIfMouseIsInsideRectangle(lastReleaseX, lastReleaseY, rect) then
            lastReleaseX, lastReleaseY, lastReleaseButton = nil, nil, nil
            return true
        end
    end
    return false
end

function mouseHandlerModule.checkIfMouseIsInsideRectangle(mousex, mousey, rect)
    return mousex > rect.x and
           mousex < rect.x + rect.width and
           mousey > rect.y and
           mousey < rect.y + rect.height
end

function mouseHandlerModule.isDragging()
    return dragging
end

return mouseHandlerModule
