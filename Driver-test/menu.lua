local menu = {}


local imageWidth = 0
local imageHeight = 0

local menuOn = true

function menu.setMenuState(state)
    menuOn = state
end

function menu.getMenuState()
    return menuOn
end

function menu.draw()
    if(menuOn) then
        love.graphics.print("Press Enter to start", 100, 100)
        love.graphics.print("Press Escape to open menu", 100, 130)

        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill", 100, 100, 200, 50)

        love.graphics.print("Press spacebar to choose your car while ingame", 100, 200)
       
    end
end



return menu
