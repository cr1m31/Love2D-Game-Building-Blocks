io.stdout:setvbuf("no")

local coyoteTimeMod = require("coyote-time")

function love.update(dt)
  coyoteTimeMod.update(dt)
end

function love.draw()
  coyoteTimeMod.draw()
end
