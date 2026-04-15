local vectorModule = {}

function vectorModule.normalizeInput(inX, inY)
  local magnitude = math.sqrt(inX * inX + inY * inY)
  
  if magnitude == 0 then
    return 0, 0 -- prevent returning nill if no magnitude also prevents zero division
  end
  
  return inX / magnitude, inY / magnitude
end
local timer = 0
function vectorModule.timerTest(dt)
  
  timer = timer + dt
  return timer
end

function vectorModule.resetTimer()
  timer = 0
end


return vectorModule