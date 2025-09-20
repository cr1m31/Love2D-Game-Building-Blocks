local playerModule = {}

local gridModule = require("grid")

local player = {
  x = 20,
  y = 30,
  width = 20,
  height = 40,
}

local playerCollidingWithTile = false

function playerModule.update(x, y)
  player.x = x
  player.y = y
  
  playerCollidingWithTile = gridModule.checkCollisionsBetweenPlayerAndTiles(player)
end

function playerModule.draw()
  if playerCollidingWithTile then
    love.graphics.setColor(1,0,0)
  else
    love.graphics.setColor(1,1,1)
  end
  love.graphics.print(tostring(playerCollidingWithTile), 100, 180 )

  
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

return playerModule