local charge = 0

local display = false
PlayerJob = {}
QBCore = nil
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerJob = PlayerData.job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)
 
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(131.8,-1285.14,29.27)

    SetBlipSprite (blip, 93)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.0)
    SetBlipColour (blip, 27)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Vanilla unicorn')
    EndTextCommandSetBlipName(blip)

    -- 
    exports['bt-target']:AddBoxZone("vulist", vector3(128.4,-1283.64,29.27), 1.0, 1.0, {
        name="vulist",
        heading=118.66,
        debugPoly=false,
        maxZ=29.60,
        }, {
            options = {
                {
                    event = "vanillaunicorn:vulist",
                    icon = "fas fa-copy",
                    label = "List",
                }
            },
            job = {"vu"},
            distance = 1.5
        })
    exports['bt-target']:AddBoxZone("vuStock", vector3(132.83,-1285.59,30.27), 1.0, 1.0, {
        name="vuStock",
        heading=298.36,
        debugPoly=false,
        maxZ=30.27,
        }, {
            options = {
                {
                    event = "vanillaunicorn:stock",
                    icon = "fas fa-box",
                    label = "Storage",
                }
            },
            job = {"vu"},
            distance = 1.5
        })
    exports['bt-target']:AddBoxZone("drinks", vector3(131.05,-1282.16,30.27), 1.2, 1.7, {
        name="vuCraft",
        heading=298.36,
        debugPoly=false,
        maxZ=30.27,
    }, {
        options = {
        {
        event = "vz-vu:Vodkabattery",
        icon = "fab fa-gulp",
        label = "Vodka battery",
        }, 
        {
            event = "vz-vu:mojito",
            icon = "fab fa-gulp",
            label = "Mojito",
            },
            {
                event = "vz-vu:romcola",
                icon = "fab fa-gulp",
                label = "Rom and coke",
                },
    },
        job = {"all"},
        distance = 1.5
    })

    exports['bt-target']:AddBoxZone("vuDelivery", vector3(129.12,-1285.03,30.27), 1.0, 1.0, {
        name="vuDelivery",
        heading=110.3,
        debugPoly=false,
        maxZ=30.27,
        }, {
            options = {
                {
                    event = "vz-vu:payorder",
                    icon = "fas fa-cash-register",
                    label = "Payment",
                    },
                {
                    event = "vz-vu:Delivery",
                    icon = "fas fa-cash-register",
                    label = "Delivery",
                    },
                }
            },
            job = {"all"},
            distance = 1.5
        })
end)

RegisterNetEvent('vz-vu:payorder')
AddEventHandler('vz-vu:payorder', function()
    if PlayerJob.name == "vu" then
        TriggerEvent('vz-vu:drawNui')
    else
    TriggerServerEvent('vz-vu:chargeMe')
    end
end)
RegisterNetEvent('vz-vu:getcharged')
AddEventHandler('vz-vu:getcharged', function(OrderTotal)
	if OrderTotal ~=0  then
TriggerServerEvent('vz-vu:sendpayamount', OrderTotal)
--exports['mythic_notify']:SendAlert('success', "You paid " .. OrderTotal, 8500)
TriggerServerEvent('vz-vu:createCharge',0)
	else
--		exports['mythic_notify']:SendAlert('error', "No Pending Charges ", 8500)
	end
end)
-- // Delivery
RegisterNetEvent('vz-vu:Delivery')
AddEventHandler('vz-vu:Delivery',function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vanillaunicorn2", {
        maxweight = 4000000,
        slots = 500,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "vanillaunicorn2")

end)
-- STOCK 

RegisterNetEvent('vanillaunicorn:stock')
AddEventHandler('vanillaunicorn:stock', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "vanillaunicorn", {
        maxweight = 4000000,
        slots = 500,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "vanillaunicorn")
end)
-- Cook Meat --
RegisterNetEvent('vz-vu:Vodkabattery')
AddEventHandler('vz-vu:Vodkabattery',function()
TriggerServerEvent('vz-vu:checkCanCraft','vodka_battery')
end)

RegisterNetEvent('vz-vu:mojito')
AddEventHandler('vz-vu:mojito',function()
TriggerServerEvent('vz-vu:checkCanCraft','mojito')
end)

RegisterNetEvent('vz-vu:romcola')
AddEventHandler('vz-vu:romcola',function()
TriggerServerEvent('vz-vu:checkCanCraft','romcola')
end)

                
-- Burger prepare animation
RegisterNetEvent('vz-vu:cookAnimation')
AddEventHandler('vz-vu:cookAnimation',function(Animation)
    local ped = GetPlayerPed(-1)
    TaskStartScenarioInPlace(ped,Animation, 0, false)
    QBCore.Functions.Progressbar("scrap_vehicle", "Working..", 8000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
    ClearPedTasks(ped)
    end)
end)
-- NUI 

RegisterNetEvent('vz-vu:drawNui')
AddEventHandler('vz-vu:drawNui',function()
    SetDisplay(not display)
end)

--very important cb 
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("main", function(data)
	amount = tonumber(data.text)
    TriggerServerEvent('vz-vu:SetSeller')
	TriggerServerEvent('vz-vu:createCharge', amount)
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    SetDisplay(false)
end)


function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

--- Shop 
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
    if PlayerJob.name == "vu"  then
        for k,v in pairs(Config.shop) do
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 5)  then
            DrawMarker(2, v.x, v.y, v.z+0.15, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.3)  then
            if not Config.IsMelting then
               DrawText3D(v.x, v.y, v.z+0.15, '~g~E~w~ - Shop')
               if IsControlJustReleased(0, 38) then
                TriggerServerEvent("inventory:server:OpenInventory", "shop", "shop", Config.Items)
                        end
                    end
                end
            end
        end
    end
    end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end