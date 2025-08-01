local mouseHandlerModule = {}

local editorMenuModule = require("editorMenu")


local dragBoxTestModule = require("dragBoxTest") 

function mouseHandlerModule.loveMousePressed(x, y, mouseButton)
    if mouseButton == 1 then
        editorMenuModule.checkIfClickedInButtonRectangle(x, y) 
        editorMenuModule.checkIfClickedInMenuPanel(x, y)
        
        dragBoxTestModule.checkIfClickedInBoxTest(x, y)
    end
end

function mouseHandlerModule.loveMouseMoved(x,y,dx,dy)
    dragBoxTestModule.dragTest(x,y,dx,dy)
end

return mouseHandlerModule