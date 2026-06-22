local playerModule = {}

local coyoteMeter = 0.0
local coyoteDuration = 0.5

local player = {
  x = 150,
  y = 200,
  width = 30,
  height = 40,
  gravity = 1,
  speed = 60,
  jumpForce = 80,
}

local groundCollider = {
  x = 0,
  y = 0,
  width = player.width - 2,
  height = 20,
}


local platform = {
  x = 100,
  y = 300,
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
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  
  -- horizontal collision check
  if checkCollision(player, platform) then
    player.x = oldPlayerX
  end
  
  addGravity()
  
  -- vertical collision check
  if checkCollision(player, platform) then
    player.y = oldPlayerY
  end
  
  if checkCollision(groundCollider, platform) then
    coyoteMeter = coyoteDuration
  else
    if coyoteMeter > 0 then
      coyoteMeter = coyoteMeter - dt
    end
  end
  
  
  
  
end

function playerJump()
  
  if coyoteMeter > 0 then
    player.y = player.y - player.jumpForce
  end
  coyoteMeter = 0
end


function love.keypressed(key, scan, isrepeat)
  
  if key == "space" then
    playerJump()
  end
  
  if key == "r" then
    player.x = 150
    player.y = 200
  end
  
  
end

function placeGroundCollider()
  groundCollider.x = player.x + 1
  groundCollider.y = player.y + player.height - groundCollider.height + 5
end


function playerModule.update(dt)
  
  movePlayer(dt)
  
  placeGroundCollider()
  
  
  
end


function playerModule.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.rectangle("line", platform.x, platform.y, platform.width, platform.height)
  
  love.graphics.print("coyote time : " .. coyoteMeter, 300, 300)
  
  -- ground collider
  love.graphics.setColor(1,0,0)
  love.graphics.rectangle("line", groundCollider.x, groundCollider.y, groundCollider.width, groundCollider.height)
end


return playerModule