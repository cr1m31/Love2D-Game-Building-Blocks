io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

love.window.setMode( 1024, 768)

local playerModule = require("player")
local collisionModule = require("collision")
local mapTilesBuilderModule = require("mapTilesBuilder")

function love.load()
  mapTilesBuilderModule.loadBuiltTiles(1) -- arg = map number aka level number
end

function love.update(dt)
  playerModule.updatePlayer(dt)
end

function love.draw()
  playerModule.drawPlayer()
  collisionModule.drawColliders()
  mapTilesBuilderModule.drawTilesOnMap()
end

local currMapNum = 1
local numberOfMaps = 2
function love.keypressed(key, scancode, isrepeat)
	if key == "f" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "exclusive")
	end

  if key == "left" then
    if(currMapNum > 1) then
      currMapNum = currMapNum -1
      mapTilesBuilderModule.loadBuiltTiles(currMapNum)
    end
  end
  if key == "right" then
    if(currMapNum < numberOfMaps) then
      currMapNum = currMapNum + 1
      mapTilesBuilderModule.loadBuiltTiles(currMapNum)
    end
  end

end