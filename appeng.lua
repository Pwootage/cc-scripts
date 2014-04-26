--Script to display nifty information about your Applied Energistics system
--Requirements: Advanced Computer, Advanced Monitors (3 wide, 2 tall)

local monitorSide = "back"
local aeSide = "appeng_me_tilecontroller_0"

local updateRate = 1

local appEng = peripheral.wrap(aeSide)
local mon = peripheral.wrap(monitorSide)
mon.setTextScale(0.5)
local monW = 57
local monH = 24

local storageSuffixes = {"b", "kb", "mb", "gb"}


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
    local msg1 = "Disk Space Usage:";
    local msg2 = "Used "..prettyNumber(used,storageSuffixes)..", Free "..prettyNumber(free,storageSuffixes)..", Total "..prettyNumber(total,storageSuffixes)
    local progX1 = string.len(msg1) + 1
    local progX2 = monW - string.len(msg2) + 1
    drawText(0, monH, msg1)1
    drawProgress(progX1, monH, progX2, monH, usedPercent)

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

function drawText(posX, posY, text)
    mon.setCursorPos(posX, posY)
    mon.write(text)
end

function prettyNumber(num, suffixes)
    suffixes = suffixes or {"", "k", "m", "b"}
    if (num > 10000000000) then --ten billion
        return round(num/1000000000, 0)..suffixes[4]
    end
    if (num > 10000000) then --ten million
        return round(num/1000000, 0)..suffixes[3]
    end
    if (num > 10000) then --ten thousand
        return round(num/1000, 0)..suffixes[2]
    end
    return round(num, 0)..suffixes[1]
end


main()
