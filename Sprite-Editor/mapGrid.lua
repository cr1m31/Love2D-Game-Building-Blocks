local mapGrid = {}

local gridWidth = 32
local gridHeight = 24
local tileSize = 32

local gridData = {}

function mapGrid.load()
    for y = 1, gridHeight do
        gridData[y] = {}
        for x = 1, gridWidth do
            gridData[y][x] = 0
        end
    end
end

function mapGrid.draw(spriteSheetImage)
    for y = 1, gridHeight do
        for x = 1, gridWidth do
            local tileId = gridData[y][x]
            if tileId and tileId > 0 then
                local quad = require("spritesheetManager").getQuadById(tileId)
                if quad then
                    love.graphics.draw(spriteSheetImage, quad, x * tileSize, y * tileSize)
                end
            end

            love.graphics.setColor(0.2, 0.2, 0.2)
            love.graphics.rectangle("line", x * tileSize, y * tileSize, tileSize, tileSize)
            love.graphics.setColor(1, 1, 1)
        end
    end
end

function mapGrid.placeTile(x, y, tileId)
    local gridX = math.floor(x / tileSize)
    local gridY = math.floor(y / tileSize)

    if gridX < 1 or gridX > gridWidth or gridY < 1 or gridY > gridHeight then
        return
    end

    gridData[gridY][gridX] = tileId or 0
end

function mapGrid.placeTileBlock(x, y, block)
    local gridX = math.floor(x / tileSize)
    local gridY = math.floor(y / tileSize)

    for row = 1, #block do
        for col = 1, #block[row] do
            local tx = gridX + col - 1
            local ty = gridY + row - 1

            if tx >= 1 and tx <= gridWidth and ty >= 1 and ty <= gridHeight then
                gridData[ty][tx] = block[row][col] or 0
            end
        end
    end
end

function mapGrid.getGridData()
    return gridData
end

return mapGrid
