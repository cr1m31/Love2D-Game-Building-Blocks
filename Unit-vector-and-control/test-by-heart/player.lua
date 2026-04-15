local playerModule = {}

local vectorMod = require("vector")

local player = {
  x = love.graphics.getWidth() / 2 - 25,
  y = love.graphics.getHeight() / 2 - 25,
  width = 50,
  height = 50,
}

local timerCopy = 0

function getRawInputs(dt)
  local inputX, inputY = 0, 0
  
  if love.keyboard.isDown("a") then
    inputX = inputX - 1
  end
  if love.keyboard.isDown("d") then
    inputX = inputX + 1
    
    timerCopy = vectorMod.timerTest(dt)
    
  end
  if love.keyboard.isDown("w") then
    inputY = inputY - 1
  end
  if love.keyboard.isDown("s") then
    inputY = inputY + 1
  end
  
  return inputX, inputY
end

function resetTest()
  vectorMod.resetTimer()
    timerCopy = 0
  
  player.x = love.graphics.getWidth() / 2 - 25
  player.y = love.graphics.getHeight() / 2 - 25
end

function love.keypressed(key, scan, isrepeat)
  if key == "r" then
    resetTest()
  end
end


function playerModule.update(dt)
  local rawInputX, rawInputY = getRawInputs(dt)
  
  local normalizedInputX, normalizedInputY = vectorMod.normalizeInput(rawInputX, rawInputY)
  
  player.x = player.x + normalizedInputX
  player.y = player.y + normalizedInputY
  
end


function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.circle("line", player.x + player.width / 2, player.y + player.height / 2, 20)
  love.graphics.print("timerCopy : " .. timerCopy, 100, 150)
  
  love.graphics.circle("line", love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5, 220)
end


return playerModule