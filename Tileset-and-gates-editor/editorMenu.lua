local editorMenuModule = {}

local mouseHandler = require("mouseHandler")

local menuPanel = {
    x = 10,
    y = 10,
    width = 140,
    height = 200
}

local menuVisible = true

local toggleButton = {
    x = 0, y = 0, width = 60, height = 25,
    label = "Hide"
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
    -- Toggle button is always shown to the right of the menu
    toggleButton.x = menuPanel.x + menuPanel.width + 10
    toggleButton.y = menuPanel.y

    if menuVisible then
        local yOffset = menuPanel.y + 10
        for i, name in ipairs(buttonOrder) do
            local button = menuButtons[name]
            button.x = menuPanel.x + menuPanel.width / 2 - button.width / 2
            button.y = yOffset + (button.height + 5) * (i - 1)
        end
    end
end

-- Handle button clicks
local function checkButtonClicks()
    -- Toggle menu visibility
    if mouseHandler.checkIfMouseClickedInRectangle(toggleButton) then
        menuVisible = not menuVisible
        toggleButton.label = menuVisible and "Hide" or "Show"
    end

    -- Only check menu buttons if menu is visible
    if menuVisible then
        for _, name in ipairs(buttonOrder) do
            local button = menuButtons[name]
            if mouseHandler.checkIfMouseClickedInRectangle(button) then
                print("Button clicked:", name)
                -- Add your specific logic here for each button
            end
        end
    end
end

-- Draw button helper
local function drawButton(button, label)
    love.graphics.setColor(0.4, 0.4, 0.4)
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(label, button.x + 5, button.y + 5)
end

function editorMenuModule.update(dt)
    positionButtons()
    checkButtonClicks()
end

function editorMenuModule.drawMenu()
    -- Always draw toggle button
    drawButton(toggleButton, toggleButton.label)

    -- Draw menu only if visible
    if menuVisible then
        love.graphics.setColor(0.5, 0.5, 0.8)
        love.graphics.rectangle("fill", menuPanel.x, menuPanel.y, menuPanel.width, menuPanel.height)

        for _, name in ipairs(buttonOrder) do
            drawButton(menuButtons[name], name)
        end
    end
end

return editorMenuModule
