love.graphics.setDefaultFilter("nearest", "nearest", 0)
io.stdout:setvbuf("no")

love.window.setMode(1024, 768)

local editorMenuModule = require("editorMenu")
local mouseHandlerModule = require("mouseHandler")

function love.load()
    -- Initialize any additional components here if needed
end

function love.update(dt)
    editorMenuModule.update(dt)
end

function love.draw()
    editorMenuModule.drawMenu()
end

function love.mousepressed(x, y, button)
    if button == 1 then
        mouseHandlerModule.handleClick(x, y)
    end
end