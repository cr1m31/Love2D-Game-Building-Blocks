local menuTestModule = {}

local menuPanel = {
  x = 0,
  y = 0,
  width = 100,
  height = 200,
  color = {0,1,0.5}
}

local buttons = {
  color = {1,0,0},
  {
      x = 10,
      y = 10, 
      width = 60,
      height = 30,
      name = "button_01",
      text = "Open",
  },
  {
    x = 10,
    y = 60, 
    width = 60,
    height = 30,
    name = "button_02",
    text = "Close",
  }
}

function ifPointInRectangle(x, y, rect)
  return x > rect.x and
    x < rect.x + rect.width and
    y > rect.y and
    y < rect.y + rect.height
end

function menuTestModule.mousepressed(x, y, button)
  if button == 1 then
    for i, myButton in ipairs(buttons) do
      if ifPointInRectangle(x, y, myButton) then
        chooseButtonActions(myButton)
      end
    end
  end
end

function chooseButtonActions(myButton)
  if myButton.name == "button_01" then
    print("action du bouton: " .. myButton.text .. " : " .. myButton.name)
  elseif myButton.name == "button_02" then
    print("action du bouton: " .. myButton.text .. " : " .. myButton.name)
  end
end

function menuTestModule.draw()
  love.graphics.setColor(menuPanel.color)
  love.graphics.rectangle("fill", menuPanel.x, menuPanel.y, menuPanel.width, menuPanel.height)
  
  for i, myButton in ipairs(buttons) do
    love.graphics.setColor(buttons.color)
    love.graphics.rectangle("fill", myButton.x, myButton.y, myButton.width, myButton.height)
    love.graphics.setColor(0,0,0)
    love.graphics.print(myButton.text, myButton.x + 5, myButton.y + 5)
  end
end

return menuTestModule