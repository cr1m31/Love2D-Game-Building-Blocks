love.graphics.setDefaultFilter("nearest", "nearest", 0) -- disable antialiasing for real pixel art
io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

love.window.setMode( 1024, 768)

local mouseHandlerModule = require("mouseHandler")
local editorMenuModule = require("editorMenu") 

function love.load()
    
end


function love.update(dt)
    editorMenuModule.update(dt)
end

function love.draw()
    editorMenuModule.drawMenu()
end

function love.mousepressed(x, y, button)
    mouseHandlerModule.mousepressed(x, y, button)
end


