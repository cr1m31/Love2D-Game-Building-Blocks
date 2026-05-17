local missile = {}

local missiles = {}

local enemyModule = require("enemy")

function createNewMissile()
  local newMissile = {
    x = 0;
    y = 0;
    width = 5;
    height = 15;
    speed = 200;
  }
  table.insert(missiles, newMissile)
end

local waitTime = 0
local countShoots = 0

function waitBeforeShootingMissile(dt)
  waitTime = waitTime + dt
  if ( waitTime >= 3) then
    
  end 
end

function missile.updateMissiles(dt)
  moveMissiles(dt)
  waitBeforeShootingMissile(dt)
end

function missile.drawMissiles()
  for i, v in ipairs(missiles) do
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end
  love.graphics.print("waitTime: " .. waitTime, 200, 200)
  love.graphics.print("countShoots: " .. countShoots, 200, 250)
end

function setMissilePos(playerPosP)
  countShoots = countShoots + 1
    missiles[#missiles].x = playerPosP.x + playerPosP.width / 2 - (missiles[#missiles].width / 2)
    missiles[#missiles].y = playerPosP.y - missiles[#missiles].height
end

function missile.shootMissile(playerPos)
  createNewMissile()
  setMissilePos(playerPos)
end

function moveMissiles(dt)
  if (#missiles ~= 0) then
    for i, v in ipairs(missiles) do
      v.y = v.y - v.speed * dt
      
      if (v.y <= 0) then
        deleteMissileIfOutOfBounds(i)
      end
      
    end
  end
  enemyModule.enemyCollision(missiles)
end

function deleteMissileIfOutOfBounds(iP)
  table.remove(missiles, iP)
end

return missile