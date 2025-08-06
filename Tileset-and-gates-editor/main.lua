love.graphics.setDefaultFilter("nearest", "nearest", 0)
io.stdout:setvbuf("no")
love.window.setMode(1024, 768)

local mouseHandlerModule = require("mouseHandler")
local editorMenuModule = require("editorMenu")

function love.load()
end

function love.update(dt)
    mouseHandlerModule.update()
    editorMenuModule.update(dt)
end

function love.draw()
    editorMenuModule.drawMenu()
end
