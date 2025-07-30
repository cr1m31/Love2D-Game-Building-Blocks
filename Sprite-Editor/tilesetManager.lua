local tilesetManager = {}

local tilesetImage
local tiles = {}

-- Config
local tileSize = 32
local spacing = 1
local screenMargin = 0
local tileCols = 10
local tileRows = 6

-- Selection state
local selectionStart = nil
local selectionEnd = nil

local collisionMode = false
local checkbox = {
    x = 0,
    y = 0,
    size = 16
}

-- Tileset image dimensions in pixels
local tilesetWidth = 0
local tilesetHeight = 0

function tilesetManager.load()
    tilesetImage = love.graphics.newImage("tilesets/tileset-01.png")

    tilesetWidth = tileCols * tileSize + (tileCols - 1) * spacing
    tilesetHeight = tileRows * tileSize + (tileRows - 1) * spacing

    -- Position checkbox to right of tileset image, aligned to top of tileset
    checkbox.x = screenMargin + tilesetWidth + 10  -- 10px padding right of tileset
    checkbox.y = screenMargin  -- top aligned with tileset image

    for row = 0, tileRows - 1 do
        for col = 0, tileCols - 1 do
            local quadX = col * (tileSize + spacing)
            local quadY = row * (tileSize + spacing)

            local quad = love.graphics.newQuad(
                quadX, quadY, tileSize, tileSize,
                tilesetImage:getDimensions()
            )

            table.insert(tiles, {
                x = screenMargin + col * (tileSize + spacing),
                y = screenMargin + row * (tileSize + spacing),
                width = tileSize,
                height = tileSize,
                quad = quad,
                col = col,
                row = row,
                id = row * tileCols + col + 1,
                collision = false
            })
        end
    end
end

function tilesetManager.draw()
    for _, tile in ipairs(tiles) do
        love.graphics.draw(tilesetImage, tile.quad, tile.x, tile.y)
        love.graphics.setColor(0.4, 0.4, 0.4)
        love.graphics.rectangle("line", tile.x, tile.y, tile.width, tile.height)

        if tile.collision then
            love.graphics.setColor(1, 0, 0, 0.3)
            love.graphics.rectangle("fill", tile.x, tile.y, tile.width, tile.height)
        end

        love.graphics.setColor(1, 1, 1)
    end

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

    -- Draw collision mode checkbox UI
    tilesetManager.drawUICheckbox()
end

function tilesetManager.drawUICheckbox()
    -- Border
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", checkbox.x, checkbox.y, checkbox.size, checkbox.size)

    -- Fill if enabled
    if collisionMode then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", checkbox.x + 3, checkbox.y + 3, checkbox.size - 6, checkbox.size - 6)
    end

    -- Label
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Collision Mode", checkbox.x + checkbox.size + 6, checkbox.y - 1)
end

function tilesetManager.handleUIClick(x, y)
    if x >= checkbox.x and x <= checkbox.x + checkbox.size and
       y >= checkbox.y and y <= checkbox.y + checkbox.size then
        collisionMode = not collisionMode
        return true
    end
    return false
end

-- ... rest of your existing functions unchanged ...

function tilesetManager.getTileIdFromQuad(quad)
    for _, tile in ipairs(tiles) do
        if tile.quad == quad then
            return tile.id
        end
    end
    return nil
end

function tilesetManager.getQuadById(id)
    for _, tile in ipairs(tiles) do
        if tile.id == id then
            return tile.quad
        end
    end
    return nil
end

function tilesetManager.getTileById(id)
    for _, tile in ipairs(tiles) do
        if tile.id == id then
            return tile
        end
    end
    return nil
end

local function getTileAt(x, y)
    for _, tile in ipairs(tiles) do
        if x >= tile.x and x <= tile.x + tile.width and
           y >= tile.y and y <= tile.y + tile.height then
            return tile
        end
    end
    return nil
end

function tilesetManager.selectTileAt(x, y, isDragging)
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

function tilesetManager.toggleCollisionAt(x, y)
    local tile = getTileAt(x, y)
    if tile then
        tile.collision = not tile.collision
    end
end

function tilesetManager.getSelectedQuads()
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

function tilesetManager.getCollisionSet()
    local set = {}
    for _, tile in ipairs(tiles) do
        set[tile.id] = tile.collision and 1 or 0
    end
    return set
end

function tilesetManager.isCollisionModeEnabled()
    return collisionMode
end

function tilesetManager.getTilesetImage()
    return tilesetImage
end

function tilesetManager.getTilesetOffsetY()
    return screenMargin + tilesetHeight + 10  -- or however much vertical space tileset UI takes
end



return tilesetManager
