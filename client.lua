ESX = nil
local IsDead = false




local label = 
[[ 
  //
  ||    
  ||
  ||
  ||
  ||  	____        _ _      _                          __ 
  || 	|  _ \      | | |    | |                        / _|
  || 	| |_) |_   _| | | ___| |_ _ __  _ __ ___   ___ | |_ 
  || 	|  _ <| | | | | |/ _ \ __| '_ \| '__/ _ \ / _ \|  _|
  ||	| |_) | |_| | | |  __/ |_| |_) | | | (_) | (_) | |  
  || 	|____/ \__,_|_|_|\___|\__| .__/|_|  \___/ \___/|_|  
  ||                          	 | |                        
  ||                          	 |_|   
  ||
  ||
  ||
  ||
  ||    
  ||   
  || 
  || 
  ||
  ||                                                
  ||  
  ||           Created by 𝕯𝖊𝖗𝕰𝖈𝖍𝖙𝖊𝕴𝖆𝖓#7381
  ||]]



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
    IsDead = false
end)

local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01'
local isUsing = false


AddEventHandler("bulletproof", function()
	Citizen.CreateThread(function()
		if IsPedInAnyVehicle(PlayerPedId(), false) then
		    return
		end
		if isUsing then
			return
        end
        if IsDead then
            return
        end
		ESX.TriggerServerCallback('bulletproof', function(valid)
			if valid then
				local playerPed = PlayerPedId()
				isUsing = true
				exports[Config.Progressbar]:startUI(5000)


			

				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
					Citizen.Wait(0)

					Citizen.CreateThread(function()
						while isUsing do
							Citizen.Wait(0)

							DisableAllControlActions(0)
							EnableControlAction(0, 1, true)
							EnableControlAction(0, 2, true)
						end
					end)

					Citizen.Wait(5000)

					ClearPedTasks(playerPed)
					SetPedArmour(playerPed, 100)
					SetPedComponentVariation(playerPed, 9, 16, 1, 1)
					-- (playerPed, female1, male1, male2, female2,)
					isUsing = false
				
				end)
			else
				TriggerEvent('notifications', '#ffa200', "", "Du hast keine Schutzwesten!")
				return
			end
		end)
	end)
end)






RegisterCommand('bulletproof', function()
	TriggerEvent('bulletproof')
end)
RegisterKeyMapping('bulletproof', 'Schutzweste Benutzen', 'keyboard', '')
