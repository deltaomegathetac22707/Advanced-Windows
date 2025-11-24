local PrimeUI = require "PrimeUI"
local winui = {}
local win = term.current()

function winui.shorten(text, max)
    text = tostring(text)
    if #text <= max then 
        return text 
    else
        return text:sub(1, max) .. "..."
    end
end


---------------------- event for X button
function clickedExit()
    PrimeUI.resolve()
end


function winui.run()

    PrimeUI.button(win, 1, 1, "X", clickedExit, colors.white, nil, colors.gray, nil)
    PrimeUI.horizontalLine(win, 1, 2, 70, colors.gray, nil)

    PrimeUI.run()
    PrimeUI.clear()

    shell.run("exit")
end
------------------------------------------

return winui
