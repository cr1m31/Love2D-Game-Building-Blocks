local serializeMapDataModule = {}

local mapGrid = require("mapGrid")
local tilesetManager = require("tilesetManager")

local function tableToString(tbl)
    local result = "{\n"
    for _, row in ipairs(tbl) do
        result = result .. "  {" .. table.concat(row, ",") .. "},\n"
    end
    return result .. "}"
end

local function flatCollisionMapFromTileGrid(grid)
    local collisionSet = tilesetManager.getCollisionSet()
    local result = {}

    for y = 1, #grid do
        result[y] = {}
        for x = 1, #grid[y] do
            local tileId = grid[y][x]
            result[y][x] = collisionSet[tileId] or 0
        end
    end

    return result
end

function serializeMapDataModule.exportMapToFile(filename, texturePath)
    local fullPath = "maps/" .. filename
    os.execute("mkdir maps") -- Windows-safe
    local file, err = io.open(fullPath, "w")
    if not file then
        print("Error saving map:", err)
        return
    end

    local tileGrid = mapGrid.getGridData()
    local collisionGrid = flatCollisionMapFromTileGrid(tileGrid)

    local mapTable = "return {\n" ..
        "  texturePath = \"" .. texturePath .. "\",\n" ..
        "  map = {\n" ..
        "    x = 0,\n" ..
        "    y = 0,\n" ..
        "    cellWidth = 32,\n" ..
        "    cellHeight = 32,\n" ..
        "    previousMap = nil\n" ..
        "  },\n\n" ..
        "  collisionTiles = " .. tableToString(collisionGrid) .. ",\n\n" ..
        "  tiles = " .. tableToString(tileGrid) .. ",\n" ..
        "}\n"

    file:write(mapTable)
    file:close()

    print("Map saved to:", fullPath)
end

return serializeMapDataModule
