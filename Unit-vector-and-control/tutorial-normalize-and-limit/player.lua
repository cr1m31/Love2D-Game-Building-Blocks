local playerModule = {}

local player = {
  x = 0,
  y = 0,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 5,
  maxSpeed = 2,
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

function normalizeInput(inx, iny)
  local magnitude = math.sqrt(inx * inx + iny * iny)
  
  if magnitude == 0 then
    return 0, 0
  end
  
  return inx / magnitude, iny / magnitude
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


function movePlayer(dt)
  
  local rawInputX, rawInputY = getRawPlayerInput()
  
  local normalizedInputX, normalizedInputY = normalizeInput(rawInputX, rawInputY)
  
  player.velocity.x = player.velocity.x + normalizedInputX * player.acceleration * dt
  player.velocity.y = player.velocity.y + normalizedInputY * player.acceleration * dt
  
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y

end

function playerModule.update(dt)
  movePlayer(dt)
  
  limitMaxSpeed()
end

local playerCenter = {x = 0, y = 0}
local vectorScaler = 30
function playerModule.draw()
  playerCenter.x = player.x + player.width / 2
  playerCenter.y = player.y + player.height / 2
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.line(playerCenter.x, playerCenter.y, playerCenter.x + player.velocity.x * vectorScaler, playerCenter.y + player.velocity.y * vectorScaler)
  
  love.graphics.circle("line", playerCenter.x, playerCenter.y, 60)
end
return playerModule