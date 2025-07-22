local playerModule = {}

local screenHeight = love.graphics.getHeight()
local screenWidth = love.graphics.getWidth()

local missileModule = require("missile")
local enemyModule = require("enemy")



local player = {
  x = 0;
  y = 0;
  width = 50;
  height = 50;
  speed = 120;
  energy = 100;
}

local bottonMargin = 10

function playerModule.setPlayerPos()
  player.y = screenHeight - player.height - bottonMargin
  player.x = screenWidth / 2 - (player.width / 2)
end

function playerModule.movePlayer(dt)
  if(love.keyboard.isDown("a")) then
    if (player.x <= 0 - (player.width / 2) ) then
    else
     player.x = player.x - player.speed * dt
    end
  end
  if(love.keyboard.isDown("d")) then
    if (player.x + (player.width / 2) >= screenWidth) then
    else
     player.x = player.x + player.speed * dt
    end
  end
end

function playerModule.drawPlayer()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height);
  love.graphics.print("energy: " .. player.energy, player.x + player.width, player.y)
end

-- FUNCTIONS ------------------------------------------------------------------

function love.keypressed(key, scancode, isrepeat)
  if key == "space" then
    missileModule.shootMissile(player)
  end
end


return playerModule