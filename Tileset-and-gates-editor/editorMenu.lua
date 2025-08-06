local editorMenuModule = {}

local mouseHandler = require("mouseHandler")

local menuPanel = {
    x = 10,
    y = 10,
    width = 120,
    height = 180
}

local menuVisible = true

local toggleButtons = {
    hide = { x = 0, y = 0, width = 60, height = 25 },
    show = { x = 0, y = 0, width = 60, height = 25 }
}

local menuButtons = {
    tilesetEditor = { x = 0, y = 0, width = 100, height = 25 },
    gateEditor = { x = 0, y = 0, width = 100, height = 25 },
    saveButton = { x = 0, y = 0, width = 100, height = 25 },
    loadButton = { x = 0, y = 0, width = 100, height = 25 }
}

local buttonOrder = {
    "tilesetEditor",
    "gateEditor",
    "saveButton",
    "loadButton"
}

-- Position toggle and menu buttons
local function positionButtons()
    -- Toggle buttons (to the right of menu)
    toggleButtons.hide.x = menuPanel.x + menuPanel.width + 10
    toggleButtons.hide.y = menuPanel.y

    toggleButtons.show.x = menuPanel.x + menuPanel.width + 10
    toggleButtons.show.y = menuPanel.y

    -- Menu buttons
    if menuVisible then
        local yOffset = menuPanel.y + 10
        for i, name in ipairs(buttonOrder) do
            local button = menuButtons[name]
            button.x = menuPanel.x + menuPanel.width / 2 - button.width / 2
            button.y = yOffset + (button.height + 5) * (i - 1)
        end
    end
end

local function checkButtonClicks()
    -- Toggle
    if menuVisible and mouseHandler.checkIfMousePressedInRectangle(toggleButtons.hide) then
        menuVisible = false
        return
    elseif not menuVisible and mouseHandler.checkIfMousePressedInRectangle(toggleButtons.show) then
        menuVisible = true
        return
    end

    -- Menu buttons
    if menuVisible then
        for _, name in ipairs(buttonOrder) do
            local button = menuButtons[name]
            if mouseHandler.checkIfMousePressedInRectangle(button) then
                print("Button clicked: " .. name)
                -- Add specific button logic here
            end
        end
    end
end

local function drawButton(button, label)
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(label, button.x + 5, button.y + 5)
end

function editorMenuModule.update(dt)
    positionButtons()
    checkButtonClicks()
end

function editorMenuModule.drawMenu()
    if menuVisible then
        -- Draw menu panel and its buttons
        love.graphics.setColor(0.5, 0.5, 0.8)
        love.graphics.rectangle("fill", menuPanel.x, menuPanel.y, menuPanel.width, menuPanel.height)

        for _, name in ipairs(buttonOrder) do
            drawButton(menuButtons[name], name)
        end
    end

    -- Always draw the relevant toggle button
    if menuVisible then
        drawButton(toggleButtons.hide, "Hide")
    else
        drawButton(toggleButtons.show, "Show")
    end
end

return editorMenuModule
