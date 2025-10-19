local SCREENWIDTH = love.graphics.getWidth()
local SCREENHEIGHT = love.graphics.getHeight()

-- vector formulas

-- matrix
-- [i , j]  (i = x, j = y) = x and y of the vector tip or arrow or direction
-- [aX,aY] = vector a
-- [bX,bY] = vector b

-- how to multiply two vectors (and obtain a third vector c) with a formula and matrix
--  (aY - bY)i + (bX - aX)j
--  (  cX   )i + (   cY  )j

-- a column vector
-- [x]
-- [y]

-- 2x2 matrix
-- [x , y]
-- [x1,y1]


-- ' [v] = |magnitude| of vector'
-- find the  magnitude of a vector
-- [v] = square root of { (vX * vX) + (vY * vY) }


-- first vector code structure or type, with 4 variables (origin and vector tip)
local vectorArrow = {
  x1 = SCREENWIDTH / 2, -- origin
  y1 = SCREENHEIGHT / 2, -- origin
  x2 = 500, -- end point
  y2 = 250, -- end point
}

-- 2x2 matrix
local twoByTwoMatrix = {
  {1,2}, -- {a,b}, or {x1,y1}
  {3,4}, -- {c,d},    {x2,y2}
}

local twoByTwoMatrix2 = {
    {a},
    {b},
    {c},
    {d},
}

local twoByTwoMatrixProjectionOnXAxis = {  -- [1 0] -- allow to project vector on x axis
  {1,0},                                   -- [0 0]
  {0,0},
}

local twoByTwoMatrixProjectionOnYAxis = {  -- [0 0] -- allow to project vector on y axis
  {0,0},                                   -- [0 1]
  {0,1},
}

--print("a: x1 : " .. twoByTwoMatrix[1][1])
--print("b: y1 : " .. twoByTwoMatrix[1][2])
--print("c: x2 : " .. twoByTwoMatrix[2][1])
--print("d: y2 : " .. twoByTwoMatrix[2][2])

for i = 1, #twoByTwoMatrix do
  --print("i: " .. i)
  for j = 1, #twoByTwoMatrix[i] do
    --print(" j: " .. j)
    
    
    --print("twoByTwoMatrix: " .. twoByTwoMatrix[i][j])
    
    if i == 1 and j == 1 then
      print(" x1 " .. twoByTwoMatrix[i][j])
    elseif i == 1 and j == 2 then
      print(" y1 " .. twoByTwoMatrix[i][j])
    end
    if j == 2 then
      print("y1 and y2 " .. twoByTwoMatrix[i][j])
    end
  end
end

-- second vector code structure in two parts, origin and end, tip, direction or arrow
local directionalVector = {
  x = 0,
  y = 0,
}

local vectorOrigin = {
  x = 0,
  y = 0,
}

-- third vector code structure made as a table matrix to allow looping computing with indexes
local directionalVectorMatrix = {
  {100}, -- x
  {400}, -- y
}

local vectorOriginHookTest = {
  x = 0,
  y = 0,
}

function love.load()
  vectorOrigin.x = 100
  vectorOrigin.y = 250
  directionalVector.x = 250
  directionalVector.y = 100
end

-- create a function to add to vectors like position + vector to create the full vector = origin + vector
function testAddingOriginTodirectionalVectorMatrix(originX, originY)
  directionalVectorMatrix[1][1] = vectorOrigin.x + originX
  directionalVectorMatrix[2][1] = vectorOrigin.y + originY
end

local xOriginOfVectorMatrix = 0
local yOriginOfVectorMatrix = 0
function love.keypressed(key, scancode, isrepeat)
  if key == "left" then
    testAddingOriginTodirectionalVectorMatrix(- 60, 0)
  elseif  key == "right" then
    testAddingOriginTodirectionalVectorMatrix(60, 0)
  end
  
  if key == "up" then
    testAddingOriginTodirectionalVectorMatrix(0, - 60)
  elseif key == "down" then 
    testAddingOriginTodirectionalVectorMatrix(0, 60)
  end
end

function love.draw()
  love.graphics.line(vectorArrow.x1, vectorArrow.y1, vectorArrow.x2, vectorArrow.y2)
  
  love.graphics.circle("fill", vectorOrigin.x, vectorOrigin.y, 8)
  love.graphics.line(vectorOrigin.x, vectorOrigin.y, directionalVector.x + 8, directionalVector.y + 8)
  love.graphics.rectangle("fill", directionalVector.x, directionalVector.y, 16, 16)
  
  love.graphics.line(vectorOrigin.x, vectorOrigin.y, directionalVectorMatrix[1][1] + 8, directionalVectorMatrix[2][1] + 8)
  love.graphics.print("direction", directionalVectorMatrix[1][1], directionalVectorMatrix[2][1] - 20)
  love.graphics.rectangle("line", directionalVectorMatrix[1][1], directionalVectorMatrix[2][1], 16, 16)
end
