--Pulse jet crafting

local furnaceSide = "back"
local redstoneOutputSide = "bottom"
local redstoneInputSide = "right"

local furnace = peripheral.wrap(furnaceSide)

local maxHeat = 950;
local minHeat = 910;


redstone.setOutput(redstoneOutputSide, false)


function isRunning()
    return redstone.getInput(redstoneInputSide)
end

function heatManage()
    if (furnace.getTemperature() > maxHeat and redstone.getOutput(redstoneOutputSide)) then
        print("Temperature "..furnace.getTemperature()..">"..maxHeat..", shutting off power")
        redstone.setOuput(redstoneOutputSide, false)
    elseif (furnace.getTemperature < minHeat and not redstone.getOutput(redstoneOutputSide)) then
        print("Temperature "..furnace.getTemperature().."<"..minHeat..", turning on power")
        redstone.setOuput(redstoneOutputSide, true)
    end
end

while (true) do
    if (isRunning()) then
        heatManage()
        os.sleep(0.5)
    else
        os.sleep(1)
    end
end

