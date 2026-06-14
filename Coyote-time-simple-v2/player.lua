local playerModule = {}

local coyoteTimer = 0.0
local coyoteDuration = 1.25

local player = {
  x = 150,
  y = 200,
  width = 40,
  height = 50,
  gravity = 2,
  speed = 60,
  jumpForce = 50,
}

local platform = {
  x = 100,
  y = 300,
  width = love.graphics.getWidth(),
  height = 30,
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

function resetPlayerPosition()
  player.x = 150
  player.y = 200
end

function jump()
  if coyoteTimer > 0 then
    player.y = player.y - player.jumpForce
  end
  coyoteTimer = 0 -- after jumping initiated !
end

function love.keypressed(key, scan, isrepeat)
  if key == "r" then
    resetPlayerPosition()
  end
  if key == "space" then
    jump()
  end
end

function playerModule.update(dt)
  movePlayer(dt)
  if checkCollision(player, platform) then
    coyoteTimer = coyoteDuration
  else    
    addGravity()
    if coyoteTimer > 0 then
      coyoteTimer = coyoteTimer - dt
    end
  end
end

local barsScaler = 100
function drawCoyoteMeter()
  -- back
  love.graphics.setColor(0,0,1)
  love.graphics.rectangle("fill", 15, 15, coyoteDuration * barsScaler, 30)
  
  -- coyote meter bar
  love.graphics.setColor(0,1,0)
  love.graphics.rectangle("fill", 20, 20, coyoteTimer * (barsScaler - 9), 20)
  
end


function playerModule.draw()
  drawCoyoteMeter()
  
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.rectangle("line", platform.x, platform.y, platform.width, platform.height)
  love.graphics.print("check : " .. tostring( checkCollision(player, platform) ), 300, 300)
  love.graphics.print("coyoteTimer : " .. coyoteTimer, 330, 350)
end

return playerModule