local mapGrid = {}
local tilesetManager = require("tilesetManager")

local gridWidth = 32
local gridHeight = 24
local tileSize = 32

local gridData = {}
local collisionGrid = {}

function mapGrid.load()
    for y = 1, gridHeight do
        gridData[y] = {}
        collisionGrid[y] = {}
        for x = 1, gridWidth do
            gridData[y][x] = 0
            collisionGrid[y][x] = 0
        end
    end
end

function mapGrid.draw()
    for y = 1, gridHeight do
        for x = 1, gridWidth do
            local tileId = gridData[y][x]
            if tileId and tileId > 0 then
                local quad = tilesetManager.getQuadById(tileId)
                if quad then
                    love.graphics.draw(tilesetManager.getTilesetImage(), quad, x * tileSize, y * tileSize)
                end
            end

            love.graphics.setColor(0.2, 0.2, 0.2)
            love.graphics.rectangle("line", x * tileSize, y * tileSize, tileSize, tileSize)
            love.graphics.setColor(1, 1, 1)
        end
    end
end

function mapGrid.placeTile(x, y, tileId, collisionEnabled)
    local gridX = math.floor(x / tileSize) + 1
    local gridY = math.floor(y / tileSize) + 1

    if gridX < 1 or gridX > gridWidth or gridY < 1 or gridY > gridHeight then
        return
    end

    gridData[gridY][gridX] = tileId or 0

    if collisionEnabled then
        collisionGrid[gridY][gridX] = 1
    else
        collisionGrid[gridY][gridX] = 0
    end
end


function mapGrid.placeTileBlock(x, y, idBlock, collisionEnabled)
    local startGridX = math.floor(x / tileSize) + 1
    local startGridY = math.floor(y / tileSize) + 1

    for row = 1, #idBlock do
        for col = 1, #idBlock[row] do
            local gridX = startGridX + col - 1
            local gridY = startGridY + row - 1

            if gridX >= 1 and gridX <= gridWidth and gridY >= 1 and gridY <= gridHeight then
                gridData[gridY][gridX] = idBlock[row][col]

                if collisionEnabled then
                    collisionGrid[gridY][gridX] = 1
                else
                    collisionGrid[gridY][gridX] = 0
                end
            end
        end
    end
end


function mapGrid.getGridData()
    return gridData
end

function mapGrid.getCollisionGrid()
    return collisionGrid
end

return mapGrid
