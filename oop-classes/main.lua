-- oop & classes
io.stdout:setvbuf("no")

local objectsMod = require("objects")

function love.load()
  objectsMod.load()
end
