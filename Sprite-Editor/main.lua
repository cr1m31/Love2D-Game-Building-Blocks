io.stdout:setvbuf("no")
love.window.setMode(1024, 768)
love.graphics.setDefaultFilter("nearest", "nearest")

local spritesheetManager = require("spritesheetManager")
local mapGrid = require("mapGrid")

local spriteSheetImage
local isLeftMouseDown = false
local isRightMouseDown = false

function love.load()
    spriteSheetImage = love.graphics.newImage("spritesheets/spritesheet.png")
    spritesheetManager.getTiles()
    mapGrid.load()
end

function love.update(dt)
end

function love.draw()
    mapGrid.draw(spriteSheetImage)
    spritesheetManager.drawEntireSpriteSheet()
end

function love.mousepressed(x, y, button)
    if button == 1 then
        isLeftMouseDown = true
        local selected = spritesheetManager.selectTileAt(x, y, false)
        if not selected then
            local block = spritesheetManager.getSelectedQuads()
            if block and #block > 0 then
                -- Convert block of quads to block of IDs
                local idBlock = {}
                for row = 1, #block do
                    idBlock[row] = {}
                    for col = 1, #block[row] do
                        idBlock[row][col] = spritesheetManager.getTileIdFromQuad(block[row][col]) or 0
                    end
                end
                mapGrid.placeTileBlock(x, y, idBlock)
            end
        end
    elseif button == 2 then
        isRightMouseDown = true
        mapGrid.placeTile(x, y, 0)
    end
end

function love.mousemoved(x, y, dx, dy)
    if isLeftMouseDown then
        local overTilesheet = spritesheetManager.selectTileAt(x, y, true)
        if not overTilesheet then
            local block = spritesheetManager.getSelectedQuads()
            if block and #block > 0 then
                local idBlock = {}
                for row = 1, #block do
                    idBlock[row] = {}
                    for col = 1, #block[row] do
                        idBlock[row][col] = spritesheetManager.getTileIdFromQuad(block[row][col]) or 0
                    end
                end
                mapGrid.placeTileBlock(x, y, idBlock)
            end
        end
    elseif isRightMouseDown then
        mapGrid.placeTile(x, y, 0)
    end
end


function love.mousereleased(x, y, button)
    if button == 1 then
        isLeftMouseDown = false
    elseif button == 2 then
        isRightMouseDown = false
    end
end


local function tableToString(tbl)
    local result = "{\n"
    for _, row in ipairs(tbl) do
        result = result .. "  {" .. table.concat(row, ",") .. "},\n"
    end
    return result .. "}"
end

local function exportMapToFile(filename, texturePath)
    local fullPath = "maps/" .. filename

    -- Make sure the "maps" folder exists (outside LÖVE's sandbox)
    os.execute("mkdir maps")  -- Windows-safe

    local file, err = io.open(fullPath, "w")
    if not file then
        print("Error saving map:", err)
        return
    end

    local tiles = mapGrid.getGridData()

    local mapTable = "return {\n" ..
        "  texturePath = \"" .. texturePath .. "\",\n" ..
        "  map = {\n" ..
        "    x = 0,\n" ..
        "    y = 0,\n" ..
        "    cellWidth = 32,\n" ..
        "    cellHeight = 32,\n" ..
        "    previousMap = nil\n" ..
        "  },\n\n" ..
        "  collisionTiles = " .. tableToString(tiles) .. ",\n\n" ..
        "  tiles = " .. tableToString(tiles) .. ",\n" ..
        "}\n"

    file:write(mapTable)
    file:close()

    print("Map saved to:", fullPath)
end


-- Press F5 to export map
function love.keypressed(key)
    if key == "f5" then
        exportMapToFile("map-1-test.lua", "spritesheets/spritesheet.png")
    end
end

print("Save path:", love.filesystem.getSaveDirectory())