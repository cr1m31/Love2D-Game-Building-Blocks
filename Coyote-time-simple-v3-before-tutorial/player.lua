local playerModule = {}

local player = {
  x = 200,
  y = 100,
  width = 30,
  height = 40,
  gravity = 1,
  speed = 50,
  jumpForce = 80,
}

local platform = {
  x = 150,
  y = 200,
  width = 700,
  height = 20,
}

function addGravity()
  player.y = player.y + player.gravity
end

function checkCollision(aa, bb)
  return aa.x + aa.width > bb.x and
    aa.x < bb.x + bb.width and
    aa.y + aa.height > bb.y and
    aa.y < bb.y + bb.height
end

function movePlayer(dt)
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
end

function playerJump()
  player.y = player.y - player.jumpForce
end

function love.keypressed(key, scan, isrepeat)
  if key == "space" then
    playerJump()
  end
end


function playerModule.update(dt)
  local oldPlayerY = player.y
  movePlayer(dt)
  addGravity()
  
  if checkCollision(player, platform) then
    player.y = oldPlayerY
  end
end

function playerModule.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  love.graphics.setColor(1,1,0)
  love.graphics.rectangle("line", platform.x, platform.y, platform.width, platform.height)
end


return playerModule