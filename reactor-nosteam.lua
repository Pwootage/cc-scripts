--Reactor script for non-turbine reactors to turn off when >90% full and turn on when <40$ full
total = 10000000
r = peripheral.wrap("back")


function reactorUpdate()
    local energy = r.getEnergyStored()
    local percent = energy/total
    if (percent > 0.9) then
        if (r.getActive()) then
            print("Reactor at "..energy.."rf, shutting down.")
            r.setActive(false)
        end
    end
    if (r.getEnergyStored() < total * 0.4) then
        if (not r.getActive()) then
            print("Reactor at "..energy.."rf, starting up")
            r.setActive(true)
        end
    end
end

while (true) do
    local status, err = pcall(reactorUpdate)
    if (status) then
        --all is well
    else
        print("Error. Waiting and trying again:"..err)
        os.sleep(5)
    end
    --reactorUpdate()
    os.sleep(1)
end