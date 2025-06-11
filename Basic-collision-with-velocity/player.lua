local collisionModule = require("collision")

local player = {
  x = 100,
  y = 350,
  width = 40,
  height = 40,
  speed = 10,
  velocity = {x = 0, y = 0},
  maxVelocity = 0,
}

function player.loadPlayer()
  player.maxVelocity = player.speed / 2
end

local coll = nil

local playerCenter = {x = 0, y = 0}
local velocityVectorLengthMultiplier = 4.5

function player.updatePlayer(dt)
  movePlayer(dt)
  limitPlayerVelocity()
  
  playerCenter = {x = player.x + (player.width / 2), y = player.y + (player.height / 2)}
end

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  -- move horizontally
  if(love.keyboard.isDown("a") )then
    player.velocity.x = player.velocity.x - player.speed * dt
  elseif(love.keyboard.isDown("d") )then
    player.velocity.x = player.velocity.x + player.speed * dt
  end
  
  -- set velocity before to revert position based on collision
  player.x = player.x + player.velocity.x
  
  -- check horitontal collision
  coll = collisionModule.collisionAABB(player)
  if coll then
    player.velocity.x = 0
    player.x = oldPlayerX -- revert x position only
  end
  
  -- move vertically
  if(love.keyboard.isDown("w") )then
    player.velocity.y = player.velocity.y - player.speed * dt
  elseif(love.keyboard.isDown("s") )then
    player.velocity.y = player.velocity.y + player.speed * dt
  end
  
  -- set velocity before to revert position based on collision
  player.y = player.y + player.velocity.y
  
  -- check vertical collision
  coll = collisionModule.collisionAABB(player)
  if coll then
    player.velocity.y = 0
    player.y = oldPlayerY -- revert y position only
  end

end

function limitPlayerVelocity()
  -- horizontally
  if (player.velocity.x >= player.maxVelocity) then
    player.velocity.x = player.maxVelocity
  elseif (player.velocity.x <= - player.maxVelocity) then
    player.velocity.x = - player.maxVelocity
  end
  
  -- vertically
  if (player.velocity.y >= player.maxVelocity) then
    player.velocity.y = player.maxVelocity
  elseif (player.velocity.y <= - player.maxVelocity) then
    player.velocity.y = - player.maxVelocity
  end
  
end

function player.drawPlayer()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print("coll: " .. tostring(coll), 20, 20)
  
  love.graphics.print("velX: " .. player.velocity.x .. " velY: " .. player.velocity.y, 50, 50)

  -- debug velocity with line
 
  love.graphics.line(playerCenter.x, playerCenter.y, playerCenter.x + player.velocity.x * velocityVectorLengthMultiplier, playerCenter.y +  player.velocity.y * velocityVectorLengthMultiplier)

  -- debug negative velocity
  love.graphics.print("player.velocity.x: " .. player.velocity.x .. "\n - player.maxVelocity: " .. - player.maxVelocity, 100, 100)

end


return player