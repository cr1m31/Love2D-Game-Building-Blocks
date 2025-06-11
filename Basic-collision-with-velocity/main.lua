io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

local playerModule = require("player")
local collisionModule = require("collision")
local gridModule = require("grid")

function love.load()
  playerModule.loadPlayer()
  gridModule.loadBuildedTiles()
end

function love.update(dt)
  playerModule.updatePlayer(dt)
end

function love.draw()
  playerModule.drawPlayer()
  collisionModule.drawColliders()
  gridModule.drawTilesOnGrid()
end