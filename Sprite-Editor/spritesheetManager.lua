local spritesheetManagerModule = {}

local spriteSheetImage = love.graphics.newImage("spritesheets/spritesheet.png")
local spriteSheetScaleMultiplier = 1
local screenMargin = 0
local tileSize = 32
local spacing = 1

-- Tiles and quads
local tiles = {}
local tileCols = 10
local tileRows = 6

-- Selection state
local selectionStart = nil
local selectionEnd = nil

function spritesheetManagerModule.getTiles()
    for row = 0, tileRows - 1 do
        for col = 0, tileCols - 1 do
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
                quad = quad,
                col = col,
                row = row,
                id = row * tileCols + col + 1 -- tile ID (1-based)
            })

        end
    end
end

-- ...after tiles table
function spritesheetManagerModule.getTileIdFromQuad(quad)
    for _, tile in ipairs(tiles) do
        if tile.quad == quad then
            return tile.id
        end
    end
    return nil
end

function spritesheetManagerModule.getQuadById(id)
    for _, tile in ipairs(tiles) do
        if tile.id == id then
            return tile.quad
        end
    end
    return nil
end



function spritesheetManagerModule.drawEntireSpriteSheet()
    for _, tile in ipairs(tiles) do
        love.graphics.draw(spriteSheetImage, tile.quad, tile.x, tile.y)
        love.graphics.setColor(0.4, 0.4, 0.4)
        love.graphics.rectangle("line", tile.x, tile.y, tile.width, tile.height)
        love.graphics.setColor(1, 1, 1)
    end

    -- Draw selection
    if selectionStart and selectionEnd then
        local col1 = math.min(selectionStart.col, selectionEnd.col)
        local row1 = math.min(selectionStart.row, selectionEnd.row)
        local col2 = math.max(selectionStart.col, selectionEnd.col)
        local row2 = math.max(selectionStart.row, selectionEnd.row)

        love.graphics.setColor(1, 1, 0)
        for row = row1, row2 do
            for col = col1, col2 do
                local x = screenMargin + col * (tileSize + spacing)
                local y = screenMargin + row * (tileSize + spacing)
                love.graphics.rectangle("line", x - 2, y - 2, tileSize + 4, tileSize + 4)
            end
        end
        love.graphics.setColor(1, 1, 1)
    end
end

-- Get tile under a point
local function getTileAt(x, y)
    for _, tile in ipairs(tiles) do
        if x >= tile.x and x <= tile.x + tile.width and
           y >= tile.y and y <= tile.y + tile.height then
            return tile
        end
    end
    return nil
end

function spritesheetManagerModule.selectTileAt(x, y, isDragging)
    local tile = getTileAt(x, y)
    if tile then
        if not isDragging then
            selectionStart = { col = tile.col, row = tile.row }
        end
        selectionEnd = { col = tile.col, row = tile.row }
        return true
    end
    return false
end

function spritesheetManagerModule.getSelectedQuads()
    if not selectionStart or not selectionEnd then
        return {}
    end

    local col1 = math.min(selectionStart.col, selectionEnd.col)
    local row1 = math.min(selectionStart.row, selectionEnd.row)
    local col2 = math.max(selectionStart.col, selectionEnd.col)
    local row2 = math.max(selectionStart.row, selectionEnd.row)

    local selected = {}

    for row = row1, row2 do
        selected[row - row1 + 1] = {}
        for col = col1, col2 do
            local index = row * tileCols + col + 1
            selected[row - row1 + 1][col - col1 + 1] = tiles[index].quad
        end
    end

    return selected
end

return spritesheetManagerModule
