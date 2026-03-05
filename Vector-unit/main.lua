io.stdout:setvbuf("no")

local vectorMod = require("vector")

function love.load()
  vectorMod.init()
end


function love.draw()
  vectorMod.draw()
end