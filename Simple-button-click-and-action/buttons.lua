local buttonsModule = {}

local buttons = {
    {
        x = 10,
        y = 20,
        width = 80,
        height = 20,
        name = "button_01",
    },
    {
        x = 10,
        y = 90,
        width = 80,
        height = 20,
        name = "button_02",
    }
}

function buttonsModule.mousepressed(x, y, button, istouch)

    --[[ if button == 1 and buttonsModule.isInsideButtonRectangle(x, y, button) then
      print("touched button: " .. button.name)
    end ]]

    if button == 1 then
        for i, buttonRect in ipairs(buttons) do
            if isInsideButtonRectangle(x, y, buttonRect) then
                leftMouseButtonActions(x, y, buttonRect)
            end
        end 
    end
end

function leftMouseButtonActions(x, y, buttonRect)
    if buttonRect.name == "button_01" then
        print("touched button: " .. buttonRect.name)
    elseif buttonRect.name == "button_02" then
        print("touched button: " .. buttonRect.name)
    end
end

function isInsideButtonRectangle(x, y, rect)
    return x > rect.x and x < rect.x + rect.width and
           y > rect.y and y < rect.y + rect.height
end

function buttonsModule.drawButtons()
    for i, button in ipairs(buttons) do
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
        love.graphics.setColor(0,0,0)
        love.graphics.print(button.name, button.x + 10, button.y + 3.)
    end
end

return buttonsModule
