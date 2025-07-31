local tilesetManager = {
    visible = true,
    collisionMode = false,

    x = 600,
    y = 50,
    width = 256,
    height = 256,

    dragging = false,
    dragOffsetX = 0,
    dragOffsetY = 0,
}


function tilesetManager.load()
    -- Load your tileset here
end

function tilesetManager.draw()
    if tilesetManager.visible then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", tilesetManager.x, tilesetManager.y, tilesetManager.width, tilesetManager.height)
        love.graphics.print("Tileset Area", tilesetManager.x + 20, tilesetManager.y + 20)
    end
end


function tilesetManager.drawUICheckbox()
    if tilesetManager.visible then
        local text = tilesetManager.collisionMode and "Collision: ON" or "Collision: OFF"
        love.graphics.print(text, 600, 320)
    end
end

function tilesetManager.toggleCollision()
    tilesetManager.collisionMode = not tilesetManager.collisionMode
end

function tilesetManager.mousepressed(x, y, button)
    if button == 1 and
       x >= tilesetManager.x and x <= tilesetManager.x + tilesetManager.width and
       y >= tilesetManager.y and y <= tilesetManager.y + tilesetManager.height then
        tilesetManager.dragging = true
        tilesetManager.dragOffsetX = x - tilesetManager.x
        tilesetManager.dragOffsetY = y - tilesetManager.y
        return true
    end
    return false
end

function tilesetManager.mousereleased(x, y, button)
    tilesetManager.dragging = false
end

function tilesetManager.mousemoved(x, y, dx, dy)
    if tilesetManager.dragging then
        tilesetManager.x = x - tilesetManager.dragOffsetX
        tilesetManager.y = y - tilesetManager.dragOffsetY
        -- Optional clamping
        tilesetManager.x = math.max(0, math.min(tilesetManager.x, love.graphics.getWidth() - tilesetManager.width))
        tilesetManager.y = math.max(0, math.min(tilesetManager.y, love.graphics.getHeight() - tilesetManager.height))
        return true
    end
    return false
end


function tilesetManager.handleUIClick(x, y)
    return false
end

return tilesetManager
