local playerModule = {}

local player = {
  x = 100,
  y = 100,
  width = 30,
  height = 50,
}

function playerModule.update(dt)

end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
end

return playerModule