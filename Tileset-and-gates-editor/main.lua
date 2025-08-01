love.graphics.setDefaultFilter("nearest", "nearest", 0) -- disable antialiasing for real pixel art
io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

love.window.setMode( 1024, 768)

local buttonsModule = require("buttons")
local mouseHandlerModule = require("mouseHandler")

function love.load()
    buttonsModule.createButtonsAtLoading()
end


function love.update()

end

function love.draw()
    buttonsModule.drawButtons()
end


function love.mousepressed(x, y, button, istouch)
   mouseHandlerModule.loveMousePressed(x, y, button)
end