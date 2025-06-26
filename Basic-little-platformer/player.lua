local collisionModule = require("collision")

local player = {
  x = 100,
  y = 350,
  width = 40,
  height = 40,
  speed = 20,
  velocity = {x = 0, y = 0},
  jumpForce = 5,
}

local gravity = 4

local coll = nil
local visualVectorLineLengthMultiplier = 3

function player.updatePlayer(dt)
  movePlayer(dt)
  -- addGravity(dt)
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
  
  player.x = player.x + player.velocity.x

  -- check horitontal collision
  coll = collisionModule.collisionAABB(player)
  if coll then
    

    player.x = oldPlayerX -- revert x position only

    player.velocity.x = 0
    
  end

  -- move vertically
  if(love.keyboard.isDown("w") )then
    player.velocity.y = player.velocity.y - player.speed * dt
  elseif(love.keyboard.isDown("s") )then
    player.velocity.y = player.velocity.y + player.speed * dt
  end

  player.y = player.y + player.velocity.y
  
  -- check vertical collision
  coll = collisionModule.collisionAABB(player)
  if coll then
    
    
    player.y = oldPlayerY -- revert y position only

    player.velocity.y = 0
    
  end

end

function playerJump()
  player.velocity.y = player.velocity.y - player.jumpForce
end

function addGravity(dt)
 player.velocity.y = player.velocity.y + gravity * dt
end

function player.drawPlayer()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print("coll: " .. tostring(coll), 200, 250)

  love.graphics.print("velX: " .. player.velocity.x .. " velY: " .. player.velocity.y, 200, 200)

  love.graphics.line(player.x + (player.width / 2), player.y + (player.height / 2), player.x + (player.width / 2) + (player.velocity.x * visualVectorLineLengthMultiplier), player.y + (player.height / 2) + (player.velocity.y * visualVectorLineLengthMultiplier))
end

function love.keypressed(key , scancode , isrepeat )
 if(key == "space") then
  playerJump()
 end
end

return player