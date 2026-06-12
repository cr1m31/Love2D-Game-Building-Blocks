local playerModule = {}

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
local timer = 0.0
function jump()
  player.y = player.y - player.jumpHeight
end

function checkIfCanJumpCoyote()
  if timer > -0.1 and timer < 0.3 then
    return true
  else 
    return false
  end
end


function updateTimer(dt)
  timer = timer + dt
end

function checkIfGrounded()
  if player.y + player.height < platform.y or player.y > platform.y + platform.height or player.x + player.width < platform.x then
    return false
  else 
    return true
  end
end

function love.keypressed(key, scan, isrepeat)
  if key == "space" and checkIfCanJumpCoyote() then
    jump()
    
    --timer = 0
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
  if not checkIfGrounded() then
    addGravity()
  end
  
  if not checkIfGrounded() then
    updateTimer(dt)
  else
    timer = 0
  end
end


function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
  
  love.graphics.print("timer : " .. timer, 100, 300)
end



return playerModule