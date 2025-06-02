local collisionModule = require("collision")

local player = {
  x = 100,
  y = 350,
  width = 50,
  height = 50,
  speed = 100,
}

local coll = nil

function player.updatePlayer(dt)
  movePlayer(dt)
end

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  -- move horizontally
  if(love.keyboard.isDown("a") )then
    player.x = player.x - player.speed * dt
  elseif(love.keyboard.isDown("d") )then
    player.x = player.x + player.speed * dt
  end
  
  -- check horitontal collision
  coll = collisionModule.collisionAABB(player)
  if coll then
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
    player.y = oldPlayerY -- revert y position only
  end
  
end

function player.drawPlayer()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print("coll: " .. tostring(coll), 20, 20)
end


return player