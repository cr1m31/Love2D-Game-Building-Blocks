local SCREENWIDTH = love.graphics.getWidth()
local SCREENHEIGHT = love.graphics.getHeight()

-- a column vector
-- (x)
-- (y)

-- 2x2 matrix
-- [x , y]
-- [x1,y1]

-- it is better to use 3x3 matrix for any transformations (shearing, scaling, rotating, translating = moving)
-- because translating a set of points needs extra dimension in the matrix
-- and also to be able to use the same matrix shape on each operation to simplify the logic of functions

-- 3x3 matrix
-- [a,b,tx]
-- [c,d,ty]
-- [0, 0,1]

-- a, b	Control x (scaling, rotation, shear)
-- c, d	Control y (scaling, rotation, shear)
-- tx, ty	Translation (movement)
-- last row	0 0 1 → keeps matrix valid in 2D

-- and the vector x,y,1 that is used with such 3x3 matrix for operations
-- [x]
-- [y]
-- [1]

-- ' [v] = |magnitude| of vector'
-- find the  magnitude of a vector
-- [v] = square root of { (vX * vX) + (vY * vY) }

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

local matrixToProj = {
  {0,-80},
  {20,80},
}

local twoByTwoMatrixProjectionOnXAxis = {  -- [1 0] -- allow to project vector on x axis
  {1,0},                                   -- [0 0]
  {0,0},
}

local twoByTwoMatrixProjectionOnYAxis = {  -- [0 0] -- allow to project vector on y axis
  {0,0},                                   -- [0 1]
  {0,1},
}

function projectVectorHorizontally(vec, matrix)
  local a,b,c,d = matrix[1][1], matrix[1][2], matrix[2][1], matrix[2][2]
  vec[1][1] = vec[1][1] * a 
  vec[1][2] = vec[1][2] * b
  vec[2][1] = vec[2][1] * c
  vec[2][2] = vec[2][2] * d
end

function love.load()
  local a1,b1,c1,d1 = matrixToProj[1][1], matrixToProj[1][2], matrixToProj[2][1], matrixToProj[2][2]

  projectVectorHorizontally(matrixToProj, twoByTwoMatrixProjectionOnXAxis)

  
  print("a1: " .. a1 .. " b1: " .. b1 .. " c1: " .. c1 .. " d1: " .. d1)
  
end

function love.keypressed(key, scancode, isrepeat)
  if key == "left" then
    
  elseif  key == "right" then
    
  end
  
  if key == "up" then
    
  elseif key == "down" then 
    
  end
end

function love.draw()
  local offset = 80
  local a,b,c,d = matrixToProj[1][1], matrixToProj[1][2], matrixToProj[2][1], matrixToProj[2][2]
  love.graphics.line(a + offset,b + offset,c + offset,d + offset)
  love.graphics.print("initial point", a + offset, b + offset)
  love.graphics.print("end point", c + offset, d + offset)
end
