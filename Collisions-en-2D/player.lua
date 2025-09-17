local playerModule = {}

local collisionModule = require("collision")
local gridModule = require("grid")

local player = {
  x = 40,
  y = 30,
  width = 15,
  height = 15,
}

local isColliding = false

function playerModule.update(x, y)
  player.x = x
  player.y = y
  
  isColliding = false
  
  for i, j in ipairs( gridModule.getBuiltTiles() ) do
    if collisionModule.aabbCollision(player, j ) then
      isColliding = true
    end
  end
  
  
end

function playerModule.draw()
  
  if isColliding then
    love.graphics.setColor(1,0,0)
  else
    love.graphics.setColor(1,1,1)
  end
  
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  
  
end

return playerModule