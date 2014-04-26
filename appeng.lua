--Script to display nifty information about your Applied Energistics system
--Requirements: Advanced Computer, Advanced Monitors

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
    drawProgress(0, 0, 10, 0, usedPercent)
end

function drawProgress(fromX, fromY, toX, toY, progress, color1, color2)
    color1 = color1 or colors.white
    color2 = color2 or colors.gray
    local lenX = toX - fromX
    local lenY = toY - fromY
    local midX = fromX + lenX * progress
    local midY = fromY + lenY * progress
    term.redirect(mon)
    paintutils.drawLine(fromX, fromY, midX, midY, color1)
    paintutils.drawLine(midX, midY, toX, toY, color2)
    term.redirect(term)
end



main()
