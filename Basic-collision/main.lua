local playerModule = require("player")
local collisionModule = require("collision")
local gridModule = require("grid")

function love.load()
  collisionModule.createColliders()
  gridModule.createGridTiles()
end

function love.update(dt)
  playerModule.updatePlayer(dt)
end

function love.draw()
  playerModule.drawPlayer()
  collisionModule.drawColliders()
  gridModule.drawGrid()
end