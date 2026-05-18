io.stdout:setvbuf("no") -- disable output buffering to see debug text immediately

local playerModule = require("player")

function love.update(dt)
    playerModule.update(dt)
end

function love.draw()
    playerModule.draw()
end
