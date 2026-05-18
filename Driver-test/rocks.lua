local rockModule = {}

rock10 = love.graphics.newImage("Images/rocks/rock-low10.png")
rock15 = love.graphics.newImage("Images/rocks/rock-low15.png")

local backgroundMod = require("background")

local particlesMod = require("particles")

local counter = 0
minCounterToSpawnRock = 0
local maxCounterToSpawnRock = 3

local rockList = {}

function rockModule.createRock(pX, pY, pType)
    local rock = {
        x = pX,
        y = pY,
        type = pType,
        image = nil, 

        height = 0, 
        width = 0
    }

    if pType == "rock10" then
        rock.image = rock10
    elseif pType == "rock15" then
        rock.image = rock15
    end

    rock.height = rock.image:getHeight()
    rock.width = rock.image:getWidth()

    table.insert(rockList, rock)
    return rock
end


function rockModule.checkIfRockIsOffScreen()
    for i, v in ipairs(rockList) do
        if v.y > screenHeight then
            table.remove(rockList, i)
        end
    end
end

function rockModule.moveRocks(dt)
    for i, v in ipairs(rockList) do
        v.y = v.y + backgroundMod.getBackground().scrollingSpeed * dt
    end
end

function rockModule.checkRockCollision(a)
    for i, v in ipairs(rockList) do
        if a.x < v.x + v.width and
            a.x + a.width > v.x and
            a.y < v.y + v.height and
            a.y + a.height > v.y then

                table.remove(rockList, i)

                particlesMod.loopCreate(10, v.x, v.y, 0.5, rock10)                
        end
    end
end

function rockModule.rockSpawner(dt)
    counter = counter + dt

    if( counter >= math.random(minCounterToSpawnRock, maxCounterToSpawnRock) ) then
        rockModule.createRock(math.random(135, screenWidth / 1.17), -50, "rock10")
        counter = 0
    end

end

function rockModule.draw()
    for i, v in ipairs(rockList) do
        love.graphics.draw(v.image, v.x, v.y, 0, 1, 1, 1, 1)
    end
end

return rockModule