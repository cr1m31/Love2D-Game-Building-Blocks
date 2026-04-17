local playerModule = {}

local player = {
  x = love.graphics.getWidth() / 2 - 25,
  y = love.graphics.getHeight() / 2 - 25,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 10,
  maxSpeed = 2,
}

function getRawInputs(dt)
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

function normalizeInput(inX, inY)
  local magnitude = math.sqrt(inX * inX + inY * inY)
  
  if magnitude == 0 then
    return 0, 0 -- prevent returning nill if no magnitude also prevents zero division
  end
  
  return inX / magnitude, inY / magnitude
end

function movePlayer(dt)
  local rawInputX, rawInputY = getRawInputs(dt)
  
  local normalizedInputX, normalizedInputY = normalizeInput(rawInputX, rawInputY)
  
  player.velocity.x = player.velocity.x + normalizedInputX * player.acceleration * dt
  player.velocity.y = player.velocity.y + normalizedInputY * player.acceleration * dt
  
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y
end

function limitMaxSpeed()
  local magnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  if magnitude == 0 then
    return
  end
  
  if magnitude > player.maxSpeed then -- condition to have immediate uturn enabled
    player.velocity.x = (player.velocity.x / magnitude) * player.maxSpeed
    player.velocity.y = (player.velocity.y / magnitude) * player.maxSpeed
  end
  
end

function playerModule.update(dt)
  movePlayer(dt)
  limitMaxSpeed()
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
end

return playerModule