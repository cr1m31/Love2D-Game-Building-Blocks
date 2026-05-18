local objects_4 = {}
local players = {}

local function createPlayer(x, y)
    local player = {x = x, y = y}
    
    table.insert(players, player)

    return player
end

local function movePlayer(player, dx, dy)
  player.x = player.x + dx
  player.y = player.y + dy
end

function objects_4.load()
  createPlayer(100, 100)
  createPlayer(300, 200)
end

function objects_4.update()
  for _, player in ipairs(players) do
    movePlayer( player, math.random(-2, 2), math.random(-2, 2) )
  end
end

function objects_4.draw()
    for _, player in ipairs(players) do
        love.graphics.rectangle("line", player.x, player.y, 50, 50)
    end
end

return objects_4