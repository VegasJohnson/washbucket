local RSGCore = exports['rsg-core']:GetCoreObject()

local washAnimDictwash = 'amb_misc@world_human_wash_face_bucket@ground@male_a@idle_b'
local washAnimwash = 'idle_e'

local LoadAnimDict = function(dict)
    local isLoaded = HasAnimDictLoaded(dict)

    while not isLoaded do
        RequestAnimDict(dict)
        Wait(5)
        isLoaded = not isLoaded
    end
end

RegisterNetEvent('rsg-wash:client:washkit')
AddEventHandler('rsg-wash:client:washkit', function ()

            local playerPed = PlayerPedId()
            local pos = GetEntityCoords(playerPed)
            local prop = GetHashKey("p_bucket02x")
                RequestModel(prop)
                while not HasModelLoaded(prop) do
                     Wait(10)
                end
            local tempObj2 = CreateObject(prop, pos.x, pos.y, pos.z, true, true, false)
            local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_L_Foot")
            FreezeEntityPosition(playerPed, true)
            AttachEntityToEntity(tempObj2, playerPed, boneIndex, 0.30, -0.05, 0.47, 267.0, 0.0, 22.0, true, true, false, true,  1, true)
    
        LoadAnimDict(washAnimDictwash)
    
        Wait(100)
                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
    
        TaskPlayAnim(playerPed, washAnimDictwash, washAnimwash, 3.0, 3.0, -1, 1, 0, false, false, false)
            Wait(20000)
        ClearPedEnvDirt(PlayerPedId())
        ClearPedBloodDamage(PlayerPedId())
        Citizen.InvokeNative(0xe3144b932dfdff65, PlayerPedId(), 0.0, -1, 1, 1)
        ClearPedDamageDecalByZone(PlayerPedId(), 10, "ALL")
        Citizen.InvokeNative(0x7F5D88333EE8A86F, PlayerPedId(), 1)
            ClearPedTasks(playerPed)
            DeleteObject(tempObj2)
            SetModelAsNoLongerNeeded(prop)
    
            FreezeEntityPosition(playerPed, false)
			TriggerServerEvent("RSGCore:Server:SetMetaData", "cleanliness", 100)
    
end)