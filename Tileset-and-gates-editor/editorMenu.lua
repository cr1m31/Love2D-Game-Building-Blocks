local editorMenuModule = {}

local menuPanel = {
    x = 10,
    y = 10,
    width = 150,
    height = 250,
}

local buttons = {}
function createButton(x, y, width, height, name, action, enabled)
    local button = {
        x = x + menuPanel.x,
        y = y + menuPanel.y,
        width = width,
        height = height,
        name = name,
        action = action,
        enabled = enabled,
    }
    table.insert(buttons, button)
end

function editorMenuModule.createButtonsAtLoading()
    createButton(10,20,60,20,"tileset-editor", "choose-tileset-editor", true)
    createButton(10,60,60,20,"gates-editor", "choose-gates-editor", true)
end

function editorMenuModule.checkIfClickedInButtonRectangle(mousex, mousey)
    for i, button in ipairs(buttons) do
        if mousex > button.x and 
            mousex < button.x + button.width and 
            mousey > button.y and
            mousey < button.y + button.height then
            print("Clicked on " .. button.name .. " button.")
        end
    end
end

function editorMenuModule.checkIfClickedInMenuPanel(mousex, mousey)
    if mousex > menuPanel.x and 
        mousex < menuPanel.x + menuPanel.width and 
        mousey > menuPanel.y and
        mousey < menuPanel.y + menuPanel.height then
        print("Clicked on menu panel" )
    end
end

function editorMenuModule.updateButtons()
    
end

function editorMenuModule.drawEditorPanel()
    love.graphics.rectangle("fill", menuPanel.x, menuPanel.y, menuPanel.width, menuPanel.height)
end

function editorMenuModule.drawButtons()
    for i, button in ipairs(buttons) do
        love.graphics.setColor(0.5,0.5,0.5)
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
        love.graphics.setColor(1,1,1)
    end
end

return editorMenuModule