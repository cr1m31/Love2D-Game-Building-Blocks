io.stdout:setvbuf("no")
love.window.setMode(1024, 768)
love.graphics.setDefaultFilter("nearest", "nearest")

local spritesheetManager = require("spritesheetManager")
local mapGrid = require("mapGrid")

function love.load()
    spritesheetManager.getTiles()
    mapGrid.load()
end

function love.update(dt)
    -- nothing for now
end

function love.draw()
    mapGrid.draw(love.graphics.newImage("spritesheets/spritesheet.png"))
    spritesheetManager.drawEntireSpriteSheet()
end

function love.mousepressed(x, y, button)
    if button == 1 then
        -- First check if clicked on spritesheet
        local selected = spritesheetManager.selectTileAt(x, y)
        if not selected then
            local quad = spritesheetManager.getSelectedQuad()
            if quad then
                mapGrid.placeTile(x, y, quad)
            end
        end
    end
end
