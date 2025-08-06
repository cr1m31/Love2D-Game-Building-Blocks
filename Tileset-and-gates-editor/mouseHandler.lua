local mouseHandlerModule = {}

local wasMouseDown = false

function mouseHandlerModule.update()
    local mouseDown = love.mouse.isDown(1)
    wasMouseDown = wasMouseDown or mouseDown
end

function mouseHandlerModule.checkIfMouseClickedInRectangle(rect)
    local mouseDown = love.mouse.isDown(1)
    local x, y = love.mouse.getPosition()

    if not mouseDown and wasMouseDown then
        wasMouseDown = false
        return mouseHandlerModule.checkIfMouseIsInsideRectangle(x, y, rect)
    end

    return false
end

function mouseHandlerModule.checkIfMouseIsInsideRectangle(mousex, mousey, rect)
    return mousex > rect.x and
           mousex < rect.x + rect.width and
           mousey > rect.y and
           mousey < rect.y + rect.height
end

return mouseHandlerModule
