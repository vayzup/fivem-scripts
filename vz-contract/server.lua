mnCore = nil

TriggerEvent('mnCore:GetObject', function(obj) mnCore = obj end)

RegisterServerEvent('mn-contract:sellVehicle')
AddEventHandler('mn-contract:sellVehicle', function(target, plate)
    local src = source
    local xPlayer = mnCore.Functions.GetPlayer(src)
    local _target = target
    local tPlayer = mnCore.Functions.GetPlayer(_target)
    exports['ghmattimysql']:execute('SELECT * FROM player_vehicles WHERE citizenid = @citizenid AND plate = @plate', {
            ['@citizenid'] = xPlayer.PlayerData.citizenid,
            ['@plate'] = plate
        },function(result)
            if result[1] ~= nil then
print(tPlayer.PlayerData.citizenid)
                exports['ghmattimysql']:execute('UPDATE player_vehicles SET citizenid = @target WHERE citizenid = @citizenid AND plate = @plate', {
                    ['@citizenid'] = xPlayer.PlayerData.citizenid,
                    ['@plate'] = plate,
                    ['@target'] = tPlayer.PlayerData.citizenid
                }, function (rowsChanged)
                    if rowsChanged ~= 0 then
                        TriggerClientEvent('mnCore:Notify', src, "You sold "..plate,'success')
                        TriggerClientEvent('mnCore:Notify', _target, "You bought "..plate,'success')
                
                        xPlayer.Functions.RemoveItem('contract', 1)
                    end
                end)
            else
                TriggerClientEvent('mnCore:Notify',src, "Not your vehicle",'error')
            end    
        end)
    
end)

mnCore.Functions.CreateUseableItem('contract', function(source)
    local _source = source
    local xPlayer = mnCore.Functions.GetPlayer(_source)
    TriggerClientEvent('mn-contract:getVehicle', _source)
end)