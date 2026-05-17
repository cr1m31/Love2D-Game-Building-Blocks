local objects_3 = {}

local player = {
  
  x = 0,
  y = 0,
  
  movePlayer = function(self, x, y)
    self.x = self.x + x
    self.y = self.y + y
  end
  
}


function objects_3.moduleFunction()
  player.movePlayer(player, 200, 200)
end

function objects_3.draw()
  love.graphics.rectangle("line", player.x, player.y, 50, 50)
end
return objects_3