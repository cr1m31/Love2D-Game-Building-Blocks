local playerModule = {}

local player = {
  x = 100,
  y = 200,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 10
}

-- Normalize input
function normalizeInputDirection(moveX, moveY)
  local magnitude = math.sqrt(moveX * moveX + moveY * moveY)
  
  if magnitude == 0 then
    return 0, 0
  end
  
  return moveX / magnitude, moveY / magnitude
end

-- Input
function getRawPlayerInput()
  local moveX = 0
  local moveY = 0
  
  if love.keyboard.isDown("a") then moveX = moveX - 1 end
  if love.keyboard.isDown("d") then moveX = moveX + 1 end
  if love.keyboard.isDown("w") then moveY = moveY - 1 end
  if love.keyboard.isDown("s") then moveY = moveY + 1 end
  
  return moveX, moveY
end

function playerModule.update(dt)
  local moveX, moveY = getRawPlayerInput()
  moveX, moveY = normalizeInputDirection(moveX, moveY)

  player.velocity.x = player.velocity.x + moveX * player.acceleration * dt
  player.velocity.y = player.velocity.y + moveY * player.acceleration * dt

  player.x = player.x + player.velocity.x -- test on another computer if * dt is necessary here ? (if speed is exacly the same)
  player.y = player.y + player.velocity.y -- test on another computer if * dt is necessary here ? (if speed is exacly the same)
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

  love.graphics.circle("line", playerCenter.x, playerCenter.y, vectorScaler)
  love.graphics.print("velx: " .. player.velocity.x, 100, 100)
  love.graphics.print("vely: " .. player.velocity.y, 100, 115)
end

return playerModule