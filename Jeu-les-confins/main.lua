io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

love.window.setMode( 1024, 768)

local playerModule = require("player.player")
local mapManagerModule = require("mapManager")
local gateManagerModule = require("gateManager")

function love.load()
  playerModule.loadPlayer()
  mapManagerModule.loadMapPackageAndBuildTiles("map-1")
end

local accumulator = 0
local fixedStep = 1 / 60

-- Fixed timestep loop:
-- Ensures physics updates run at a consistent 60 times per second (1/60),
-- regardless of frame rate fluctuations. This keeps movement and physics
-- deterministic and consistent across all hardware.
function love.update(dt)
  accumulator = accumulator + dt
  while accumulator >= fixedStep do
    playerModule.updatePlayer(dt, fixedStep) -- Pass both real dt and fixedStep (used for physics)
    accumulator = accumulator - fixedStep
  end
end


function love.draw()
  playerModule.drawPlayer()
  mapManagerModule.drawMap()
  gateManagerModule.drawGates()

  -- debug processing
  -- Print FPS
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)

  -- Print memory usage in MB (formatted to 2 decimal places)
  local mem = collectgarbage("count") / 1024
  love.graphics.print(string.format("Memory: %.2f MB", mem), 10, 30)

end
