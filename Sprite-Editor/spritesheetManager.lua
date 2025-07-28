local spritesheetManagerModule = {}

local spriteSheetImage = love.graphics.newImage("spritesheets/spritesheet.png")
local spriteSheetScaleMultiplier = 1
local screenMargin = 0
local tileSize = 32
local spacing = 1

-- Tiles and quads
local tiles = {}
local quads = {}

-- Selected tile
local selectedTileIndex = nil

function spritesheetManagerModule.getTiles()
    local rows = 6
    local cols = 10

    for row = 0, rows - 1 do
        for col = 0, cols - 1 do
            local quadX = col * (tileSize + spacing)
            local quadY = row * (tileSize + spacing)

            local quad = love.graphics.newQuad(
                quadX, quadY, tileSize, tileSize,
                spriteSheetImage:getDimensions()
            )

            table.insert(tiles, {
                x = screenMargin + col * (tileSize + spacing),
                y = screenMargin + row * (tileSize + spacing),
                width = tileSize,
                height = tileSize,
                quad = quad
            })
        end
    end
end

function spritesheetManagerModule.drawEntireSpriteSheet()
    for index, tile in ipairs(tiles) do
        love.graphics.draw(spriteSheetImage, tile.quad, tile.x, tile.y, 0, 1, 1)
        love.graphics.rectangle("line", tile.x, tile.y, tile.width, tile.height)
        
        if selectedTileIndex == index then
            love.graphics.setColor(1, 1, 0) -- yellow
            love.graphics.rectangle("line", tile.x - 2, tile.y - 2, tile.width + 4, tile.height + 4)
            love.graphics.setColor(1, 1, 1)
        end
    end
end

function spritesheetManagerModule.selectTileAt(x, y)
    for index, tile in ipairs(tiles) do
        if x >= tile.x and x <= tile.x + tile.width and y >= tile.y and y <= tile.y + tile.height then
            selectedTileIndex = index
            return true
        end
    end
    return false
end

function spritesheetManagerModule.getSelectedQuad()
    if selectedTileIndex then
        return tiles[selectedTileIndex].quad
    end
    return nil
end

return spritesheetManagerModule
