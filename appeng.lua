--Script to display nifty information about your Applied Energistics system
--Requirements: Advanced Computer, Advanced Monitors

if not guiutils then os.loadAPI("guiutils.lua") end

local monitorSide = "back"
local aeSide = "appeng_me_tilecontroller_0"

local updateRate = 1

local appEng = peripheral.wrap(aeSide)
local mon = peripheral.wrap(monitorSide)

function main()
    while (true) do
        update()
        os.sleep(updateRate)
    end
end

function update()
    local total = appEng.getTotalBytes()
    local free = appEng.getFreeBytes()
    local used = total - free;
    local usedPercent = used/total;
    guiutils.drawProgress(0, 0, 10, 0, usedPercent)
end


main()
