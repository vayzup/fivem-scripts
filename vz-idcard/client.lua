QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local open = false

-- Open ID card
RegisterNetEvent('vz-idcard:open')
AddEventHandler('vz-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
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
  RegisterNetEvent('vz-idcard:give')
AddEventHandler('vz-idcard:give', function(data,type)
	local player, distance = GetClosestPlayer()
	if player ~= -1 and distance < 1.5 then
		local playerID = GetPlayerServerId(player)
		TriggerServerEvent("vz-idcard:giveid",playerID,type,data)
	else
		TriggerEvent('vz-idcard:open',data,type)
	end
end)
-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

