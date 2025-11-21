local PrimeUI = require("PrimeUI")
local shutdown = 0
local reboot = false

-- to avoid extra instances named Home
_G.homeExists = true

function shorten(text, max)
    if #text <= max then
        return text
    end
    return text:sub(1, max) .. "..."
end

function clickedexit()
    shutdown = 1
    PrimeUI.resolve()
end

function reboot()
    rebooting = 1
    shutdown = 0
    PrimeUI.resolve()
end

local currentWin = term.current()

local windowname = "Welcome To Advanced Windows"

function shorten(text, max)
    text = tostring(text)
    if #text <= max then
        return text
    end
    return text:sub(1, max) .. "..."
end


function clickopenshell()
    _G.openingApp = "shell"
    local ids = multishell.launch({}, "/rom/programs/shell.lua")
    multishell.setTitle(ids, "Shell")
end


function clickplaceholder()
    sleep(0.2)
end


local function appOpen(name)

    if name == "Shell" then
        clickopenshell()
    
    else
        app = _G.app[tostring(name)]
        local idV = multishell.launch({}, app)
    end

end

--PrimeUI.centerLabel(win, x, y, width, text, fgColor, bgColor)

appID = 0
_G.app = {}

function placeApp(x,y,name)
    boxSize = 11
    nameWithoutlua = name:gsub("%.lua$", "")
    namePreChange = nameWithoutlua
    name = shorten(nameWithoutlua, boxSize - 3)
    prefix = string.sub(nameWithoutlua, 1, 2)
    openappfunction = (
                        function()
                            appOpen(appID)
                        end
                    )
    local labelx = x - 3

    PrimeUI.centerLabel(currentWin, labelx, y+1, boxSize, name, colors.white, colors.black)
    PrimeUI.button(currentWin, x, y, prefix, openappfunction, colors.white, nil, colors.gray, nil)

    _G.app[tostring(appID)] = nameWithoutlua .. ".lua"

    appID = appID + 1
end


function drawAllApps()
    Yplace = 5
    placeApp(4, Yplace, "Shell")

    local path = "/appfiles/"

    max = 5
    local Xplace = 4

    for _, item in ipairs(fs.list(path)) do
        Xplace = Xplace + 10

        if Xplace == 54 then
            Xplace = 4
            Yplace = Yplace + 3
        end
        
        placeApp(Xplace, Yplace, item1)
        
    end

    _G.appcount = Xplace
end


function main()
    -- PrimeUI.button(win, x, y, text, action, fgColor, bgColor, clickedColor, periphName)
    term.clear()
    PrimeUI.button(currentWin, 1, 1, "O", clickedexit, colors.white, nil, colors.gray, nil)

    PrimeUI.button(currentWin, 5, 1, "R", reboot, colors.white, nil, colors.gray, nil)


    -- PrimeUI.textBox(win, x, y, width, height, text, fgColor, bgColor)
    PrimeUI.textBox(currentWin, 12, 1, 40, 1, shorten(windowname, 35), colors.white, colors.black)

    -- PrimeUI.horizontalLine(win, x, y, width, fgColor, bgColor)
    PrimeUI.horizontalLine(currentWin, 0, 2, 70, colors.gray, nil)

    -- draws each app

    drawAllApps()

    sleep(4)

    -- Start GUI
    PrimeUI.run()
    PrimeUI.clear()

    term.setCursorPos(1, 1)
    term.clear()

    if shutdown == 1 then
        print("Shutting Down. . . ")

        sleep(0.4)

        term.setCursorPos(1, 1)
        term.clear()
        print("Shutting Down. . ")


        sleep(0.4)
        term.setCursorPos(1, 1)
        term.clear()
        print("Shutting Down.")
        sleep(0.7)
        os.shutdown()
    end

    if rebooting == 1 then
        print("Rebooting. . .")

        sleep(0.4)

        term.setCursorPos(1, 1)
        term.clear()
        print("Rebooting. .")

        sleep(0.4)

        term.setCursorPos(1, 1)
        term.clear()
        print("Rebooting.")
        sleep(0.7)

        os.reboot()
    end
end


main()
