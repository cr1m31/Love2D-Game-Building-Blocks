io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

love.window.setMode( 1024, 768)

local playerModule = require("player")

local mapManagerModule = require("mapManager")

local gateManagerModule = require("gateManager")


function love.load()
  mapManagerModule.loadMapPackageAndBuildTiles("map-3")

  gateManagerModule.loadGates()
end

function love.update(dt)
  playerModule.updatePlayer(dt)

end

function love.draw()
  playerModule.drawPlayer()
  mapManagerModule.drawMap()


  gateManagerModule.drawGates()
end
