io.stdout:setvbuf("no") 

local vecrorMod = require("vector")

function love.draw()
  vecrorMod.draw()
end

function love.keypressed(key, scan, isrepeat)
  if key == "i" then
    vecrorMod.initializeVector(3, 4)
  end 
  if key == "n" then
    vecrorMod.normalizeVector()
  end
end
