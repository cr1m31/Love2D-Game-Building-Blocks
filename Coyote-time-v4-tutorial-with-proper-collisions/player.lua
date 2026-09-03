local playerModule = {}

local player = {
  x = 100,
  y = 100,
  width = 30,
  height = 50,
  speed = 100,
  velocity = {x = 0, y = 0},
}

local platform = {
  x = 100,
  y = 400,
  width  = 700,
  height = 20,
}

local wall = {
  x = 0,
  y = 200,
  width  = 20,
  height = 250,
}

local ceiling = {
  x = 150,
  y = 300,
  width  = 600,
  height = 20,
}

local tiles = {}

function collisionCheck(aa, bb)
  return aa.x + aa.width > bb.x and
    aa.x < bb.x + bb.width and
    aa.y + aa.height > bb.y and
    aa.y < bb.y + bb.height
end

function movePlayer(dt)
  local oldX = player.x
  local oldY = player.y
  
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  
  for _, tile in ipairs(tiles) do
    if collisionCheck(player, tile) then
      player.x = oldX
    end
  end
  
  
  player.y = player.y + player.velocity.y * dt
  
  addGravity()
  
  for _, tile in ipairs(tiles) do
    if collisionCheck(player, tile) then
      
      if player.velocity.y < 0 then
        player.y = tile.y - player.height
      elseif player.velocity.y >= 0 then
        player.y = oldY
      
      end
      
    end
  end
  
end

function playerJump()
  print("JUMP 0: " .. player.velocity.y)
  player.velocity.y = - 1700
  print("JUMP : " .. player.velocity.y)
end

function addGravity()
  player.velocity.y = 50
end


function playerModule.load()
  table.insert(tiles, 1, platform)
  table.insert(tiles, 2, wall)
  table.insert(tiles, 3, ceiling)
end


function playerModule.update(dt)
  movePlayer(dt)
end

function playerModule.draw()
  
  for _, tile in ipairs(tiles) do
    love.graphics.rectangle("line", tile.x, tile.y, tile.width, tile.height)
  end
  
  
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print("vel y : " .. player.velocity.y, 300, 300)
end

function love.keypressed(key, scan, isrepeat)
  if key == "space" then
    playerJump()
  end
end


return playerModule