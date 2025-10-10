local SCREENWIDTH = love.graphics.getWidth()
local SCREENHEIGHT = love.graphics.getHeight()

local vector2D = {
  x1 = SCREENWIDTH / 2,
  y1 = SCREENHEIGHT / 2,
  x2 = 500,
  y2 = 250,
}

local vector = {
  x = 0,
  y = 0,
}

local origin = {
  x = 0,
  y = 0,
}

local vectorMatrix = {
  {100}, -- x
  {400}, -- y
}

function love.load()
  vector.x = 250
  vector.y = 100
  
  origin.x = 100
  origin.y = 250
end

function love.update()
  local mouseX, mouseY = love.mouse.getPosition()
  vector.x = mouseX - 8
  vector.y = mouseY - 8

  
end

print("vec matrix x : " .. vectorMatrix[1][1]) -- x
print("vec matrix y : " .. vectorMatrix[2][1]) -- y

function love.draw()
  love.graphics.line(vector2D.x1, vector2D.y1, vector2D.x2, vector2D.y2)
  
  
  love.graphics.circle("fill", origin.x, origin.y, 8)
  love.graphics.line(origin.x, origin.y, vector.x + 8, vector.y + 8)
  love.graphics.rectangle("fill", vector.x, vector.y, 16, 16)
  
  love.graphics.line(origin.x, origin.y, vectorMatrix[1][1] + 8, vectorMatrix[2][1] + 8)
  love.graphics.rectangle("line", vectorMatrix[1][1], vectorMatrix[2][1], 16, 16)
end
