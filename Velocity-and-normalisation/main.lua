local SCREENWIDTH = love.graphics.getWidth()
local SCREENHEIGHT = love.graphics.getHeight()

local origin = {x = SCREENWIDTH / 2, y = SCREENHEIGHT / 2}
local vector = {x = 0, y = 0}
local tip = {x = 0, y = 0}

function getVectorTip(origin, vector)
  return {
    x = origin.x + vector.x,
    y = origin.y + vector.y
  }
end

function love.update()
  local mouseX, mouseY = love.mouse.getPosition()

  -- compute vector from origin to mouse
  vector.x = mouseX - origin.x
  vector.y = mouseY - origin.y

  -- compute tip using vector math
  tip = getVectorTip(origin, vector)
end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.setLineWidth(2)
  love.graphics.line(origin.x, origin.y, tip.x, tip.y)

  love.graphics.setColor(0, 1, 0)
  love.graphics.circle("fill", origin.x, origin.y, 5)

  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle("fill", tip.x - 4, tip.y - 4, 8, 8)
end
