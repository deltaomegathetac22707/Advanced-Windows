package.path = package.path .. ";/libs/?.lua"
local WinUI = require "WinUI"
local PrimeUI = require "PrimeUI"
local win = term.current()



local changes = {
    gps = nil,
    showID = nil
}



local function applyChanges()

    if changes.gps ~= nil then
        _G.currentSettings.gps = changes.gps
    end
    
    if changes.showCompID ~= nil then
        _G.currentSettings.showID = changes.showID
    end

end



function ScreenReload()
    PrimeUI.clear()


    PrimeUI.textBox(win, 2, 3, 40, 1, WinUI.shorten("Show Computer ID", 35), colors.white, colors.black)

    -- apply button x and y
    local x = 16
    local y = 16

    -- apply button
    PrimeUI.button(win, x, y, "Apply", clickedExit, colors.white, nil, colors.gray, nil)
    -- Cancel button
    PrimeUI.button(win, x+9, y, "Cancel", clickedExit, colors.white, nil, colors.gray, nil)
end








function main()

    -- win, x, y , width, height, text, text color, background of text color
    ScreenReload()

    WinUI.run()
    PrimeUI.clear()
end


main()
shell.run("exit")
