local collisionModule = {}

local colliders ={}
function createCollider(xP, yP, wP, hP)
  local newCollider = {
    x = xP,
    y = yP,
    width = wP,
    height = hP,
  }
  table.insert(colliders, newCollider)
end

function collisionModule.createColliders()
  -- createCollider(100, 200, 80, 80)
  
  for i =1, 3 do
    createCollider(85 * i, 200, 80, 80)
  end
end

local colliding = nil
function collisionModule.collisionAABB(aa)
  for i, bb in ipairs(colliders) do
    if not (aa.x + aa.width < bb.x or 
      aa.x > bb.x + bb.width or
      aa.y + aa.height < bb.y or
      aa.y > bb.y + bb.height) then 
      return true
    end
  end
  return false
end

function collisionModule.drawColliders()
  for i, v in ipairs(colliders) do
    love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
  end
end

return collisionModule