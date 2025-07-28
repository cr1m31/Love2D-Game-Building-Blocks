local mapGrid = {}

local gridWidth = 20
local gridHeight = 15
local tileSize = 32

-- Store placed tiles
local gridData = {}

function mapGrid.load()
    for y = 1, gridHeight do
        gridData[y] = {}
        for x = 1, gridWidth do
            gridData[y][x] = nil -- no tile
        end
    end
end

function mapGrid.draw(spriteSheetImage)
    for y = 1, gridHeight do
        for x = 1, gridWidth do
            local tile = gridData[y][x]
            local drawX = x * tileSize
            local drawY = y * tileSize

            if tile then
                love.graphics.draw(spriteSheetImage, tile, drawX, drawY)
            end

            love.graphics.setColor(0.2, 0.2, 0.2)
            love.graphics.rectangle("line", drawX, drawY, tileSize, tileSize)
            love.graphics.setColor(1, 1, 1)
        end
    end
end

function mapGrid.placeTile(x, y, quad)
    local gridX = math.floor(x / tileSize)
    local gridY = math.floor(y / tileSize)

    if gridX >= 1 and gridX <= gridWidth and gridY >= 1 and gridY <= gridHeight then
        gridData[gridY][gridX] = quad
    end
end

return mapGrid
