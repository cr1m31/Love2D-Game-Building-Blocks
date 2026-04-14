local playerModule = {}

local player = {
  x = love.graphics.getWidth() / 2 - 25,
  y = love.graphics.getHeight() / 2 - 25,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  acceleration = 3,
}

function getRawInputs()
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


function playerModule.update(dt)
  local rawInputX, rawInputY = getRawInputs()
  
  player.x = player.x + rawInputX
  player.y = player.y + rawInputY
end


function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
end


return playerModule