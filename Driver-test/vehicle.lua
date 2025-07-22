local vehicleModule = {}

local selectedVehicle = 1


local vehicleImageList = {
    love.graphics.newImage("images/BuickerB.png"),
    love.graphics.newImage("images/GalardB.png"),
    love.graphics.newImage("images/RamB.png"),
    love.graphics.newImage("images/SuperB.png")
}

local vehicle = {
    x = 0,
    y = 0,
    speed = 0,
    height = 0,
    width = 0,
    brakes = 0,
    acceleration = 0,
    turnForce = 2
}

local road = {
    x = 0,
    y = 0,
    width = 0,
    height = 0
}

local vehicleImg = vehicleImageList[1]

function vehicleModule.chooseCar()
    
    vehicleImg = vehicleImageList[selectedVehicle]

    vehicle.width = vehicleImg:getWidth()    
    vehicle.height = vehicleImg:getHeight()

    selectedVehicle = selectedVehicle + 1

    if(selectedVehicle > #vehicleImageList) then
        selectedVehicle = 1
    end
 end


function vehicleModule.getVehicle()
    return vehicle
end

function vehicleControl(dt)
    if love.keyboard.isDown("d") then
        vehicle.x = vehicle.x + vehicle.speed * dt * vehicle.turnForce
    end

    if love.keyboard.isDown("a") then
        vehicle.x = vehicle.x - vehicle.speed * dt * vehicle.turnForce
    end

    if love.keyboard.isDown("w") then
        vehicle.y = vehicle.y - vehicle.speed * dt / vehicle.acceleration
    end

    if love.keyboard.isDown("s") then
        vehicle.y = vehicle.y + vehicle.speed * dt * vehicle.brakes
    end
end

function checkIfVehicleOnTheRoad()
    if vehicle.x < road.x then
        vehicle.x = road.x
    end

    if vehicle.x + vehicle.width > road.x + road.width then
        vehicle.x = road.x + road.width - vehicle.width
    end

    if vehicle.y < road.y then
        vehicle.y = road.y
    end

    if vehicle.y + vehicle.height > road.y + road.height then
        vehicle.y = road.y + road.height - vehicle.height
    end

end

function vehicleModule.update(dt)
    vehicleControl(dt)
    checkIfVehicleOnTheRoad()
end

function vehicleModule.load()
    
    road.x = 135
    road.width = screenWidth - road.x * 1.68
    road.height = screenHeight

    vehicle.brakes = 2
    vehicle.acceleration = 2
    
    vehicle.speed = 100

    vehicle.x = screenWidth / 2 - vehicleImg:getWidth() / 2
    vehicle.y = screenHeight / 1.1 - vehicleImg:getHeight() / 2
    vehicle.width = vehicleImg:getWidth()    
    vehicle.height = vehicleImg:getHeight()
end

function vehicleModule.draw()

    -- love.graphics.setColor(1, 0, 0)
    -- love.graphics.rectangle("fill", road.x, road.y, road.width, road.height)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(vehicleImg, vehicle.x, vehicle.y, 0, 1, 1, 1, 1)

    -- love.graphics.rectangle("line", vehicle.x, vehicle.y, vehicle.width, vehicle.height)    
end

return vehicleModule