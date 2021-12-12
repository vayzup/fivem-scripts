QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local open = false
 
-- Open ID card
RegisterNetEvent('vz-frame:open')
AddEventHandler('vz-frame:open', function(url,width,height)
    print('Hello')
	open = true
	SendNUIMessage({
		action = "open",
        url = url,
		width = width,
		height = height
	})
end)
--[[
Citizen.CreateThread(function()
    Wait(2000)
    TriggerEvent('vz-frame:open',"https://cdn.discordapp.com/attachments/167337108984430592/870032329811296276/Vanilla-unicorn-oppskrifter.png")

end)]]
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