QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


QBCore.Functions.CreateUseableItem("driver_license", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        --print(item.info.firstname)
        --TriggerClientEvent("inventory:client:ShowDriverLicense", -1, source, Player.PlayerData.citizenid, item.info)
        TriggerClientEvent("vz-idcard:give",source,item.info,"driver")
    end
end)
QBCore.Functions.CreateUseableItem("id_card", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("vz-idcard:give",source,item.info,"idcard")
        --TriggerClientEvent("inventory:client:ShowId", -1, source, Player.PlayerData.citizenid, item.info)
    end
end)

RegisterServerEvent('vz-idcard:giveid')
AddEventHandler('vz-idcard:giveid', function(clostest,type,data)
    local src = source
    TriggerClientEvent("vz-idcard:open",clostest,data,type)
end)