local playerModule = {}

local vectorLogic = require("vectorLogic")

local player = {
  x = 100,
  y = 200,
  width = 40,
  height = 60,
  velocity = {x = 0, y = 0},
  acceleration = 200,
  velocityLimit = {x = 50, y = 50}
}

function movePlayer(dt)
  local inputX, inputY = getInputDirectionVector()

  inputX, inputY = vectorLogic.getNormalizedVector(inputX, inputY)

  player.velocity.x = player.velocity.x + inputX * player.acceleration * dt
  player.velocity.y = player.velocity.y + inputY * player.acceleration * dt

  player.x = player.x + player.velocity.x * dt
  player.y = player.y + player.velocity.y * dt
  
end

function getInputDirectionVector()
  local dx, dy = 0, 0
  
  if love.keyboard.isDown("a") then 
    dx = dx - 1 
  end
  if love.keyboard.isDown("d") then 
    dx = dx + 1 
  end
  if love.keyboard.isDown("w") then 
    dy = dy - 1 
  end
  if love.keyboard.isDown("s") then 
    dy = dy + 1 
  end
  
  return dx, dy
end

function playerModule.getPlayerAttributes()
  return player
end

function playerModule.update(dt)
  movePlayer(dt)
  
  vectorLogic.limitVelocity(player)
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print("velx : " .. player.velocity.x .. " vely : " .. player.velocity.y, 250, 400)
end

return playerModule