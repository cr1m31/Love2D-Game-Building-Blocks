local dragBoxTestModule = {}

local box = {
    x = 180,
    y = 200,
    width = 50,
    height = 50,
}

function dragBoxTestModule.checkIfClickedInBoxTest(mousex, mousey)
     if mousex > box.x and 
        mousex < box.x + box.width and 
        mousey > box.y and
        mousey < box.y + box.height then
        return true
    end
end

function dragBoxTestModule.dragTest(x,y,dx,dy)
    if dragBoxTestModule.checkIfClickedInBoxTest(x, y) then
        box.x = box.x + dx
        box.y = box.y + dy
    end
end




function dragBoxTestModule.drawBox()
    love.graphics.rectangle("fill", box.x, box.y, box.width, box.height)
end

return dragBoxTestModule