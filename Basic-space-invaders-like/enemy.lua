local enemyModule = {}

local screenHeight = love.graphics.getHeight()
local screenWidth = love.graphics.getWidth()

local enemies = {}

-- screen width = 800
-- screen width / 20 = 40 = enemy width

function createNewEnemy(xP, yP)
  local newEnemy = {
    x = xP;
    y = yP;
    vx = 0;
    vy = 0;
    width = 40;
    height = 30;
    speed = love.math.random(50, 150);
  }
  table.insert(enemies, newEnemy)
end

for i = 0, screenWidth, screenWidth / 5 do
  print(i)
  createNewEnemy(i, 50)
  createNewEnemy(i, 100)
  createNewEnemy(i, 150)
end


local enemyBullets = {}

function createEnemyBullet(px, py)
  local newEnemyBullet = {
      x = px;
      y = py;
      width = 3;
      height = 8;
      speed = 150;
  }
  table.insert(enemyBullets, newEnemyBullet)
end

createEnemyBullet(20, 200)

function enemyModule.drawEnemyBullets()
  for i, v in ipairs(enemyBullets) do
    love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
  end
end


function enemyModule.drawEnemies()
  for i, v in ipairs(enemies) do
    love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
  end
end

local widthParts = {}
function enemyModule.splitWidthForShootingRanges()
  for i = 0, 800, 40 do
    table.insert(widthParts, i)
  end
end

enemyModule.splitWidthForShootingRanges()

function enemyModule.moveEnemies(dt)
  for i, v in ipairs(enemies) do
    v.x = v.x + v.speed * dt
    if v.x + v.width >= screenWidth then
      v.x = screenWidth - v.width
      v.speed = -v.speed
    end
    if v.x <= 0 then
      v.x = 0
      v.speed = -v.speed
    end
    -- bullet random shooting
    if( math.floor( v.x) == love.math.random(widthParts[1], widthParts[#widthParts])) then
      createEnemyBullet(v.x + v.width / 2, v.y)
    end
    
  end
end

function enemyModule.moveEnemyBullets(dt)
  for i, v in ipairs(enemyBullets) do
    v.y = v.y + v.speed * dt
    if (v.y > screenHeight) then
      destroyBullet(i)
    end
  end
end

function destroyBullet(i)
  table.remove(enemyBullets, i)
end

function enemyModule.enemyCollision(missiles)
  for i = #enemies, 1, -1 do -- Iterate backwards to safely remove items
    local enemy = enemies[i]
    for j = #missiles, 1, -1 do
      local missile = missiles[j]
      if AABBCollision(missile, enemy) then
        table.remove(enemies, i)
        table.remove(missiles, j)
        break -- Exit missile loop after hit
      end
    end
  end
end

function AABBCollision(a, b)
  if a.x < b.x + b.width and
    a.x + a.width > b.x and
    a.y < b.y + b.height and
    a.y + a.height > b.y then
    return true
  end
end

return enemyModule