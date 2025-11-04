local playerModule = {}

local vectorLogic = require("vectorLogic")

local player = {
  x = 100,
  y = 200,
  width = 40,
  height = 60,
  velocity = {x = 0, y = 0},
  acceleration = 2
}

function movePlayer(dt)
local inputX, inputY = getVectorInputDirection()
  inputX, inputY = vectorLogic.getNormalizedVector(inputX, inputY)

  player.velocity.x = player.velocity.x + inputX * player.acceleration * dt
  player.velocity.y = player.velocity.y + inputY * player.acceleration * dt
end

function getVectorInputDirection()
  local dx, dy = 0, 0
  if love.keyboard.isDown("a") then 
    dx = dx - 1 end
  if love.keyboard.isDown("d") then 
    dx = dx + 1 end
  if love.keyboard.isDown("w") then 
    dy = dy - 1 end
  if love.keyboard.isDown("s") then 
    dy = dy + 1 end
  return dx, dy
end

function playerModule.getPlayerAttributes()
  return player
end

function playerModule.update(dt)
  movePlayer(dt)
  
  vectorLogic.update(player)
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
end

return playerModule