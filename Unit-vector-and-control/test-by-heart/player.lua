local playerModule = {}

local vectorMod = require("vector")

local player = {
  x = love.graphics.getWidth() / 2 - 25,
  y = love.graphics.getHeight() / 2 - 25,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 10,
}

local timerCopy = 0

function getRawInputs(dt)
  local inputX, inputY = 0, 0
  
  if love.keyboard.isDown("a") then
    inputX = inputX - 1
  end
  if love.keyboard.isDown("d") then
    inputX = inputX + 1
  end
  if love.keyboard.isDown("w") then
    inputY = inputY - 1
  end
  if love.keyboard.isDown("s") then
    inputY = inputY + 1
  end
  
  return inputX, inputY
end

function checkVectorLength()
  local playerCenter = {x = - ( (love.graphics.getWidth() / 2) - player.x - (player.width / 2) ), y = - ( (love.graphics.getHeight() / 2) - player.y - (player.height / 2) )}
  
  local vectorLen = math.sqrt(playerCenter.x * playerCenter.x + playerCenter.y * playerCenter.y)
  if vectorLen > 220 then
    return true
  end
  
  return false
end


function resetTest()
  vectorMod.resetTimer()
    timerCopy = 0
  
  player.velocity.x = 0
  player.velocity.y = 0
  
  player.x = love.graphics.getWidth() / 2 - 25
  player.y = love.graphics.getHeight() / 2 - 25
end

function love.keypressed(key, scan, isrepeat)
  if key == "r" then
    resetTest()
  end
end

function limitMaxSpeed()
  local magnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  
  if magnitude == 0 then
    return
  end
  local maxSpeed = 2
  player.velocity.x = (player.velocity.x / magnitude) * maxSpeed
  player.velocity.y = (player.velocity.y / magnitude) * maxSpeed
end


function playerModule.update(dt)
  
  
  local rawInputX, rawInputY = getRawInputs(dt)
  
  if rawInputX == 0 and rawInputY == 0 then
  else
    if checkVectorLength() == false then
      timerCopy = vectorMod.timerTest(dt)
    end

  end
  
  
  local normalizedInputX, normalizedInputY = vectorMod.normalizeInput(rawInputX, rawInputY)
  
  player.velocity.x = player.velocity.x + normalizedInputX * player.acceleration * dt
  player.velocity.y = player.velocity.y + normalizedInputY * player.acceleration * dt
  
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y
  
  
  limitMaxSpeed()
end


function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.circle("line", player.x + player.width / 2, player.y + player.height / 2, 20)
  love.graphics.print("timerCopy : " .. timerCopy, 100, 150)
  
  love.graphics.circle("line", love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5, 220)
  
end


return playerModule