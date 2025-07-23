local spritesheetManagerModule = {}

local spriteSheetImage = love.graphics.newImage("spritesheets/spritesheet.png")
local spriteSheetScaleMultiplier = 3
local screenMargin = 0
local tileDimensions = 32
local spacing = 1

function buildSpriteQuads()
    local tiles = {}
    local numberOfRows = 6
    local numberOfColumns = 10

    for row = 1, numberOfRows do
        for col = 1, numberOfColumns do
            local x = screenMargin + ((col - 1) * (tileDimensions + spacing)) + spacing
            local y = screenMargin + ((row - 1) * (tileDimensions + spacing)) + spacing
            table.insert(tiles, { x = x, y = y })
        end
    end
    return tiles
end

local gotTiles = nil
function spritesheetManagerModule.getTiles()
    gotTiles = buildSpriteQuads()
end

function spritesheetManagerModule.drawEntireSpriteSheet()
    -- First draw the spritesheet
    love.graphics.draw(spriteSheetImage, screenMargin, screenMargin, 0, spriteSheetScaleMultiplier, spriteSheetScaleMultiplier)

    -- Then overlay the grid
    if gotTiles then
        for _, tile in ipairs(gotTiles) do
            love.graphics.rectangle(
                "line",
                tile.x * spriteSheetScaleMultiplier,
                tile.y * spriteSheetScaleMultiplier,
                tileDimensions * spriteSheetScaleMultiplier,
                tileDimensions * spriteSheetScaleMultiplier
            )
        end
    end
end

return spritesheetManagerModule
