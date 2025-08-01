local editorMenuModule = {}

local menuPanel = {
    x = 10,
    y = 10,
    width = 100,
    height = 150,

}

function editorMenuModule.drawMenu()
    love.graphics.rectangle("line", menuPanel.x, menuPanel.y, menuPanel.width, menuPanel.height)
end

return editorMenuModule