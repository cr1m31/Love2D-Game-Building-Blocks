io.stdout:setvbuf("no") -- enable print output while playing

local playerMod = require("player")

function love.update(dt)
  playerMod.update(dt)
end

function love.draw()
  playerMod.draw()
end
