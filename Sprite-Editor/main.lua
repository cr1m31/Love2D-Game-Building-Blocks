io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

love.window.setMode( 1024, 768)

love.graphics.setDefaultFilter("nearest", "nearest") -- disable anti-aliasing globally

local spritesheetManagerModule = require("spritesheetManager")

function love.load()
    spritesheetManagerModule.getTiles()
end

function love.update()

end

function love.draw()
    spritesheetManagerModule.drawEntireSpriteSheet()
end