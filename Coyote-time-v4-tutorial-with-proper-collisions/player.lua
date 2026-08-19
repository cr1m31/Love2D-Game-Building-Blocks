local playerModule = {}

local player = {
  x = 100,
  y = 100,
  width = 30,
  height = 50,
  speed = 100,
  velocity = {x = 0, y = 0},
}

function movePlayer(dt)
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  
  
  
  player.y = player.y + player.velocity.y * dt
  
  addGravity()
  
end

function playerJump()
  player.velocity.y = - 500
end

function addGravity()
  player.velocity.y = 10
end

function collisionCheck(aa, bb)
  return aa.x + aa.width > bb.x and
    aa.x < bb.x + bb.width and
    aa.y + aa.height > bb.y and
    aa.y < bb.y + bb.height
end


function playerModule.update(dt)
  movePlayer(dt)
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print("vel y : " .. player.velocity.y, 300, 300)
end

function love.keypressed(key, scan, isrepeat)
  if key == "space" then
    playerJump()
  end
end


return playerModule