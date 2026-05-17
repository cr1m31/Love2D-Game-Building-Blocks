local editorMenuModule = {}

local state = {
    menuVisible = true,
    menuPanel = { x = 10, y = 10, width = 120, height = 180 },
    toggleButtons = {
        hide = { x = 0, y = 0, width = 60, height = 25 },
        show = { x = 0, y = 0, width = 60, height = 25 }
    },
    menuButtons = {
        tilesetEditor = { x = 0, y = 0, width = 100, height = 25 },
        gateEditor = { x = 0, y = 0, width = 100, height = 25 },
        saveButton = { x = 0, y = 0, width = 100, height = 25 },
        loadButton = { x = 0, y = 0, width = 100, height = 25 }
    },
    buttonOrder = {"tilesetEditor", "gateEditor", "saveButton", "loadButton"}
}

local function positionButtons()
    -- Position toggle buttons (to the right of menu)
    state.toggleButtons.hide.x = state.menuPanel.x + state.menuPanel.width + 10
    state.toggleButtons.hide.y = state.menuPanel.y

    state.toggleButtons.show.x = state.menuPanel.x + state.menuPanel.width + 10
    state.toggleButtons.show.y = state.menuPanel.y

    -- Position menu buttons vertically inside the menu panel
    if state.menuVisible then
        local yOffset = state.menuPanel.y + 10
        for i, name in ipairs(state.buttonOrder) do
            local button = state.menuButtons[name]
            button.x = state.menuPanel.x + state.menuPanel.width / 2 - button.width / 2
            button.y = yOffset + (button.height + 5) * (i - 1)
        end
    end
end

local function drawButton(button, label)
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(label, button.x + 5, button.y + 5)
end

function editorMenuModule.update(dt)
    positionButtons()
end

function editorMenuModule.drawMenu()
    if state.menuVisible then
        love.graphics.setColor(0.5, 0.5, 0.8)
        love.graphics.rectangle("fill", state.menuPanel.x, state.menuPanel.y, state.menuPanel.width, state.menuPanel.height)

        for _, name in ipairs(state.buttonOrder) do
            drawButton(state.menuButtons[name], name)
        end
    end

    if state.menuVisible then
        drawButton(state.toggleButtons.hide, "Hide")
    else
        drawButton(state.toggleButtons.show, "Show")
    end
end

-- Single interface function that returns all needed data
function editorMenuModule.getClickableElements()
    return {
        menuVisible = state.menuVisible,
        toggleButtons = state.toggleButtons,
        menuButtons = state.menuButtons,
        buttonOrder = state.buttonOrder
    }
end

function editorMenuModule.toggleMenu()
    state.menuVisible = not state.menuVisible
end

function editorMenuModule.handleMenuButtonClick(buttonName)
    print("Menu button clicked: " .. buttonName)
    -- Add button-specific logic here based on buttonName
    if buttonName == "tilesetEditor" then
        -- Handle tileset editor logic
        print("Opening tileset editor...")
    elseif buttonName == "gateEditor" then
        -- Handle gate editor logic
        print("Opening gate editor...")
    elseif buttonName == "saveButton" then
        -- Handle save logic
        print("Saving...")
    elseif buttonName == "loadButton" then
        -- Handle load logic
        print("Loading...")
    end
end

return editorMenuModule