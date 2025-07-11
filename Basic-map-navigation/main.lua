io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

love.window.setMode( 1024, 768)

local playerModule = require("player")

local mapManagerModule = require("mapManager")


function love.load()
  mapManagerModule.loadMapPackageAndBuildTiles("map-1")
end

function love.update(dt)
  playerModule.updatePlayer(dt)

end

function love.draw()
  playerModule.drawPlayer()
  mapManagerModule.drawMap()
end

function love.keypressed(key, scancode, isrepeat)
  if(key == "right") then
    mapManagerModule.loadMapPackageAndBuildTiles(mapManagerModule.getCurrentMap().nextMap)
  end
  if(key == "left") then
    mapManagerModule.loadMapPackageAndBuildTiles(mapManagerModule.getCurrentMap().previousMap)
  end
end
