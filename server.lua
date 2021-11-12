ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



    ESX.RegisterServerCallback('bulletproof', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getInventoryItem("bulletproof").count >= 1 then
            xPlayer.removeInventoryItem("bulletproof", 1)
            cb(true)
        else
            cb(false)
        end
    end)