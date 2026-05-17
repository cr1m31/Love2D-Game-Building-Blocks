local backgroundModule = {}

local screenVsBackgroundHeight = 0

backgroundImg = love.graphics.newImage("Images/background-1.png")
backgroundImg2 = love.graphics.newImage("Images/background-1.png")

local background = {
    imgX = 0,
    imgY = 0,
    img2X = 0,
    img2Y = 0,
    img = backgroundImg,
    img2 = backgroundImg2,
    scrollingSpeed = 0,
    height = 0
}

function backgroundModule.getBackground()
    return background
end

function backgroundModule.backgroundScrolling(dt)
    background.imgY = background.imgY + background.scrollingSpeed * dt
    background.img2Y = background.img2Y + background.scrollingSpeed * dt
end

function backgroundModule.resetBackground()
    if background.imgY >= screenHeight then
        background.imgY = 0 + screenVsBackgroundHeight
    end
    if background.img2Y >= screenHeight then
        background.img2Y = 0 + screenVsBackgroundHeight
    end

end

function backgroundModule.load()

    screenVsBackgroundHeight = screenHeight - backgroundImg:getHeight()

    
    background.scrollingSpeed = 480

    background.height = background.img:getHeight()
end

function backgroundModule.draw()
    love.graphics.draw(background.img, background.imgX, background.imgY, 0, 1, 1, 1, 1)
    love.graphics.draw(background.img2, background.img2X, background.img2Y - background.height, 0, 1, 1, 1, 1)
end

return backgroundModule