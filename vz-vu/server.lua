  
mnCore = nil
TriggerEvent('mnCore:GetObject', function(obj) mnCore = obj end)
local OrderTotal = 0 
local SellerId = 0

-- Add items to inventory
RegisterServerEvent('mn-vu:addItem')
AddEventHandler('mn-vu:addItem',function(item)
    local src   = source
    local Player = mnCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, mnCore.Shared.Items[item], 'add')
end) 


RegisterServerEvent('mn-vu:checkCanCraft')
AddEventHandler('mn-vu:checkCanCraft',function(item)
    local src   = source
    local xPlayer = mnCore.Functions.GetPlayer(src)
    local craft = true
    local count = Config.Recipes[item].Amount
    local stack = 1

        for k, v in pairs(Config.Recipes[item].Ingredients) do
            local needitem = xPlayer.Functions.GetItemByName(k)
            if needitem ~= nil and needitem.amount > v -1 then
            	craft = true
            else
                craft = false
            end
        end
  
			if craft then
                for k, v in pairs(Config.Recipes[item].Ingredients) do
                    xPlayer.Functions.RemoveItem(k,v)
                end
	            TriggerClientEvent('mn-vu:cookAnimation',source,Config.Recipes[item].Animation)
	            Wait(10000)
                xPlayer.Functions.AddItem(item,1)
                TriggerClientEvent('inventory:client:ItemBox', src, mnCore.Shared.Items[item], 'add')
            end
end)

RegisterServerEvent('mn-vu:sendpayamount')
AddEventHandler('mn-vu:sendpayamount', function(amount)
            local src = source
            local Player = mnCore.Functions.GetPlayer(src)
            local job = "vu"

            if amount ~= nil then

exports.ghmattimysql:execute("SELECT * FROM bank_accounts WHERE job = @job ORDER BY id DESC", {['@job'] = job}, function(result2)
        if result2 ~= nil then
                Player.Functions.RemoveMoney('bank', amount)
                TriggerClientEvent('mnCore:Notify', src, 'Du betalte '..amount, 'success', 3500)
                local pay = math.ceil(amount/ 100 * 90)
                local newamount = result2[1].amount + pay
            exports.ghmattimysql:execute("UPDATE bank_accounts SET amount= @bankamount WHERE job = @job",{['@bankamount'] = newamount,['@job'] = job})
            --local aa = mnCore.Functions.GetPlayer(SellerId)
            TriggerClientEvent('mnCore:Notify',SellerId, 'Kunden betalte betalte '..amount..'kr', 'success', 3500)
            local info = {
                worth = math.ceil(amount/ 100 * 10)
            }
            local ply = mnCore.Functions.GetPlayer(SellerId)
            ply.Functions.AddItem('bill', 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', SellerId, mnCore.Shared.Items['bill'], "add")
            amount = 0
            --aa.Functions.AddItem("sprite",1)
            SellerId = nil
        end
    end) 
            else
                TriggerClientEvent('mnCore:Notify', src, 'ugyldig beløp', 'error', 3500)
            end
end)
RegisterServerEvent('mn-vu:SetSeller')
AddEventHandler('mn-vu:SetSeller',function()
    SellerId = tonumber(source)
    print('Setting seller id:'..SellerId)
end)
 
-- Create the charge
RegisterServerEvent('mn-vu:createCharge')
AddEventHandler('mn-vu:createCharge', function(amount)
	OrderTotal = amount
end)

-- Send Charge to client
RegisterServerEvent('mn-vu:chargeMe')
AddEventHandler('mn-vu:chargeMe', function()
	local _source = source
	local xPlayer  = mnCore.Functions.GetPlayer(_source)
	TriggerClientEvent('mn-vu:getcharged', _source, OrderTotal)
end)