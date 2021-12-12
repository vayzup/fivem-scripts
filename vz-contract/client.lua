QBCore = nil

Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(0)
	end
end)
function GetClosestPlayer()
	local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
	local closestDistance = -1
	local closestPlayer = -1
	local coords = GetEntityCoords(GetPlayerPed(-1))
  
	for i=1, #closestPlayers, 1 do
		if closestPlayers[i] ~= PlayerId() then
			local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)
  
			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = closestPlayers[i]
				closestDistance = distance
			end
		end
  end
  
  return closestPlayer, closestDistance
  end 

RegisterNetEvent('vz-contract:getVehicle')
AddEventHandler('vz-contract:getVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(GetPlayerPed(-1))
	local player, distance = GetClosestPlayer()
	if player ~= -1 and distance < 1.5 then
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
		if IsPedInAnyVehicle(GetPlayerPed(-1))  ~= false then
			local vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
			TriggerServerEvent('vz-contract:sellVehicle', GetPlayerServerId(player), vehProps.plate)
		else
			QBCore.Functions.Notify("You are not in a vehicle", "primary")
		end
	else
		QBCore.Functions.Notify("No one nearby", "primary")
	end
	
end)

RegisterNetEvent('vz-contract:showAnim')
AddEventHandler('vz-contract:showAnim', function(player)
	loadAnimDict('anim@amb@nightclub@peds@')
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, false)
	Citizen.Wait(20000)
	ClearPedTasks(PlayerPedId())
end)


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end