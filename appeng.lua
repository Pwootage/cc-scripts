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
    local items = appEng.getStoredItemCount()
    local types = appEng.getStoredItemTypes()
    local remItems = appEng.getRemainingItemCount()
    local remTypes = appEng.getRemainingItemTypes()
    local msg1 = "Disk Space Usage:";
    local progX1 = string.len(msg1) + 1
    local progColor = colors.green
    if (usedPercent > 0.5) then progColor = colors.yellow end
    if (usedPercent > 0.80) then progColor = colors.red end
    term.clear()
    drawText(1, 1, "Used disk space: "..padLeft(prettyNumber(used,storageSuffixes), 8))
    drawText(1, 2, "Free disk space: "..padLeft(prettyNumber(free,storageSuffixes), 8))
    drawText(1, 3, "Total disk space:"..padLeft(prettyNumber(total,storageSuffixes), 8))
    drawText(1, 4, "Stored items:    "..padLeft(prettyNumber(items,storageSuffixes), 8))
    drawText(1, 5, "Item types:      "..padLeft(prettyNumber(types,storageSuffixes), 8))
    drawText(1, 6, "Remaining items: "..padLeft(prettyNumber(remItems,storageSuffixes), 8))
    drawText(1, 6, "Remaining types: "..padLeft(prettyNumber(remTypes,storageSuffixes), 8))
    drawText(1, monH - 0, msg1)
    drawProgress(progX1, monH - 0, monW, monH - 0, usedPercent, progColor)
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
       res = " "..res
    end
    return res
end


main()
