io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game
-- disable anti aliasing
love.graphics.setDefaultFilter("nearest", "nearest", 1)

love.window.setMode( 1024, 768)

local playerModule = require("player")
local collisionModule = require("collision")
local gridModule = require("grid")

function love.load()
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