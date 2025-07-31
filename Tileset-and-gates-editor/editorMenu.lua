local editorMenu = {}

local buttons = {}
local dragging = false
local dragOffsetX, dragOffsetY = 0, 0

local x, y = 10, 10
local width, height = 200, 270

local mode = "tileset" -- or "gates"

editorMenu.onSave = nil
editorMenu.onLoad = nil

local function newButton(text, bx, by, bw, bh, onClick)
    return {
        text = text,
        x = bx,
        y = by,
        width = bw,
        height = bh,
        onClick = onClick
    }
end

function editorMenu.load()
    buttons = {
        newButton("Tileset Editor", 10, 10, 180, 30, function() mode = "tileset" end),
        newButton("Gate Editor", 10, 50, 180, 30, function() mode = "gates" end),
        newButton("Collision Checkbox", 10, 90, 180, 30, function()
            -- This toggles collision mode in tilesetManager
            if editorMenu.toggleCollision then
                editorMenu.toggleCollision()
            end
        end),
        newButton("Save Map", 10, 130, 180, 30, function()
            if editorMenu.onSave then editorMenu.onSave() end
        end),
        newButton("Load Map", 10, 170, 180, 30, function()
            if editorMenu.onLoad then editorMenu.onLoad() end
        end),
    }
end

function editorMenu.draw()
    -- Draw the menu frame
    love.graphics.setColor(0.15, 0.15, 0.15, 0.9)
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", x, y, width, height)

    -- Draw buttons
    for _, b in ipairs(buttons) do
        local bx, by = x + b.x, y + b.y
        love.graphics.setColor(0.25, 0.25, 0.25)
        love.graphics.rectangle("fill", bx, by, b.width, b.height)

        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", bx, by, b.width, b.height)

        love.graphics.printf(b.text, bx, by + 8, b.width, "center")
    end

    -- Draw current mode text
    love.graphics.print("Mode: " .. mode, x + 10, y + height - 30)
end

function editorMenu.mousepressed(mx, my, button)
    if button ~= 1 then return false end

    if mx >= x and mx <= x + width and my >= y and my <= y + height then
        -- Clicked inside menu - check buttons
        for _, b in ipairs(buttons) do
            local bx, by = x + b.x, y + b.y
            if mx >= bx and mx <= bx + b.width and my >= by and my <= by + b.height then
                b.onClick()
                return true
            end
        end

        -- If no button clicked, start dragging menu
        dragging = true
        dragOffsetX = mx - x
        dragOffsetY = my - y
        return true
    end

    return false
end

function editorMenu.mousereleased(mx, my, button)
    if button == 1 and dragging then
        dragging = false
        return true
    end
    return false
end

function editorMenu.mousemoved(mx, my, dx, dy)
    if dragging then
        x = mx - dragOffsetX
        y = my - dragOffsetY
        -- Clamp menu position inside window (optional)
        x = math.max(0, math.min(x, love.graphics.getWidth() - width))
        y = math.max(0, math.min(y, love.graphics.getHeight() - height))
        return true
    end
    return false
end

function editorMenu.getMode()
    return mode
end

return editorMenu
