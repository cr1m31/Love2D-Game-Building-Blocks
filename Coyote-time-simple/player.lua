local playerModule = {}

local coyoteTimer = 0.0
local coyoteDuration = 0.25

local player = {
  x = 120,
  y = 100,
  width = 50,
  height = 50,
  speed = 60,
  jumpHeight = 70,
  gravity = 2,
}

local platform = {
  x = 90,
  y = 150,
  width = 700,
  height = 50,
}

function movePlayer(dt)
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
end

function collisionCheck(aa, bb)
  return aa.x + aa.width > bb.x and
    aa.x < bb.x + bb.width and
    aa.y + aa.height > bb.y and
    aa.y < bb.y + bb.height
end

function jump()
  if coyoteTimer > 0 then
    player.y = player.y - player.jumpHeight
    coyoteTimer = 0
  end
end

function love.keypressed(key, scan, isrepeat)
  if key == "space" then
    jump()
  end
  
  if key == "r" then
    resetPosition()
  end  
end

function resetPosition()
  player.x = 120
  player.y = 100
end

function addGravity()
  player.y = player.y + player.gravity
end

function playerModule.update(dt)
  movePlayer(dt)
   
  if collisionCheck(player, platform) then
    coyoteTimer = coyoteDuration
  else
    addGravity()
    if coyoteTimer > 0 then
      coyoteTimer = coyoteTimer - dt
    end
  end
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
  love.graphics.print("coyoteTimer : " .. coyoteTimer, 100, 300)
end

return playerModule