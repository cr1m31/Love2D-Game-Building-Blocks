local playerModule = {}

local player = {
  x = 100,
  y = 200,
  width = 40,
  height = 60
}

function playerModule.getPlayerPosAndDimensions()
  return player.x, player.y, player.width, player.height
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
end

return playerModule