love.graphics.setDefaultFilter("nearest", "nearest", 0) -- disable antialiasing for real pixel art
io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

love.window.setMode( 1024, 768)

local mouseHandlerModule = require("mouseHandler")
local editorMenuModule = require("editorMenu")
local dragBoxTestModule = require("dragBoxTest")


function love.load()
    editorMenuModule.createButtonsAtLoading()
end


function love.update()

end

function love.draw()
    editorMenuModule.drawEditorPanel()
    editorMenuModule.drawButtons()

    dragBoxTestModule.drawBox()
end


function love.mousepressed(x, y, button, istouch)
   mouseHandlerModule.loveMousePressed(x, y, button)
end

function love.mousemoved( x, y, dx, dy, istouch )
	mouseHandlerModule.loveMouseMoved(x, y, dx, dy)
end