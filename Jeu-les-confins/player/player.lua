local playerModule = {}

local gateManagerModule = require("gateManager")
local movementPhysicsModule = require("player.movementPhysics")
local collisionModule = require("collision")
local mapManagerModule = require("mapManager")

local debugDeltaModule = require("debug-delta-time")

local visualVectorLineLengthMultiplier = 0.5

local player = {
  x = 50,
  y = 600,
  width = 0,
  height = 0,
  speed = 1200, -- watch for tunneling problem if speed too high
  velocity = {x = 0, y = 0},
  maxVelocity = {x = 200, y = 400},
  friction = {x = 11, y = 5},
  groundCollider = {x = 0, y = 0, width = 0, height = 0},
  -- jumpforce can not be greater than max velocity
  jumpForce = 180,
  mass = 400,
  image = love.graphics.newImage("images/player-test.png"),
  isGrounded = false,
  coyoteTimer = 0,
  coyoteTimeDelay = 0.15,
  isJumping = false,
  gravityAscendMultiplier = 0.5,
  gravityDescendMultiplier = 1.5,
}

local playerImageRotationAngle = 0
local playerImageScaleX = 2
local playerImageScaleY = 2

function playerModule.loadPlayer()
  -- set player physics shape as the image size
  player.width = player.image:getWidth() * playerImageScaleX
  player.height = player.image:getHeight() * playerImageScaleY

  -- set ground collider position and size
  
  player.groundCollider.width = player.width - 4
  player.groundCollider.height = 3
end

function playerModule.updatePlayer(realDt, fixedStep)

  local wasGrounded = player.isGrounded

  -- Physics: use fixedStep
  movementPhysicsModule.movePlayer(player, fixedStep)
  movementPhysicsModule.addFrictionToPlayer(player, fixedStep)
  movementPhysicsModule.updateCoyoteTime(player, fixedStep)

  debugDeltaModule.trackJumpStart(player, wasGrounded)
  debugDeltaModule.trackJumpStartX(player, wasGrounded)
  
  if not player.isGrounded then
    debugDeltaModule.trackJumpPeak(player)
    movementPhysicsModule.addGravity(player, fixedStep)
  end

  debugDeltaModule.computeJumpHeightOnLand(player, wasGrounded)
  debugDeltaModule.computeJumpLengthOnLand(player, wasGrounded)
  
  -- Logic not needing physics precision: use realDt
  gateManagerModule.checkGateCollision(player) -- (not timing-based)
  collisionModule.updateGroundCollider(player) -- (positional)

  -- trail effect update
  updateTrailEffect(realDt, player.x + player.width / 2, player.y + player.height / 2, player.width / 10, player.height / 10)
end



function velocityPerspectiveX(factor)
  return playerImageScaleX - math.abs(player.velocity.x * 0.03)
end

function playerModule.drawPlayer()
  
  love.graphics.draw(
    player.image,
    player.x + player.width / 2,
    player.y + player.height / 2,
    playerImageRotationAngle,
    velocityPerspectiveX(0.3),
    playerImageScaleY,
    player.image:getWidth() / 2,
    player.image:getHeight() / 2
  )

  debugPlayerDraw()

  debugTrailEffect()

end


local trailRectangles = {}
local trailCreateTimer = 0
local trailDeleteTimer = 0

local trailInterval = 0.08           -- how often to create a new rectangle (in seconds)
local trailDeleteInterval = 0.05      -- how often to delete old rectangles (in seconds)
local maxTrailLength = 50            -- target trail length (can be adjusted anytime)

function updateTrailEffect(dt, x, y, w, h)
  local velocityThreshold = 5
  local isMoving = math.abs(player.velocity.x) >= velocityThreshold or math.abs(player.velocity.y) >= velocityThreshold

  -- Create new trail rectangles only while player is moving
  if isMoving then
    trailCreateTimer = trailCreateTimer + dt
    if trailCreateTimer >= trailInterval then
      table.insert(trailRectangles, {
        x = x,
        y = y,
        width = w,
        height = h,
      })
      trailCreateTimer = 0
    end
  end

  -- Always delete old rectangles at a regular interval
  trailDeleteTimer = trailDeleteTimer + dt
  if trailDeleteTimer >= trailDeleteInterval and #trailRectangles > 1 then
    if #trailRectangles > maxTrailLength or not isMoving then
      table.remove(trailRectangles, 1)
    end
    trailDeleteTimer = 0
  end
end





function debugTrailEffect()
  love.graphics.setColor(1,0,0)

  for i, v in ipairs(trailRectangles) do
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end
  love.graphics.print("number of trail rectangles: " .. #trailRectangles, 250, 300)
  love.graphics.setColor(1,1,1)
end

function debugPlayerDraw()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  -- draw velocity line
  love.graphics.line(
    player.x + (player.width / 2),
    player.y + (player.height / 2),
    player.x + (player.width / 2) + (player.velocity.x * visualVectorLineLengthMultiplier),
    player.y + (player.height / 2) + (player.velocity.y * visualVectorLineLengthMultiplier)
  )

  -- draw player's ground collider
  love.graphics.rectangle(
    "line",
    player.groundCollider.x,
    player.groundCollider.y,
    player.groundCollider.width,
    player.groundCollider.height
  )

  love.graphics.print("ground coll: " .. tostring(collisionModule.checkGroundCollision(player)), 200, 200)
  love.graphics.print("coyoteTimer: " .. string.format("%.2f", player.coyoteTimer), 200, 220)
  love.graphics.print("vel Y: " .. player.velocity.y, 200, 260)

end

function love.keypressed(key, scancode, isrepeat)

  if key == "space"
    and (player.isGrounded or player.coyoteTimer > 0)
    and player.velocity.y >= 0 -- prevent double jump while moving up
  then
    movementPhysicsModule.playerJump(player)
  end



  if key == "left" then
    changeMap(-1)
  end
  if key == "right" then
    changeMap(1)
  end
end

local currentMapNum = 1
local numberOfMaps = 4
function changeMap(incrementDecrement)
  if (currentMapNum + incrementDecrement >= 1 and currentMapNum + incrementDecrement <= numberOfMaps) then
    currentMapNum = currentMapNum + incrementDecrement  
  end
  local mapNameDebut = "map-"
  -- print(mapNameDebut .. currentMapNum)
  mapManagerModule.loadMapPackageAndBuildTiles(mapNameDebut .. currentMapNum)
end



return playerModule
