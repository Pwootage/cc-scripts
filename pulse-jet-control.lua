--Pulse jet crafting

local furnaceSide = "back"
local redstoneOutputSide = "bottom"
local redstoneInputSide = "right"

local furnace = peripheral.wrap(furnaceSide)

local maxHeat = 950
local minHeat = 910


redstone.setOutput(redstoneOutputSide, false)


function isRunning()
    return redstone.getInput(redstoneInputSide)
end

function heatManage()
    local temp = furnace.getTemperature()
    local redstoneOn = redstone.getOutput(redstoneOutputSide)
    if ((temp > maxHeat) and redstoneOn) then
        print("Temperature "..temp..">"..maxHeat..", shutting off power")
        redstone.setOutput(redstoneOutputSide, false)
    elseif ((temp < minHeat) and not redstoneOn) then
        print("Temperature "..furnace.getTemperature().."<"..minHeat..", turning on power")
        redstone.setOutput(redstoneOutputSide, true)
    end
end

while (true) do
    if (isRunning()) then
        heatManage()
        os.sleep(0.5)
    else
        redstone.setOutput(redstoneOutputSide, false)
        os.sleep(1)
    end
end

