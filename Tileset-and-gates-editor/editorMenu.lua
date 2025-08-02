local editorMenuModule = {}

local mouseHandler = require("mouseHandler")

local menuPanel = {
    x = 10,
    y = 10,
    width = 100,
    height = 150,
}

local menuButtons = {
    tilesetEditor = { x = 0, y = 0, width = 0, height = 0 },
    gateEditor = { x = 0, y = 0, width = 0, height = 0 },
    saveButton = { x = 0, y = 0, width = 0, height = 0 },
    loadButton = { x = 0, y = 0, width = 0, height = 0 }
}

local buttonOrder = {
    "tilesetEditor",
    "gateEditor",
    "saveButton",
    "loadButton",
}

function setButtonsDimensions(width, height)
    for _, button in pairs(menuButtons) do
        button.width = width
        button.height = height
    end
end

setButtonsDimensions(80, 25)

function attachButtonsToMenuPanel()
    for i, name in ipairs(buttonOrder) do
        local button = menuButtons[name]
        button.x = menuPanel.x + menuPanel.width / 2 - button.width / 2
        button.y = menuPanel.y + 10 + (button.height + 5) * (i - 1)
    end
end

-- Unified function to check clicks and handle button actions
function checkButtons()
    local clickedOnAny = false
    for _, name in ipairs(buttonOrder) do
        local button = menuButtons[name]
        if mouseHandler.checkIfMouseClickedInRectangleAndIsDown(button) then
            print("Button clicked: " .. name)
            -- Add button-specific actions here, e.g.:
            -- if name == "saveButton" then saveGame() end
            clickedOnAny = true
        end
    end
    return clickedOnAny
end

function editorMenuModule.update(dt)
    attachButtonsToMenuPanel()

    if not checkButtons() then
        mouseHandler.drag(menuPanel)
    end
end

local function drawButtons()
    for _, name in ipairs(buttonOrder) do
        local button = menuButtons[name]
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(name, button.x + 5, button.y + 5) -- small padding for text
    end
end

function editorMenuModule.drawMenu()
    love.graphics.setColor(0.5, 0.5, 0.8)
    love.graphics.rectangle("fill", menuPanel.x, menuPanel.y, menuPanel.width, menuPanel.height)
    drawButtons()
end

function editorMenuModule.getMenuPanel()
    return menuPanel
end

return editorMenuModule
