io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

love.window.setMode( 1024, 768)

local playerModule = require("player")
local collisionModule = require("collision")
local gridModule = require("grid")

function love.load()
  gridModule.loadBuildedTiles(1) -- arg = grid number aka level number
end

function love.update(dt)
  playerModule.updatePlayer(dt)
end

function love.draw()
  playerModule.drawPlayer()
  collisionModule.drawColliders()
  gridModule.drawTilesOnGrid()
end


function love.keypressed(key, scancode, isrepeat)
	if key == "f" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "exclusive")
	end
end