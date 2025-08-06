local mouseHandlerModule = {}

local lastPressedX, lastPressedY, lastPressedButton = nil, nil, nil

function mouseHandlerModule.update()
    lastPressedX, lastPressedY, lastPressedButton = nil, nil, nil
end

function mouseHandlerModule.mousepressed(x, y, button)
    lastPressedX = x
    lastPressedY = y
    lastPressedButton = button
end

function mouseHandlerModule.checkIfMousePressedInRectangle(rect)
    if lastPressedButton == 1 and lastPressedX and lastPressedY then
        return lastPressedX > rect.x and lastPressedX < rect.x + rect.width and
               lastPressedY > rect.y and lastPressedY < rect.y + rect.height
    end
    return false
end

return mouseHandlerModule
