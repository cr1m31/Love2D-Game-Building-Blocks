io.stdout:setvbuf("no")

local buttonsModule = require("buttons")

function love.draw()
    buttonsModule.drawButtons()
end

function love.mousepressed(x, y, button, istouch)
    buttonsModule.mousepressed(x, y, button, istouch)
end