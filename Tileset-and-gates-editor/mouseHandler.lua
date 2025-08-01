local mouseHandlerModule = {}

local buttonsModule = require("buttons")

function mouseHandlerModule.loveMousePressed(x, y, mouseButton)
    if mouseButton == 1 then
        buttonsModule.checkIfClickedInButtonRectangle(x, y)    
    end
end

return mouseHandlerModule