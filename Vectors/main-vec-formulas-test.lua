io.stdout:setvbuf("no")

local SCREENWIDTH = love.graphics.getWidth()
local SCREENHEIGHT = love.graphics.getHeight()

-- === Vector math helper functions ===
local function addVectors(a, b)
  return { x = a.x + b.x, y = a.y + b.y }
end

local function magnitude(v)
  return math.sqrt(v.x * v.x + v.y * v.y)
end

local function normalize(v)
  local mag = magnitude(v)
  if mag == 0 then return {x = 0, y = 0} end
  return { x = v.x / mag, y = v.y / mag }
end

-- === Game data ===
local player = {
  pos = { x = SCREENWIDTH / 2, y = SCREENHEIGHT / 2 },
  vel = { x = 0, y = 0 },
  speed = 200 -- pixels per second
}

function love.update(dt)
  local move = { x = 0, y = 0 }

  -- continuous input
  if love.keyboard.isDown("left") then
    move.x = move.x - 1
  end
  if love.keyboard.isDown("right") then
    move.x = move.x + 1
  end
  if love.keyboard.isDown("up") then
    move.y = move.y - 1
  end
  if love.keyboard.isDown("down") then
    move.y = move.y + 1
  end

  -- normalize so diagonals aren’t faster
  move = normalize(move)

  -- apply speed and delta time
  player.vel.x = move.x * player.speed * dt
  player.vel.y = move.y * player.speed * dt

  -- update position
  player.pos = addVectors(player.pos, player.vel)
end

function love.draw()
  love.graphics.circle("fill", player.pos.x, player.pos.y, 10)

  love.graphics.print("Use arrow keys to move (diagonal normalized)", 10, 10)
  love.graphics.print(string.format("Velocity: (%.2f, %.2f)", player.vel.x, player.vel.y), 10, 30)
end
