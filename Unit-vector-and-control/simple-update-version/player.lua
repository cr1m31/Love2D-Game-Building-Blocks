local playerModule = {}

local player = {
  x = 100,
  y = 200,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 0.5,
  speed = 60,
}

function normalizeVelocity()
  local magnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  if magnitude == 0 then
    return
  end
  
  player.velocity.x = player.velocity.x / magnitude
  player.velocity.y = player.velocity.y / magnitude
end


function movePlayer(dt)

  if love.keyboard.isDown("a") then
    player.velocity.x = player.velocity.x - player.speed * player.acceleration * dt
  end
  if love.keyboard.isDown("d") then
    player.velocity.x = player.velocity.x + player.speed * player.acceleration * dt
  end
  
  if love.keyboard.isDown("w") then
    player.velocity.y = player.velocity.y - player.speed * player.acceleration * dt
  end
  if love.keyboard.isDown("s") then
    player.velocity.y = player.velocity.y + player.speed * player.acceleration * dt
  end
  
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y
end


function playerModule.update(dt)
  movePlayer(dt)
  
  normalizeVelocity()
end


function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  
  -- draw velocity vector
  local vectorScaler = 60
  local playerCenter = {x = player.x + player.width * 0.5, y = player.y + player.height * 0.5}
  love.graphics.line(playerCenter.x, playerCenter.y, playerCenter.x + player.velocity.x * vectorScaler, playerCenter.y + player.velocity.y * vectorScaler)
  
  love.graphics.circle("line", playerCenter.x, playerCenter.y, vectorScaler)
  
  love.graphics.print("velx : " .. player.velocity.x .. " vely : " .. player.velocity.y, 100, 100)
end


return playerModule