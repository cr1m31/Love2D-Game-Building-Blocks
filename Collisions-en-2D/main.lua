io.stdout:setvbuf("no")

local gridModule = require("grid")

function love.draw()
  gridModule.draw()
end