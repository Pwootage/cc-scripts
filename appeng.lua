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
    local msg2 = "    Used    Free   Total"
    local msg3 = padLeft(prettyNumber(used,storageSuffixes), 8)..padLeft(prettyNumber(free,storageSuffixes), 8)..padLeft(prettyNumber(total,storageSuffixes), 8)
    local progX1 = string.len(msg1) + 1
    drawText(1, monH - 2, msg1)
    drawProgress(progX1, monH - 2, monW, monH - 2, usedPercent)
    drawText(1, monH - 1, msg2)
    drawText(1, monH - 0, msg3)
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

function drawText(posX, posY, text, color, bg)
    color = color or colors.white
    bg = bg or colors.black
    mon.setTextColor(color)
    mon.setBackgroundColor(bg)
    mon.setCursorPos(posX, posY)
    mon.write(text)
end

function prettyNumber(num, suffixes)
    suffixes = suffixes or {"", "k", "m", "b"}
    if (num > 10000000000) then --ten billion
        return math.floor(num/1000000000)..suffixes[4]
    end
    if (num > 10000000) then --ten million
        return math.floor(num/1000000)..suffixes[3]
    end
    if (num > 10000) then --ten thousand
        return math.floor(num/1000)..suffixes[2]
    end
    return math.floor(num)..suffixes[1]
end

function padLeft(string, chars)
    local res = string;
    while (string.len(res) < chars) do
       res = " " + res
    end
    return res
end


main()
