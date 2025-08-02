local editorMenuModule = {}

local mouseHandler = require("mouseHandler")

local menuPanel = {
    x = 10,
    y = 10,
    width = 100,
    height = 150,
}

local menuButtons = {
    tileEditor = {
        x = 0,
        y = 0,
        width = 60,
        height = 30,
    },
    gateEditor = {
        x = 0,
        y = 0,
        width = 60,
        height = 30,
    },
    saveButton = {
        x = 0, 
        y = 0,
        width = 60,
        height = 30,
    },
    loadButton = {
        x = 0,
        y = 0,
        width = 60,
        height = 30,
    }
}

for name, button in pairs(menuButtons) do

    print("name: " .. name .. " width: " .. button.width)
end

function editorMenuModule.update(dt)
    mouseHandler.drag(menuPanel)
end

function editorMenuModule.drawMenu()
    love.graphics.setColor(0.5, 0.5, 0.8)
    love.graphics.rectangle("fill", menuPanel.x, menuPanel.y, menuPanel.width, menuPanel.height)
end

function editorMenuModule.getMenuPanel()
    return menuPanel
end

return editorMenuModule
