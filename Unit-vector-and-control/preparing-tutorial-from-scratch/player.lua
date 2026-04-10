local playerModule = {}

local player = {
  x = 400,
  y = 200,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 2,
}
local seconds = 0
function timer(dt)
  seconds = seconds + dt
  
  return seconds
end


function getRawPlayerInput(dt)
  local inputX, inputY = 0, 0
  
  if love.keyboard.isDown("a") then
    
    if checkVectorLength() then
    else
      inputX = inputX - 1
      timer(dt)
    end
  end
  if love.keyboard.isDown("d") then
    inputX = inputX + 1
  end
  if love.keyboard.isDown("w") then
    inputY = inputY -1
  end
  if love.keyboard.isDown("s") then
    inputY = inputY + 1
  end
  
  if love.keyboard.isDown("d") and
  love.keyboard.isDown("s") then
    if checkVectorLength() then
      inputX = 0
      inputY = 0
    else
      timer(dt)
      
    end
  end
  
  return inputX, inputY
end

function love.keypressed(key, scan, isrepeat)
  if key == "r" then
    seconds = 0
    player.velocity.x = 0
    player.velocity.y = 0
    player.x = 400
    player.y = 200
  end
end

function checkVectorLength()
  local magnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  
  if magnitude >= 2 then
    return true
  end
end


function normalizeInput(dt)
  local inputX, inputY = getRawPlayerInput(dt)
  
  local magnitude = math.sqrt(inputX * inputX + inputY * inputY)
  
  if magnitude == 0 then
    return 0, 0 -- return 0,0 to prevent input output to get wrong
  end
  
  return inputX / magnitude, inputY / magnitude
end

function movePlayer(dt)
  
  local normalizedX, normalizedY = normalizeInput(dt)
  player.velocity.x = player.velocity.x + normalizedX * player.acceleration * dt
  player.velocity.y = player.velocity.y + normalizedY * player.acceleration * dt
  
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y
end


function playerModule.update(dt)
  movePlayer(dt)
end
  
local vectorScaler = 60
function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  local playerCenter = {x = player.x + player.width * 0.5, y = player.y + player.height * 0.5}
  love.graphics.line(playerCenter.x, playerCenter.y, playerCenter.x + player.velocity.x * vectorScaler, playerCenter.y + player.velocity.y * vectorScaler)
  
  love.graphics.circle("line", playerCenter.x, playerCenter.y, vectorScaler * 2)
  love.graphics.print("sec : " .. seconds, 100, 150)
end


return playerModule