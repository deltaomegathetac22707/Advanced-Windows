local PrimeUI = require("PrimeUI")

local shutdownFlag = false
local rebootFlag = false

_G.homeExists = true

local win = term.current()

local windowname = "Welcome To Advanced Windows"

_G.app = {}
local appID = 0



local function shorten(text, max)
    text = tostring(text)
    if #text <= max then return text end
    return text:sub(1, max) .. "..."
end


local function clickedExit()
    shutdownFlag = true
    PrimeUI.resolve()
end

local function clickedReboot()
    rebootFlag = true
    shutdownFlag = false
    PrimeUI.resolve()
end




local function appOpen(id)
    local file = _G.app[tostring(id)]
    if not file then return end

    if file == "Shell.lua" then
        -- Open CC shell
        local pid = multishell.launch({}, "/rom/programs/shell.lua")
        multishell.setTitle(pid, "Shell")
        return
    end

    -- Launch app from /appfiles/
    local path = "/appfiles/" .. file
    if fs.exists(path) then
        local pid = multishell.launch({}, path)
        multishell.setTitle(pid, file:gsub("%.lua$", ""))
    end
end




local function placeApp(x, y, name)
    local boxSize = 11
    local cleanName = name:gsub("%.lua$", "")
    local short = shorten(cleanName, boxSize - 3)
    local prefix = cleanName:sub(1, 2)

    -- Store this app
    local thisID = appID
    _G.app[tostring(thisID)] = cleanName .. ".lua"
    appID = appID + 1

    -- Label under button
    PrimeUI.centerLabel(win, x - 3, y + 1, boxSize, short, colors.white, colors.black)

    -- App button
    PrimeUI.button(
        win, x, y, prefix,
        function() appOpen(thisID) end,
        colors.white, nil, colors.gray, nil
    )
end


local function drawAllApps()
    local Y = 5
    local X = 4
    local maxWidth = 54

    -- Add shell app
    placeApp(X, Y, "Shell.lua")

    local path = "/appfiles/"

    for _, file in ipairs(fs.list(path)) do
        X = X + 10

        if X >= maxWidth then
            X = 4
            Y = Y + 3
        end
        
        placeApp(X, Y, file)
    end
end




local function main()
    term.clear()

    -- Top bar buttons
    PrimeUI.button(win, 1, 1, "O", clickedExit, colors.white, nil, colors.gray, nil)
    PrimeUI.button(win, 5, 1, "R", clickedReboot, colors.white, nil, colors.gray, nil)

    -- Title
    PrimeUI.textBox(win, 12, 1, 40, 1, shorten(windowname, 35), colors.white, colors.black)

    -- Divider
    PrimeUI.horizontalLine(win, 1, 2, 70, colors.gray, nil)

    -- App icons
    drawAllApps()

    -- Run UI
    PrimeUI.run()
    PrimeUI.clear()

    term.clear()



    if shutdownFlag then
        for i = 1, 3 do
            term.clear()
            term.setCursorPos(1, 1)
            print("Shutting Down" .. string.rep(".", i))
            sleep(0.4)
        end
        os.shutdown()
    end

    if rebootFlag then
        for i = 1, 3 do
            term.clear()
            term.setCursorPos(1, 1)
            print("Rebooting" .. string.rep(".", i))
            sleep(0.4)
        end
        os.reboot()
    end
end


main()

