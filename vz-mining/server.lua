QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('vz-mining:reward')
AddEventHandler('vz-mining:reward', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local r = math.random(1,100)
    local luck = math.random(1, 100)
    if r < 40 then
        if luck > 50 then 
            local item = "sulfur"
            Player.Functions.AddItem(item, math.random(1,3))
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
        elseif luck > 40 then
            local item = "coal"
        Player.Functions.AddItem(item, math.random(1,3))
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
        else

        local item = "steel"
        Player.Functions.AddItem(item, math.random(1,3))
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
        end

    else 

        TriggerClientEvent('QBCore:Notify', src, 'You got nothing', 'error', 3500)
    end
end)
