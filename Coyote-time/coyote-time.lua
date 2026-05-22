local coyoteTimeModule = {}

local player = {
  x = 100,
  y = 200,
  width = 50,
  height = 50,
  speed = 150,
}

local platform = {
  x = 150,
  y = 260,
  width = 500,
  height = 30,
}

function movePlayer(dt)
  
  local oldX = player.x
  local oldY = player.y
  
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  
  if not collisionCheck(player, platform) then
    player.x = oldX
  end
  
  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end
  
  if not collisionCheck(player, platform) then
    player.y = oldY
  end
  
end

function collisionCheck(aa, bb)
  return aa.x + aa.width < bb.x or
    aa.x > bb.x + bb.width or
    aa.y + aa.height < bb.y or
    aa.y > bb.y + bb.height
end


function coyoteTimeModule.update(dt)
  movePlayer(dt)
end


function coyoteTimeModule.draw()
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
end


return coyoteTimeModule