io.stdout:setvbuf("no")

local menuTestModule = require("menuTest")

function love.draw()
  menuTestModule.draw()
end

function love.mousepressed(x, y, button)
  menuTestModule.mousepressed(x, y, button)
end