io.stdout:setvbuf("no")
love.window.setMode(1024, 768)
love.graphics.setDefaultFilter("nearest", "nearest")

local tilesetManager = require("tilesetManager")
local mapGrid = require("mapGrid")
local serializeMapDataModule = require("serialize-map-data")
local mouseHandler = require("mouseHandler")
local gateEditor = require("gateEditor")

function love.load()
    tilesetManager.load()
    mapGrid.load()
end

function love.update(dt)
end

function love.draw()
    mapGrid.draw()
    tilesetManager.draw()
    tilesetManager.drawUICheckbox()
    gateEditor.draw()
end

function love.mousepressed(x, y, button)
    if tilesetManager.handleUIClick(x, y) then return end
    gateEditor.mousepressed(x, y, button)
    mouseHandler.mousepressed(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    mouseHandler.mousemoved(x, y, dx, dy)
end

function love.mousereleased(x, y, button)
    gateEditor.mousereleased(x, y, button)
    mouseHandler.mousereleased(x, y, button)
end

function love.keypressed(key)
    if key == "f5" then
        serializeMapDataModule.exportMapToFile(
            "map-1-test.lua",
            "tilesets/tileset.png",
            {
                x = 0,
                y = 0,
                cellWidth = 32,
                cellHeight = 32,
                previousMap = nil
            }
        )
    end
end