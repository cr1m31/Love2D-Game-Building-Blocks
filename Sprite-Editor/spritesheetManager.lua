local spritesheetManagerModule = {}

local spriteSheetImage = love.graphics.newImage("spritesheets/spritesheet.png")
local spriteSheetScaleMultiplier = 1
local screenMargin = 0
local tileDimensions = 32
local spacing = 1

-- Tile storage
local gotTiles = nil

-- Drag state
local draggedTile = nil
local dragOffsetX, dragOffsetY = 0, 0
local isDragging = false

-- Create tiles
local function buildSpriteQuads()
    local tiles = {}
    local numberOfRows = 6
    local numberOfColumns = 10

    for row = 1, numberOfRows do
        for col = 1, numberOfColumns do
            local x = screenMargin + ((col - 1) * (tileDimensions + spacing)) + spacing
            local y = screenMargin + ((row - 1) * (tileDimensions + spacing)) + spacing
            local width = tileDimensions
            local height = tileDimensions
            table.insert(tiles, { x = x, y = y, width = width, height = height })
        end
    end
    return tiles
end

function spritesheetManagerModule.getTiles()
    gotTiles = buildSpriteQuads()
end

function spritesheetManagerModule.drawEntireSpriteSheet()
    love.graphics.draw(spriteSheetImage, screenMargin, screenMargin, 0, spriteSheetScaleMultiplier, spriteSheetScaleMultiplier)

    if gotTiles then
        for _, tile in ipairs(gotTiles) do
            love.graphics.rectangle("line", tile.x, tile.y, tile.width, tile.height)
        end
    end
end

-- Utility: check if point is inside a tile
local function pointInTile(px, py, tile)
    return px >= tile.x and px <= tile.x + tile.width and
           py >= tile.y and py <= tile.y + tile.height
end

-- Called from main.lua when mouse is pressed
function spritesheetManagerModule.startDrag(x, y)
    if not gotTiles then return end

    for _, tile in ipairs(gotTiles) do
        if pointInTile(x, y, tile) then
            draggedTile = tile
            dragOffsetX = x - tile.x
            dragOffsetY = y - tile.y
            isDragging = true
            break
        end
    end
end

-- Called from main.lua when mouse is released
function spritesheetManagerModule.stopDrag()
    draggedTile = nil
    isDragging = false
end

-- Called from main.lua's update
function spritesheetManagerModule.updateDrag()
    if isDragging and draggedTile then
        local x, y = love.mouse.getX(), love.mouse.getY()
        draggedTile.x = x - dragOffsetX
        draggedTile.y = y - dragOffsetY
    end
end

return spritesheetManagerModule
