local playerModule = {}

local gridModule = require("grid")

local player = {
  x = 80,
  y = 80,
  width = 20,
  height = 40,
  speed = 400,
  defaultSpeed = 400,
  diagonalSpeed = 400 / 1.414
}
local x = 1
local y = 1
print(math.sqrt(x * x + y * y))

function playerModule.update(dt)
  movePlayer(dt)
  
  limitDiagonalSpeed()
end

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  -- left
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  -- right
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    player.x = oldPlayerX
  end
  
  -- up
  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  -- down
  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end

  
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    player.y = oldPlayerY
  end
  
end

function limitDiagonalSpeed()
  if ( love.keyboard.isDown("a") or love.keyboard.isDown("d") )  and
    ( love.keyboard.isDown("w") or love.keyboard.isDown("s") )then
    player.speed = player.diagonalSpeed
  else
    player.speed = player.defaultSpeed
  end
end

function playerModule.draw()
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    love.graphics.setColor(1,0,0)
  else
    love.graphics.setColor(1,1,1)
  end

  
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  love.graphics.print("speed: " .. player.speed, 100, 300)
end

return playerModule