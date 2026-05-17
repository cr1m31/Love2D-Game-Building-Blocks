io.stdout:setvbuf("no") -- disable output buffering to see debug text immediately

local playerMod = require("player")

function love.update(dt)
  playerMod.update(dt)
end

function love.draw()
  playerMod.draw()
end
