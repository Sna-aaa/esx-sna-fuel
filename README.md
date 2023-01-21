# esx-sna-fuel
Fuel script that cover all vehicles, fuel, electric, air, sea

## Features
- Pumps with nozzle for electric or fuel
- Gaz pump for fuel vehicles
- Electric chargers for electric vehicles
- Out of energies are handled by the script, the vehicle just stop his motor, no more sparks and backwards
- Every vehicles excepted blacklisted ones will stop when out of energy
- Electric cars have a specific consumption model (with nothing at idle)
- Electric cars have a charge curve (quickly until 80% then more and more slowly)
- Electric cars have a discharge curve (slowly until 40% then more and more quickly)
- Consumption can be specified for each vehicle separately
- Tank sizes can be specified for each vehicle separately
- Energy is specified in L or Kw, and price can be configured
- Automatic charging of electric vehicles in garages
- Admin command /fuel to refuel/charge vehicles
- Working jerrican for fuel vehicles
- Jerrican capacity is configurable
- A new export "ApplyFuel" to apply fuel without electric charge for persistence scripts

## Requirements
- [esx_extended]()
- [ox_target](https://github.com/overextended/ox_target)
- [wtf_tesla_supercharger](https://github.com/wtf-fivem-mods/wtf_tesla_supercharger)

## Installation

1) Remove any fuel or electricity script that you may have including LegacyFuel, ps-fuel etc

2) Replace all occurences of "LegacyFuel" by "esx-sna-fuel" (or wathever your directory name is) in all your server resources exports

3) If you want to use the auto charging function for electric vehicles in garage:
- Import the database.sql in your database
- In your garage script a line with UpdateVehicleDateTimeIn must be added when you park the car, here in qb-garage
```lua
local function enterVehicle(veh, indexgarage, type, garage)
    local plate = QBCore.Functions.GetPlate(veh)
    if GetVehicleNumberOfPassengers(veh) == 0 then
        QBCore.Functions.TriggerCallback('qb-garage:server:checkOwnership', function(owned)
            if owned then
                local bodyDamage = math.ceil(GetVehicleBodyHealth(veh))
                local engineDamage = math.ceil(GetVehicleEngineHealth(veh))
                local totalFuel = GetFuel(veh)
                local props = QBCore.Functions.GetVehicleProperties(veh)
                TriggerServerEvent('qb-garage:server:updateVehicle', 1, totalFuel, engineDamage, bodyDamage, plate, indexgarage, type, PlayerGang.name, Damages)
                TriggerServerEvent('qb-fuel:server:UpdateVehicleDateTimeIn', plate)     --Change
                DeleteVehicle(veh, garage)
                if type == "house" then
                    exports['qb-core']:DrawText(Lang:t("info.car_e"), 'left')
                    InputOut = true
                    InputIn = false
                end
    
                if plate then
                    TriggerServerEvent('qb-garage:server:UpdateOutsideVehicle', plate, nil)
                end
                QBCore.Functions.Notify(Lang:t("success.vehicle_parked"), "primary", 4500)
            else
                QBCore.Functions.Notify(Lang:t("error.not_owned"), "error", 3500)
            end
        end, plate, type, indexgarage, PlayerGang.name)
    else
        QBCore.Functions.Notify(Lang:t("error.vehicle_occupied"), "error", 5000)
    end
end
```

## ToDo
