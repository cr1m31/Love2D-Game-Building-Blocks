io.stdout:setvbuf("no")

local vectorMod = require("vector")

function love.load()
  vectorMod.load()
end

function love.draw()
  vectorMod.draw()
end