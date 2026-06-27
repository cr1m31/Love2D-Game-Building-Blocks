local playerModule = {}

local coyoteMeter = 0.0
local coyoteDuration = 0.5

local tiles = {}

local player = {
  x = 150,
  y = 200,
  width = 30,
  height = 40,
  gravity = 1,
  speed = 60,
  jumpForce = 80,
}

local groundCollider = {
  x = 0,
  y = 0,
  width = player.width - 2,
  height = 20,
}

local platform = {
  x = 100,
  y = 300,
  width = 700,
  height = 20,
}

local lowPlatform = {
  x = 10,
  y = 500,
  width = 700,
  height = 20,
}

local wall = {
  x = 300,
  y = 150,
  width = 80,
  height = 100,
}

function addGravity()
  player.y = player.y + player.gravity
end

function checkCollision(aa, bb)
  return aa.x + aa.width > bb.x and
    aa.x < bb.x + bb.width and
    aa.y + aa.height > bb.y and
    aa.y < bb.y + bb.height
end

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  
  for i, tile in ipairs(tiles) do
    -- horizontal collision check
    if checkCollision(player, tile) then
      player.x = oldPlayerX
    end
  end
  
  addGravity()
  
  for i, tile in ipairs(tiles) do
    
    
    -- need to fix as ground collider is still in the platform after jump and coyotetimer got not properly emptyied at this exact moment
    if checkCollision(groundCollider, tile) and checkCollision(player, tile) then
      coyoteMeter = coyoteDuration
    else
      if coyoteMeter > 0 then
        coyoteMeter = coyoteMeter - dt
      end
    end
    
    -- vertical collision check
    if checkCollision(player, tile) then
      player.y = oldPlayerY
    end
    
  end
end

function playerJump()
  
  if coyoteMeter > 0 then
    player.y = player.y - player.jumpForce
  end
  coyoteMeter = 0
end


function love.keypressed(key, scan, isrepeat)
  
  if key == "space" then
    playerJump()
  end
  
  if key == "r" then
    player.x = 150
    player.y = 200
  end
  
  
end

function placeGroundCollider()
  groundCollider.x = player.x + 1
  groundCollider.y = player.y + player.height - groundCollider.height + 5
end

function playerModule.load()
  table.insert(tiles, platform)
  table.insert(tiles, wall)
  table.insert(tiles, lowPlatform)
end



function playerModule.update(dt)
  
  movePlayer(dt)
  
  placeGroundCollider()
  
  
  
end


function playerModule.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  for i, tile in ipairs(tiles) do
    love.graphics.rectangle("line", tile.x, tile.y, tile.width, tile.height)
  end
  
  love.graphics.print("coyote time : " .. coyoteMeter, 300, 300)
  
  -- ground collider
  love.graphics.setColor(1,0,0)
  love.graphics.rectangle("line", groundCollider.x, groundCollider.y, groundCollider.width, groundCollider.height)
end


return playerModule