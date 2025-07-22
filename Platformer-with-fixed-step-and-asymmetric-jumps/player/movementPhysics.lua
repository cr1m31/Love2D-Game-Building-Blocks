local movementPhysicsModule = {}

local collisionModule = require("collision")
local velocityModule = require("velocity")
local frictionModule = require("friction")

local ENABLE_JUMP_DEBUG = true

function movementPhysicsModule.movePlayer(player, fixedStep)

  movePlayerHorizontally(player, fixedStep)

  -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- FIRST RESOLVE VELOCITY MAX LIMIT BEFORE TO IMLEMENT FRICTION

  -- move player's horizontal position with velocity
  -- !! to add before collisions
  player.x = player.x + velocityModule.limitMaxVelocityX(player.velocity, player.maxVelocity) * fixedStep

  -- check horizontal collision after moving horizontally
  collisionModule.checkPlayerHorizonTalCollision(player)

  movePlayerVertically(player, fixedStep)

  -- move player's vertical position with velocity
  -- !! to add before collisions
  player.y = player.y + velocityModule.limitMaxVelocityY(player.velocity, player.maxVelocity) * fixedStep

  -- check vertical collision after moving vertically
  collisionModule.checkPlayerVerticalcollision(player)

end

function movePlayerHorizontally(player, fixedStep)
  if love.keyboard.isDown("a") then
    player.velocity.x = player.velocity.x - player.speed * fixedStep
  end
  if love.keyboard.isDown("d") then
    player.velocity.x = player.velocity.x + player.speed * fixedStep
  end
end

function movePlayerVertically(player, fixedStep)
  if love.keyboard.isDown("w") then
    player.velocity.y = player.velocity.y - player.speed * fixedStep
  end
  if love.keyboard.isDown("s") then
    player.velocity.y = player.velocity.y + player.speed * fixedStep
  end
end

function movementPhysicsModule.addFrictionToPlayer(player, fixedStep)
  -- always add momentum friction 
  frictionModule.addHorizontalFriction(player, player.friction.x, fixedStep)
  -- frictionModule.addVerticalFriction(player, player.friction.y, fixedStep)
end

function movementPhysicsModule.playerJump(player)
  -- applying force directly to prevent gravity to decrease jump force when coyote time is used
  player.velocity.y = - player.jumpForce

  player.isJumping = true
end

function movementPhysicsModule.addGravity(player, fixedStep)
  if player.velocity.y < 0 then -- check if player is moving up or down
    player.velocity.y = player.velocity.y + (player.mass * player.gravityAscendMultiplier) * fixedStep
  else
    player.velocity.y = player.velocity.y + (player.mass * player.gravityDescendMultiplier) * fixedStep
  end
end

function setIfPlayerIsGrounded(player)
  if collisionModule.checkGroundCollision(player) then
    player.isGrounded = true
  else
    player.isGrounded = false
  end
end

function movementPhysicsModule.updateCoyoteTime(player, fixedStep)
  setIfPlayerIsGrounded(player)
  if player.isGrounded  then
    player.coyoteTimer = player.coyoteTimeDelay
  else
    player.coyoteTimer = math.max(player.coyoteTimer - fixedStep, 0)
  end
end

return movementPhysicsModule
