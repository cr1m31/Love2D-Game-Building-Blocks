local collisionModule = {}

function collisionModule.aabbCollision(aa, bb)
  bb.width = 20
  bb.height = 20
  return aa.x < bb.x + bb.width and
    aa.x + aa.width > bb.x and
    aa.y < bb.y + bb.height and
    aa.y + aa.height > bb.y 
end

return collisionModule