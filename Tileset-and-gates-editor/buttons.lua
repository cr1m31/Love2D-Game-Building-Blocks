local buttonsModule = {}

local buttons = {}
function createButton(x, y, width, height, name, action, enabled)
    local button = {
        x = x,
        y = y,
        width = width,
        height = height,
        name = name,
        action = action,
        enabled = enabled,
    }
    table.insert(buttons, button)
end

function buttonsModule.createButtonsAtLoading()
    createButton(10,20,20,60,"tileset-editor", "choose-tileset-editor", true)
end

function buttonsModule.checkIfClickedInButtonRectangle(mousex, mousey)
    for i, button in ipairs(buttons) do
        if mousex > button.x and 
            mousex < button.x + button.width and 
            mousey > button.y and
            mousey < button.y + button.height then
            print("Clicked on " .. button.name .. " button.")
        else
            print("clicked on no button")
        end

    end
end

function buttonsModule.updateButtons()
    
end

function buttonsModule.drawButtons()
    for i, button in ipairs(buttons) do
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
    end
end

return buttonsModule