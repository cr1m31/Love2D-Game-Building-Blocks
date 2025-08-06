love.graphics.setDefaultFilter("nearest", "nearest", 0)
io.stdout:setvbuf("no")

love.window.setMode(1024, 768)

local mouseHandlerModule = require("mouseHandler")
local editorMenuModule = require("editorMenu")

function love.load()
end

function love.update(dt)
    editorMenuModule.update(dt)
    mouseHandlerModule.update()  -- move this AFTER menu update
end


function love.draw()
    editorMenuModule.drawMenu()
end

function love.mousepressed(x, y, button)
    mouseHandlerModule.mousepressed(x, y, button)
end
