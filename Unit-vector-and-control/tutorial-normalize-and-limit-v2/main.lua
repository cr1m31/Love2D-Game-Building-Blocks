io.stdout:setvbuf("no") -- show print during game

local playerMod = require("player")

function love.update(dt)
  playerMod.update(dt)
end

function love.draw()
  playerMod.draw()
end
