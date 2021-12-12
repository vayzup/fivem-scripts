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

mining = {
    vector3(2986.37,2751.71,43.22),
    vector3(2977.45,2741.7,44.6),
    vector3(2946.7,2725.36,47.93)
}
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
        for k,v in pairs(mining) do
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 5)  then
            DrawMarker(2, v.x, v.y, v.z+0.15, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.3)  then
            if not inMission then
               DrawText3D(v.x, v.y, v.z+0.15, '~g~E~w~ - Mine')
               if IsControlJustReleased(0, 38) then
                ----
                local model = loadModel(GetHashKey('prop_tool_pickaxe'))
                local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
                SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'))
                local dict = loadDict('melee@hatchet@streamed_core')
                TaskPlayAnim(PlayerPedId(), dict, 'plyr_rear_takedown_b', 8.0, -8.0, 5000, 2, 5, false, false, false)
                Citizen.Wait(5000)
                TaskPlayAnim(PlayerPedId(), dict, 'plyr_rear_takedown_b', 8.0, -8.0, 5000, 2, 5, false, false, false)
                Citizen.Wait(5000)
                ClearPedTasks(PlayerPedId())
                DeleteObject(axe)
                TriggerServerEvent('vz-mining:reward')
                FreezeEntityPosition(PlayerPedId(), false)
                ---
                        end
                    end
                end
            end
        end
    end
end)


loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(2986.37,2751.71,43.22)

	SetBlipSprite (blip, 85)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Mining')
	EndTextCommandSetBlipName(blip)
end)


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
end