io.stdout:setvbuf("no") -- See output immediately
love.window.setMode(1024, 768)
love.graphics.setDefaultFilter("nearest", "nearest")

local spritesheetManagerModule = require("spritesheetManager")

function love.load()
    spritesheetManagerModule.getTiles()
end

function love.update(dt)
    spritesheetManagerModule.updateDrag()
end

function love.draw()
    spritesheetManagerModule.drawEntireSpriteSheet()
end

function love.mousepressed(x, y, button)
    if button == 1 then
        spritesheetManagerModule.startDrag(x, y)
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        spritesheetManagerModule.stopDrag()
    end
end
