local playerModule = {}

local player = {
  x = 400,
  y = 200,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 2,
}
local seconds = 0
function timer(dt)
  seconds = seconds + dt
  
  return seconds
end

function getRawPlayerInput()
  local inputX, inputY = 0, 0
  
  if love.keyboard.isDown("a") then
    inputX = inputX - 1
  end
  if love.keyboard.isDown("d") then
    inputX = inputX + 1
  end
  if love.keyboard.isDown("w") then
    inputY = inputY -1
  end
  if love.keyboard.isDown("s") then
    inputY = inputY + 1
  end
  if love.keyboard.isDown("d") and
  love.keyboard.isDown("s") then
  end
  
  return inputX, inputY
end

function love.keypressed(key, scan, isrepeat)
  if key == "r" then
    seconds = 0
    player.velocity.x = 0
    player.velocity.y = 0
    player.x = 400
    player.y = 200
  end
end

function limitMaxSpeed(dt)
  local velocityMagnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  
  if velocityMagnitude == 0 then
    return
  end
  
  local maxSpeed = 2
  if velocityMagnitude > maxSpeed then -- verify if magnitude of velocity (player speed) is greater than some maximum speed
    -- normalize velocity to a unit vector (player.velocity / velocityMagnitude)
    -- then important as the vector's length = 1 (unit vector) we need to multiply it by a max speed 
      -- to obtain the maximum vector length ...
    player.velocity.x = (player.velocity.x / velocityMagnitude) * maxSpeed
    player.velocity.y = (player.velocity.y / velocityMagnitude) * maxSpeed
    
  else
    timer(dt) -- increase timer only if max speed is reached
  end
  
end

function normalizeInput()
  local inputX, inputY = getRawPlayerInput()
  
  local magnitude = math.sqrt(inputX * inputX + inputY * inputY)
  
  if magnitude == 0 then
    return 0, 0 -- return 0,0 to prevent input output to get wrong
  end
  
  return inputX / magnitude, inputY / magnitude
end

function movePlayer(dt)
  
  local normalizedX, normalizedY = normalizeInput()
  
  player.velocity.x = player.velocity.x + normalizedX * player.acceleration * dt
  player.velocity.y = player.velocity.y + normalizedY * player.acceleration * dt
  
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y
end


function playerModule.update(dt)
  movePlayer(dt)
  
  limitMaxSpeed(dt)
end
  
local vectorScaler = 60
function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  local playerCenter = {x = player.x + player.width * 0.5, y = player.y + player.height * 0.5}
  love.graphics.line(playerCenter.x, playerCenter.y, playerCenter.x + player.velocity.x * vectorScaler, playerCenter.y + player.velocity.y * vectorScaler)
  
  love.graphics.circle("line", playerCenter.x, playerCenter.y, vectorScaler * 2)
  love.graphics.print("sec : " .. seconds, 100, 150)
end


return playerModule