-- oop & classes
io.stdout:setvbuf("no")

local objectsMod = require("objects")

local objectsMod2 = require("objects-2")

local objectsMod3 = require("objects-3")

local objectsMod4 = require("objects-4")



function love.load()
  objectsMod.load()
  
  objectsMod2.test()
  
  objectsMod3.moduleFunction()
  
  objectsMod4.load()
end


function love.draw()
  objectsMod3.draw()
  objectsMod4.draw()
end

