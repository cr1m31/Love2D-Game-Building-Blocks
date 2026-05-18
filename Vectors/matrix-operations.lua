local SCREENWIDTH = love.graphics.getWidth()
local SCREENHEIGHT = love.graphics.getHeight()

--[[----------------------------------------------------------------------------
  2D VECTORS AND MATRICES (CURRENT IMPLEMENTATION)
  
  A 2D vector (point) is represented as:
    { x, y }

  A line is represented as two 2D vectors:
    {
      {x1, y1},  -- start point
      {x2, y2},  -- end point
    }

  We are currently using a **2x2 matrix** for linear transformations
  such as **projection**, **scaling**, **rotation**, or **shearing**
  (as long as translation is NOT required).

  A 2x2 matrix looks like:
      | a  b |
      | c  d |

  When multiplied by a vector (x, y), the result is:
      x' = a*x + b*y
      y' = c*x + d*y

  This is pure linear transformation around the origin (0,0).
  To include translation (movement), we would need a 3x3 matrix
  and homogeneous coordinates (x, y, 1). That’s optional and can
  be added later when we upgrade to full transformation matrices.
  
  
  
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
----------------------------------------------------------------------------]]--

-- Initial line segment (two points)
local line = {
    {0, -80},  -- start point (x1, y1)
    {20,  80}, -- end point   (x2, y2)
}

-- 2x2 projection matrix onto the X-axis
-- Effect: keep x component, remove y component
local PROJ_X_AXIS = {
    {1, 0},
    {0, 0},
}

-- 2x2 projection matrix onto the Y-axis
-- Effect: remove x component, keep y component
local PROJ_Y_AXIS = {
    {0, 0},
    {0, 1},
}

-- Multiply a 2D vector (x,y) by a 2x2 matrix
function projectVector(v, m)
    local x = v[1]
    local y = v[2]
    v[1] = m[1][1] * x + m[1][2] * y
    v[2] = m[2][1] * x + m[2][2] * y
end

-- Apply projection to a line (two vectors)
function projectLine(line, m)
    projectVector(line[1], m)
    projectVector(line[2], m)
end

function love.load()
    -- Project the initial line onto the X-axis as a default example
    projectLine(line, PROJ_X_AXIS)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "left" then
        -- reset and project on X-axis
        line = {
            {0, -80},
            {20, 80}
        }
        projectLine(line, PROJ_X_AXIS)

    elseif key == "right" then
        -- reset and project on Y-axis
        line = {
            {0, -80},
            {20, 80}
        }
        projectLine(line, PROJ_Y_AXIS)
    end
end

function love.draw()
    local offset = 80
    local x1, y1 = line[1][1] + offset, line[1][2] + offset
    local x2, y2 = line[2][1] + offset, line[2][2] + offset

    love.graphics.line(x1, y1, x2, y2)
    love.graphics.print("start", x1, y1)
    love.graphics.print("end", x2, y2)
end
