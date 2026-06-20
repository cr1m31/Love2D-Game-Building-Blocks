io.stdout:setvbuf("no")

local playerMod = require("player")

function love.update(dt)
  playerMod.update(dt)
end

function love.draw()
  playerMod.draw()
end
