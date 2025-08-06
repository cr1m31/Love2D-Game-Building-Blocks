local mouseHandlerModule = {}
local editorMenu = require("editorMenu")

function mouseHandlerModule.isInsideRectangle(x, y, rect)
    return x > rect.x and x < rect.x + rect.width and
           y > rect.y and y < rect.y + rect.height
end

function mouseHandlerModule.handleClick(x, y)
    local elements = editorMenu.getClickableElements()
    
    -- Toggle buttons
    if elements.menuVisible and mouseHandlerModule.isInsideRectangle(x, y, elements.toggleButtons.hide) then
        editorMenu.toggleMenu()
        return
    elseif not elements.menuVisible and mouseHandlerModule.isInsideRectangle(x, y, elements.toggleButtons.show) then
        editorMenu.toggleMenu()
        return
    end

    -- Menu buttons
    if elements.menuVisible then
        for _, name in ipairs(elements.buttonOrder) do
            local button = elements.menuButtons[name]
            if mouseHandlerModule.isInsideRectangle(x, y, button) then
                editorMenu.handleMenuButtonClick(name)
                return
            end
        end
    end
end

return mouseHandlerModule