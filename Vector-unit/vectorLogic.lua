local vectorUnitModule = {}

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local origin = {
  x = 0,
  y = 0
}

local vector = {
  x = 100,
  y = 0
}

local vectorLimitBox = {
  x = 0,
  y = 0,
  width = 0,
  height = 0
}

vectorLimitBox.width = 100
vectorLimitBox.height = 100

local vectorDrawLengthModifier = 50

function vectorUnitModule.getNormalizedVector()
  local magnitude = math.sqrt( (vector.x * vector.x) + (vector.y * vector.y) )
  return vector.x / magnitude, vector.y / magnitude, magnitude
end

function vectorUnitModule.update(playerInst)
  origin.x = playerInst.x + playerInst.width * 0.5
  origin.y = playerInst.y + playerInst.height * 0.5

  vectorLimitBox.x = playerInst.x
  vectorLimitBox.y = playerInst.y

  vector.x = playerInst.velocity.x
  vector.y = playerInst.velocity.y
end

function vectorUnitModule.draw()
  love.graphics.print("normalized vector :" .. vectorUnitModule.getNormalizedVector() .. " vecx : " .. vector.x .. " vecy : " .. vector.y, 250, 400 )
  
  love.graphics.line(origin.x, origin.y, origin.x + (vector.x * vectorDrawLengthModifier), origin.y + (vector.y * vectorDrawLengthModifier ))
  
  love.graphics.circle("line", origin.x + vector.x, origin.y + vector.y, 10) 
  
  love.graphics.rectangle("line", origin.x - 50, origin.y - 50, 100, 100)
end

return vectorUnitModule