local playerModule = {}

local vectorMod = require("vectors")

local player = {
  x = 300,
  y = 300,
  width = 30,
  height = 30,
  acceleration = 60,
  velocity = {x = 0, y = 0},
  velocityLimit = 60
}

function rawPlayerInput()
  local moveX, moveY = 0, 0 -- reset to zero each update
  
  if love.keyboard.isDown("a") then
    moveX = moveX - 1
  end
  if love.keyboard.isDown("d") then
    moveX = moveX + 1
  end
  
  if love.keyboard.isDown("w") then
    moveY = moveY - 1
  end
  
  if love.keyboard.isDown("s") then
    moveY = moveY + 1
  end
  
  return moveX, moveY
end

function movePlayer(dt)
  local inputX, inputY = rawPlayerInput()
  
  player.velocity.x = player.velocity.x + inputX * player.acceleration * dt
  player.velocity.y = player.velocity.y + inputY * player.acceleration * dt
  
  player.x = player.x + player.velocity.x * dt
  player.y = player.y + player.velocity.y * dt
end

function playerModule.update(dt)
  movePlayer(dt)
  
  vectorMod.normalizeVector(player)
end

--[[--
  - rounding objects (player rectangle) positions with math floor to always draw objects on pixels not on float values
  - adding some offset (0.5) pixel to draw lines with full color otherwise the line may be on half a line
--]]--

local drawLinesOffset = 0.5
function playerModule.draw()
  love.graphics.rectangle("line", math.floor(player.x) + drawLinesOffset, math.floor(player.y) + drawLinesOffset, player.width, player.height)
  
  local inputX, inputY = rawPlayerInput()
  love.graphics.print("inputX = " .. inputX .. " inputY = " .. inputY, 100, 200)
  
  love.graphics.print("velx = " .. player.velocity.x .. " velY = " .. player.velocity.y, 150, 300)
  
  vectorMod.draw(player)
end

return playerModule