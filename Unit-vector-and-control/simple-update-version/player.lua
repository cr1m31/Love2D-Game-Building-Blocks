local playerModule = {}

local player = {
  x = 100,
  y = 200,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 20
}

function normalizeVelocity()
  local magnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  
  if magnitude == 0 then
    return
  end
  
  player.velocity.x = player.velocity.x / magnitude
  player.velocity.y = player.velocity.y / magnitude
end

local isMoving = false
function getRawPlayerInput(dt)
  local moveX = 0
  local moveY = 0
  if love.keyboard.isDown("a") then
    moveX = -1
  end
  if love.keyboard.isDown("d") then
    moveX = 1
  end
  if love.keyboard.isDown("w") then
    moveY = -1
  end
  if love.keyboard.isDown("s") then
    moveY = 1
  end
  
  if love.keyboard.isDown("a") or
    love.keyboard.isDown("d") or
    love.keyboard.isDown("w") or
    love.keyboard.isDown("s") then
      isMoving = true
  else
    isMoving = false    
  end

  return moveX, moveY
end


function playerModule.update(dt)
  local moveX, moveY = getRawPlayerInput()
  player.velocity.x = player.velocity.x + moveX * player.acceleration * dt
  player.velocity.y = player.velocity.y + moveY * player.acceleration * dt
  
  if isMoving == false then
    player.velocity.x = player.velocity.x * 0.95
    player.velocity.y = player.velocity.y * 0.95
  else
    normalizeVelocity()
  end

  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  -- draw velocity vector
  local vectorScaler = 60
  local playerCenter = {x = player.x + player.width * 0.5, y = player.y + player.height * 0.5}
  love.graphics.line(playerCenter.x, playerCenter.y, playerCenter.x + player.velocity.x * vectorScaler, playerCenter.y + player.velocity.y * vectorScaler)
  love.graphics.circle("line", playerCenter.x, playerCenter.y, vectorScaler)
  love.graphics.print("velx : " .. player.velocity.x .. " vely : " .. player.velocity.y, 100, 100)  
  love.graphics.print("moving : " .. tostring(isMoving), 150, 250)
  local moveX, moveY = getRawPlayerInput()
  love.graphics.print("movx : " .. moveX .. " movY : " .. moveY, 160, 300)
end

return playerModule