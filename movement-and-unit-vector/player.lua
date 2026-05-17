local playerModule = {}

local vectorMod = require("vector")

local player = {
  x = 0,
  y = 0,
  width = 20,
  height = 40,
  velocity = {x = 0, y = 0},
  maxVelocity = 1,
  acceleration = 3
}

function rawPlayerInput()
  local xMove, yMove = 0, 0
  
  if love.keyboard.isDown("a") then
    xMove = -1
  end
  if love.keyboard.isDown("d") then
    xMove = 1
  end
  if love.keyboard.isDown("w") then
    yMove = -1
  end
  if love.keyboard.isDown("s") then
    yMove = 1
  end
  return xMove, yMove
end

function playerMove(dt)
  local inputX, inputY = rawPlayerInput()
  
  player.velocity.x = player.velocity.x + inputX * player.acceleration * dt
  player.velocity.y = player.velocity.y + inputY * player.acceleration * dt
  
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y
end

function playerModule.load()
  player.x = 200
  player.y = 100
end

function playerModule.update(dt)
  
  playerMove(dt)
  
  vectorMod.normalizeVector(player.x, player.y)
  
  vectorMod.limitVelocity(player)
  
end

local scalingVectorVisually = 30
function playerModule.draw()
  love.graphics.print("vel x : " .. player.velocity.x .. "\nvel y : " .. player.velocity.y, 100, 100)
  love.graphics.rectangle("line", math.floor(player.x), math.floor(player.y), player.width, player.height)
  
  -- draw velocity
  local playerCenter = {x = player.x + player.width * 0.5, y = player.y + player.height * 0.5}
  
  love.graphics.line(playerCenter.x, playerCenter.y, playerCenter.x + player.velocity.x * scalingVectorVisually, playerCenter.y + player.velocity.y * scalingVectorVisually)
end


return playerModule