package.path = package.path .. ";/libs/?.lua"
-- Tbh i dont even know what im doing
-- this is driving me insane and I dont even know why the buttons arent giving the right thing



function strToBool(inputStr)
    if inputStr == "true" then
        return true
    elseif inputStr == "false" then
        return true
    end
end

--------------------------- Settings
_G.currentSettings = {}

local file = io.open("/sysfiles/system.conf", "r")

for line in file:lines() do
    if line:find("^gps:") then
        _G.currentSettings.gps = strToBool(line:gsub("^gps: ", ""))
    end
    if line:find("^showID:") then
        _G.currentSettings.showID = strToBool(line:gsub("^showID: ", ""))
    end
end

file:close()


_G.MAC = {}
_G.MAC.wired = {}

local file = io.open("/sysfiles/.mac", r)
local hextet = 1

for line in file:lines() do
    _G.MAC.wired[hextet] = tonumber(line, 16)
    hextet = hextet + 1
end

------------------------------

local id -- declare outside
local PrimeUI = require "PrimeUI"

if _G.homeExists ~= true then
    _G.mistake = pcall(function()
        term.clear()

        local currentWin = term.current()
        local screenW, screenH = term.getSize()

        line1 = "Advanced"
        line2 = "Windows"
        line3 = "1.0"

        --PrimeUI.centerLabel(win, x, y, width, text, fgColor, bgColor)
        PrimeUI.centerLabel(currentWin, 1, 1, screenW, line1, colors.white, colors.black)
        PrimeUI.centerLabel(currentWin, 1, 2, screenW, line2, colors.white, colors.black)
        PrimeUI.centerLabel(currentWin, 1, 3, screenW, line3, colors.white, colors.black)


        --- startup for the startpage
        PrimeUI.timeout(2, "done")
        PrimeUI.run()
        PrimeUI.clear()


        ------------------ Opening the HomePage
        pcall(function()
            id = multishell.getCurrent()
        end)

        if id == 1 and _G.homeExists ~= true then
            print("Opening GUI")
            shell.run("homepage.lua")
        end
        -----------------------------------------

    end)
end

