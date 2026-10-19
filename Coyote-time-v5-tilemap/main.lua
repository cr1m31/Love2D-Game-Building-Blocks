io.stdout:setvbuf("no")

local playerMod = require("player")
local tilemapMod = require("tilemap")

function love.load()
  playerMod.load()
  
  tilemapMod.load()
end

function love.update(dt)
  playerMod.update(dt)
end

function love.draw()
  playerMod.draw()
  
  tilemapMod.draw()
end
