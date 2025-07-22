local debugDeltaModule = {}

local hasJumpedHeight = false -- for jump height print control
local hasJumpedLength = false -- for jump length print control

local jumpStartX = nil
local jumpEndX = nil
local jumpInProgress = false -- true while player is in the air

function debugDeltaModule.trackJumpStart(player, wasGrounded)
    -- Track jump start for height as before
    if (player.isGrounded or player.coyoteTimer > 0) and not hasJumpedHeight then
        player.jumpStartY = player.y
        player.jumpPeakY = player.y
        player.jumpHeight = nil
        hasJumpedHeight = true
    end
end

function debugDeltaModule.trackJumpPeak(player)
    if not player.isGrounded then
        if player.y < (player.jumpPeakY or player.y) then
            player.jumpPeakY = player.y
        end
    end
end

function debugDeltaModule.computeJumpHeightOnLand(player, wasGrounded)
    if not wasGrounded and player.isGrounded and player.jumpStartY and player.jumpPeakY and hasJumpedHeight then
        player.jumpHeight = player.jumpStartY - player.jumpPeakY
        print("Jump height (pixels): " .. string.format("%.2f", player.jumpHeight))
        hasJumpedHeight = false
    end
end

-- Track jump length start when player leaves ground
function debugDeltaModule.trackJumpStartX(player, wasGrounded)
    if wasGrounded and not player.isGrounded and not jumpInProgress then
        jumpStartX = player.x
        jumpInProgress = true
        hasJumpedLength = true
    end
end

function debugDeltaModule.computeJumpLengthOnLand(player, wasGrounded)
    if jumpInProgress and not wasGrounded and player.isGrounded and jumpStartX and hasJumpedLength then
        jumpEndX = player.x
        local jumpLength = jumpEndX - jumpStartX
        print("Jump length (pixels): " .. string.format("%.2f", math.abs(jumpLength) ))
        jumpStartX = nil
        jumpEndX = nil
        jumpInProgress = false
        hasJumpedLength = false
    end
end

return debugDeltaModule
