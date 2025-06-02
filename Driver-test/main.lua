-- love.window.setFullscreen(true, "desktop")

love.graphics.setDefaultFilter("nearest", "nearest", 0)

screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

local menuMod = require("menu")

local backgroundMod = require("background")

local particlesMod = require("particles")

local vehicleMod = require("vehicle")

local rockMod = require("rocks")

function love.load()

    backgroundMod.load()

    vehicleMod.load()
    
    -- params = x, y, type
    rockMod.createRock(screenWidth / math.random(1, 7), screenHeight / 8, "rock15")
end

function love.update(dt)
    if(menuMod.getMenuState() == false) then

        rockMod.rockSpawner(dt)

        vehicleMod.update(dt)
    
        backgroundMod.backgroundScrolling(dt)

        backgroundMod.resetBackground()

        rockMod.moveRocks(dt)

        rockMod.checkIfRockIsOffScreen()

        rockMod.checkRockCollision(vehicleMod.getVehicle())

        particlesMod.spread(dt)

    end
end

function love.draw()

    if(menuMod.getMenuState()) then
    
        menuMod.draw()
    
    else
        backgroundMod.draw()

        vehicleMod.draw()
    
        rockMod.draw()

        particlesMod.draw()
    end

end

function love.keypressed( key, scancode, isrepeat )
    -- toggle menu
    if scancode == "return" then 
       menuMod.setMenuState(false)
    end
    if scancode == "escape" then  
        menuMod.setMenuState(true)
    end

    if scancode == "space" then 
        vehicleMod.chooseCar()
    end
 end


