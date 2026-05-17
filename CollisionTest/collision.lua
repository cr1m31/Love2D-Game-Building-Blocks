local collisionModule = {}

function collisionModule.collisionAABB(player, collision)
  return player.x + player.width > collision.x and
  player.x < collision.x + collision.width and
  player.y + player.height > collision.y and
  player.y < collision.y + collision.height
end

return collisionModule