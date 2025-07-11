local doorsModule = {}

local doors = {}

function createDoor(xP, yP, wP, hP, destMap, currMap)
    table.insert(doors, {
        x = xP,
        y = yP,
        width = wP,
        height = hP,
        destinationMap = destinationMap,
        currentMap = currMap,
    })
end

createDoor(120,50,40,80, "map-1", "map-2")

function doorsModule.getDoors()
    if(doors) then
        return doors
    else
        return nil
    end
end


function doorsModule.drawDoors()
    if(doors) then
        for doorNum, door in ipairs(doors) do
            love.graphics.rectangle("fill", door.x, door.y, door.width, door.height)
        end
    end
end


return doorsModule