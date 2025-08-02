local editorMenuModule = {}

local mouseHandler = require("mouseHandler")

local menuPanel = {
    x = 10,
    y = 10,
    width = 100,
    height = 150,
}

local menuButtons = {
    tilesetEditor = {
        x = 0,
        y = 0,
        width = 0,
        height = 0,
    },
    gateEditor = {
        x = 0,
        y = 0,
        width = 0,
        height = 0,
    },
    saveButton = {
        x = 0, 
        y = 0,
        width = 0,
        height = 0,
    },
    loadButton = {
        x = 0,
        y = 0,
        width = 0,
        height = 0,
    }
}

local buttonOrder ={
    "tilesetEditor",
    "gateEditor",
    "saveButton",
    "loadButton",
} 

function setButtonsDimensions(width, height)
    for name, button in pairs(menuButtons) do
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

function checkButtonClicks()
    for _, name in ipairs(buttonOrder) do
        local button = menuButtons[name]
        if mouseHandler.checkIfMouseClickedInRectangleAndIsDown(button) then
            print("Button clicked: " .. name)
            -- Trigger button action here, like:
            -- if name == "saveButton" then saveGame() end
        end
    end
end

function editorMenuModule.update(dt)
    mouseHandler.drag(menuPanel)
    attachButtonsToMenuPanel()
    checkButtonClicks()
end

function drawButtons()
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
