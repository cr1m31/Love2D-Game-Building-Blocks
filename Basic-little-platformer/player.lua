local collisionModule = require("collision")

local player = {
  x = 100,
  y = 350,
  width = 40,
  height = 40,
  speed = 20,
  velocity = {x = 0, y = 0},
}

local coll = nil
local visualVectorLineLengthMultiplier = 3

function player.updatePlayer(dt)
  movePlayer(dt)
end

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y

  -- let this increasing position at the begining of the function
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y

  -- move horizontally
  if(love.keyboard.isDown("a") )then
    player.x = player.x - player.speed * dt
  elseif(love.keyboard.isDown("d") )then
    player.x = player.x + player.speed * dt
  end
  
  -- check horitontal collision
  coll = collisionModule.collisionAABB(player)
  if coll then
    player.velocity.x = 0

    player.x = oldPlayerX -- revert x position only
    
  end
  
  -- move vertically
  if(love.keyboard.isDown("w") )then
    player.y = player.y - player.speed * dt
  elseif(love.keyboard.isDown("s") )then
    player.y = player.y + player.speed * dt
  end
  
  -- check vertical collision
  coll = collisionModule.collisionAABB(player)
  if coll then
    player.velocity.y = 0
    
    player.y = oldPlayerY -- revert y position only
    
  end

  -- let this velocity definition at the end of the function once player has moved and
  -- added displacement
  player.velocity.x = (player.x - oldPlayerX)
  player.velocity.y = (player.y - oldPlayerY)
 
end

function player.drawPlayer()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print("coll: " .. tostring(coll), 200, 250)

  love.graphics.print("velX: " .. player.velocity.x .. " velY: " .. player.velocity.y, 200, 200)

  love.graphics.line(player.x + (player.width / 2), player.y + (player.height / 2), player.x + (player.width / 2) + (player.velocity.x * visualVectorLineLengthMultiplier), player.y + (player.height / 2) + (player.velocity.y * visualVectorLineLengthMultiplier))
end


return player