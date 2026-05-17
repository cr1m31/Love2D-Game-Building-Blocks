local tilesetManager = require("tilesetManager")
local mapGrid = require("mapGrid")

local mouseHandler = {
    isLeftMouseDown = false,
    isRightMouseDown = false
}

local function placeTileBlock(x, y)
    local block = tilesetManager.getSelectedQuads()
    if block and #block > 0 then
        local idBlock = {}
        for row = 1, #block do
            idBlock[row] = {}
            for col = 1, #block[row] do
                local id = tilesetManager.getTileIdFromQuad(block[row][col]) or 0
                idBlock[row][col] = id
            end
        end
        mapGrid.placeTileBlock(x, y, idBlock, tilesetManager.isCollisionModeEnabled())
    end
end

function mouseHandler.mousepressed(x, y, button)
    if button == 1 then
        if tilesetManager.handleUIClick(x, y) then return end
        mouseHandler.isLeftMouseDown = true
        local selected = tilesetManager.selectTileAt(x, y, false)
        if not selected then placeTileBlock(x, y) end
    elseif button == 2 then
        mouseHandler.isRightMouseDown = true
        mapGrid.placeTile(x, y, 0, tilesetManager.isCollisionModeEnabled())
    elseif button == 3 then
        tilesetManager.toggleCollisionAt(x, y)
    end
end

function mouseHandler.mousemoved(x, y, dx, dy)
    if mouseHandler.isLeftMouseDown then
        local overTilesheet = tilesetManager.selectTileAt(x, y, true)
        if not overTilesheet then placeTileBlock(x, y) end
    elseif mouseHandler.isRightMouseDown then
        mapGrid.placeTile(x, y, 0)
    end
end

function mouseHandler.mousereleased(x, y, button)
    if button == 1 then
        mouseHandler.isLeftMouseDown = false
    elseif button == 2 then
        mouseHandler.isRightMouseDown = false
    end
end

return mouseHandler