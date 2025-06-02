local playerModule = require("player")
local collisionModule = require("collision")

function love.load()
  collisionModule.createColliders()
end

function love.update(dt)
  playerModule.updatePlayer(dt)
end

function love.draw()
  playerModule.drawPlayer()
  collisionModule.drawColliders()
end