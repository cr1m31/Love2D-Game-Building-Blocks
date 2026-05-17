local playerModule = {}

local player = {
  x = 0,
  y = 0,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 10,
  maxSpeed = 3,
}

function getRawInput()
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


function normalizeVelocity(inx, iny)
  
  local magnitude = math.sqrt(inx * inx + iny * iny)
  
  if magnitude == 0 then
    return 0, 0
  end
  
  return inx / magnitude, iny / magnitude
  
end

function movePlayer(dt)
  local rawInputX, rawInputY = getRawInput()
  
  local normalizedInputX, normalizedInputY = normalizeVelocity(rawInputX, rawInputY)
  
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
  
  if magnitude > player.maxSpeed then
    player.velocity.x = (player.velocity.x / magnitude) * player.maxSpeed
    player.velocity.y = (player.velocity.y / magnitude) * player.maxSpeed
  end
  
end

local playerCenter = {x = 0, y = 0}
function playerModule.update(dt)
  playerCenter.x = player.x + player.width * 0.5
  playerCenter.y = player.y + player.height * 0.5
  
  movePlayer(dt)
  
  limitMaxSpeed()
end

local vectorScaler = 30
function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.line(playerCenter.x, playerCenter.y, playerCenter.x + player.velocity.x * vectorScaler, playerCenter.y + player.velocity.y * vectorScaler)
  
  love.graphics.circle("line", playerCenter.x, playerCenter.y, player.maxSpeed * vectorScaler)
  
  love.graphics.print("velx : " .. player.velocity.x .. " vely : " .. player.velocity.y, 100, 150)
end


return playerModule