io.stdout:setvbuf("no") 

local vecrorMod = require("vector")

function love.update()
  vecrorMod.update()
end

function love.draw()
  vecrorMod.draw()
end