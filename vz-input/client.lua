  exports('AddInput',function(trigger,placeholder,type)
    SetDisplay(true)
    SendNUIMessage({trigger = trigger,placeholder = placeholder,type = type})
  end)



  RegisterNUICallback("close" , function(data , cb)
    SetDisplay(false)
end)
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNetEvent("vz-input:test")
AddEventHandler("vz-input:test" , function(parameter)
    print("YEAH it's working "..parameter)
end)
RegisterNUICallback("main", function(data)
	amount = tonumber(data.text)
    TriggerEvent(data.trigger,data.text)
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


RegisterCommand("testinput" , function()
    exports['vz-input']:AddInput('vz-input:test','beløp')
end)