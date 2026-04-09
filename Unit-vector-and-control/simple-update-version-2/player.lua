local playerModule = {}

local player = {
  x = 100,
  y = 200,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 10,
  maxSpeed = 2.5,
}

function getRawPlayerInput()
  local inputX, inputY = 0, 0
  
  if love.keyboard.isDown("a") then
    inputX = inputX - 1
  end
  if love.keyboard.isDown("d") then
    inputX = inputX + 1
  end
  if love.keyboard.isDown("w") then
    inputY = inputY - 1
  end
  if love.keyboard.isDown("s") then
    inputY = inputY + 1
  end
  
  return inputX, inputY
end

function normalizeInputDirection(inputX, inputY)
  local magnitude = math.sqrt(inputX * inputX + inputY * inputY)
  
  if magnitude == 0 then
    return 0, 0
  end
  
  return inputX / magnitude, inputY / magnitude
end

function movePlayer(dt)
  local inputX, inputY = getRawPlayerInput()
  
  normalizedInputX, normalizedInputY = normalizeInputDirection(inputX, inputY)

  player.velocity.x = player.velocity.x + normalizedInputX * player.acceleration * dt
  player.velocity.y = player.velocity.y + normalizedInputY * player.acceleration * dt
  
  player.x = player.x + player.velocity.x -- test on another computer if * dt is necessary here ? (if speed is exacly the same)
  player.y = player.y + player.velocity.y -- test on another computer if * dt is necessary here ? (if speed is exacly the same)
end

function limitMaxSpeed() -- NEED TO UNDERSTAND THIS DEEPLY !!
  -- velocityMagnitude = speed
  local velocityMagnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  if velocityMagnitude > player.maxSpeed then
    player.velocity.x = (player.velocity.x / velocityMagnitude) * player.maxSpeed
    player.velocity.y = (player.velocity.y / velocityMagnitude) * player.maxSpeed
  end
end

function playerModule.update(dt)
  movePlayer(dt)
  
  limitMaxSpeed()
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)

  local vectorScaler = 60
  local playerCenter = {
    x = player.x + player.width * 0.5,
    y = player.y + player.height * 0.5
  }

  love.graphics.line(
    playerCenter.x,
    playerCenter.y,
    playerCenter.x + player.velocity.x * vectorScaler,
    playerCenter.y + player.velocity.y * vectorScaler
  )

  love.graphics.circle("line", playerCenter.x, playerCenter.y, vectorScaler * player.maxSpeed)
  love.graphics.print("velx: " .. player.velocity.x, 100, 100)
  love.graphics.print("vely: " .. player.velocity.y, 100, 115)
end

return playerModule