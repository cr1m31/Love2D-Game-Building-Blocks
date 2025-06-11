local collisionModule = require("collision")

local player = {
  x = 100,
  y = 350,
  width = 40,
  height = 40,
  speed = 10,
  velocity = {x = 0, y = 0},
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

function player.drawPlayer()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print("coll: " .. tostring(coll), 20, 20)
  
  love.graphics.print("velX: " .. player.velocity.x .. " velY: " .. player.velocity.y, 50, 50)

  -- debug velocity with line
  local playerCenter = {x = player.x + (player.width / 2), y = player.y + (player.height / 2)}
  local velocityVectorLengthMultiplier = 6
  love.graphics.line(playerCenter.x, playerCenter.y, playerCenter.x + player.velocity.x * velocityVectorLengthMultiplier, playerCenter.y +  player.velocity.y * velocityVectorLengthMultiplier)

end


return player