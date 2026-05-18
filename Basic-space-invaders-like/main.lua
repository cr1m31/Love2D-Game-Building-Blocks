local missileModule = require("missile")
local enemyModule = require("enemy")
local playerModule = require("player")

-- LOAD ------------------------------------------------------------------
function love.load()
  playerModule.setPlayerPos()
end

-- UPDATE ------------------------------------------------------------------
function love.update(dt)
  playerModule.movePlayer(dt)
  missileModule.updateMissiles(dt)
  enemyModule.moveEnemies(dt)
  enemyModule.moveEnemyBullets(dt)
end

-- DRAW ------------------------------------------------------------------
function love.draw()
  playerModule.drawPlayer()
  missileModule.drawMissiles()
  enemyModule.drawEnemies()
  enemyModule.drawEnemyBullets()
end






