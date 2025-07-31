io.stdout:setvbuf("no")
love.window.setMode(1024, 768)
love.graphics.setDefaultFilter("nearest", "nearest")

local tilesetManager = require("tilesetManager")
local editorMenu = require("editorMenu")
local gateEditor = require("gateEditor")

function love.load()
    -- Link toggle collision callback from tilesetManager
    editorMenu.toggleCollision = tilesetManager.toggleCollision

    -- Load UI components
    editorMenu.load()

    -- Connect save/load callbacks
    editorMenu.onSave = function()
        print("Saving map (placeholder)...")
        -- Add your save logic here
    end

    editorMenu.onLoad = function()
        print("Loading map (placeholder)...")
        -- Add your load logic here
    end
end

function love.update(dt)
    -- Optional: update logic if needed
end

function love.draw()
    editorMenu.draw()

    if editorMenu.getMode() == "tileset" then
        tilesetManager.draw()
        tilesetManager.drawUICheckbox()
    elseif editorMenu.getMode() == "gates" then
        gateEditor.draw()
    end
end

function love.mousepressed(x, y, button)
    -- Give UI elements priority
    if editorMenu.mousepressed(x, y, button) then return end
    if tilesetManager.mousepressed(x, y, button) then return end

    if editorMenu.getMode() == "tileset" then
        -- Tile editing logic goes here
    elseif editorMenu.getMode() == "gates" then
        gateEditor.mousepressed(x, y, button)
    end
end

function love.mousereleased(x, y, button)
    if editorMenu.mousereleased(x, y, button) then return end
    if tilesetManager.mousereleased(x, y, button) then return end

    if button == 2 then -- Right click deletes gate
        if editorMenu.getMode() == "gates" then
            if gateEditor.deleteGateAt(x, y) then
                print("Gate deleted at", x, y)
            end
        end
    else
        if editorMenu.getMode() == "tileset" then
            tilesetManager.mousereleased(x, y, button)
        elseif editorMenu.getMode() == "gates" then
            gateEditor.mousereleased(x, y, button)
        end
    end
end

function love.mousemoved(x, y, dx, dy)
    if editorMenu.mousemoved(x, y, dx, dy) then return end
    if tilesetManager.mousemoved(x, y, dx, dy) then return end
end
