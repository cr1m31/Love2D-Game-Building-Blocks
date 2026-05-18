local serializeMapDataModule = {}

local mapGrid = require("mapGrid")
local tilesetManager = require("tilesetManager")
local gateEditor = require("gateEditor")

local function tableToString(tbl)
    local result = "{\n"
    for _, row in ipairs(tbl) do
        result = result .. "  {" .. table.concat(row, ",") .. "},\n"
    end
    return result .. "}"
end

local function serializeTable(tbl, indent)
    indent = indent or "  "
    local str = "{\n"
    for k, v in pairs(tbl) do
        str = str .. indent .. tostring(k) .. " = "
        if type(v) == "table" then
            str = str .. serializeTable(v, indent .. "  ")
        elseif type(v) == "string" then
            str = str .. string.format("\"%s\",\n", v)
        else
            str = str .. tostring(v) .. ",\n"
        end
    end
    return str .. indent:sub(1, -3) .. "},\n"
end

function serializeMapDataModule.exportMapToFile(filename, texturePath, mapProperties)
    local fullPath = "maps/" .. filename
    os.execute("mkdir maps")
    local file, err = io.open(fullPath, "w")
    if not file then print("Error saving map:", err) return end

    local tileGrid = mapGrid.getGridData()
    local collisionGrid = mapGrid.getCollisionGrid()
    local gates = gateEditor.getGates()

    local mapTable = "return {\n" ..
        "  texturePath = \"" .. texturePath .. "\",\n" ..
        "  map = {\n" ..
        "    x = " .. (mapProperties.x or 0) .. ",\n" ..
        "    y = " .. (mapProperties.y or 0) .. ",\n" ..
        "    cellWidth = " .. (mapProperties.cellWidth or 32) .. ",\n" ..
        "    cellHeight = " .. (mapProperties.cellHeight or 32) .. ",\n" ..
        "    previousMap = " .. (mapProperties.previousMap and "\"" .. mapProperties.previousMap .. "\"" or "nil") .. "\n" ..
        "  },\n\n" ..
        "  collisionTiles = " .. tableToString(collisionGrid) .. ",\n\n" ..
        "  tiles = " .. tableToString(tileGrid) .. ",\n\n" ..
        "  gates = " .. serializeTable(gates, "  ") .. "\n" ..
        "}\n"

    file:write(mapTable)
    file:close()
    print("Map saved to:", fullPath)
end

return serializeMapDataModule