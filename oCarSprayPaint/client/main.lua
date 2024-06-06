-- ESX = nil
-- Citizen.CreateThread(function()
--     while ESX == nil do
--         TriggerEvent('esx:getSharedObject', function(obj)
-- 			ESX = obj
-- 		end)
--         Citizen.Wait(100)
--     end
--     while ESX.GetPlayerData().job == nil do
--         Citizen.Wait(100)
--     end
--     ESX.PlayerData = ESX.GetPlayerData()
-- end)

local LoadPoint = { ".", "..", "...", "" }
local colorselected = ConfigDBP.ColorId[ConfigDBP.ColorName[1]]
local ouiounon = 0
local customindex = 1

function PlaySprayCanAnimation(time)
    local playerPed = PlayerPedId()
    local sprayCanDict = "anim@scripted@freemode@postertag@graffiti_spray@male@"
    local sprayCanAnim = "spray_can_var_01_male"
    local sprayCanProp = "prop_cs_spray_can"
    local particleDict = "core"
    local particleName = "exp_grd_bzgas_smoke"

    -- Charger le dictionnaire d'animation
    RequestAnimDict(sprayCanDict)
    while not HasAnimDictLoaded(sprayCanDict) do
        Citizen.Wait(100)
    end

    -- Charger le dictionnaire de particules
    RequestNamedPtfxAsset(particleDict)
    while not HasNamedPtfxAssetLoaded(particleDict) do
        Citizen.Wait(100)
    end

    -- Aligner l'orientation du joueur
    local heading = GetEntityHeading(playerPed)
    SetEntityHeading(playerPed, heading)

    -- Jouer l'animation
    TaskPlayAnim(playerPed, sprayCanDict, sprayCanAnim, 8.0, -8.0, -1, 1, 0, false, false, false)

    -- Attacher le prop de la bombe de peinture au joueur
    local x, y, z = table.unpack(GetEntityCoords(playerPed))
    local prop = CreateObject(GetHashKey(sprayCanProp), x, y, z + 0.2, true, true, true)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0700, 0.0017365, 0.0, 0.0, true,
        true, false, true, 1, true)

    -- Commencer l'effet de particules
    UseParticleFxAssetNextCall(particleDict)
    local particleEffect = StartNetworkedParticleFxLoopedOnEntityBone(particleName, playerPed, 0.0, 0.0, 0.0, 0.0, 90.0,
        0.0,
        GetEntityBoneIndexByName(prop, "spray"), 1.4, false, false, false)

    Citizen.Wait(time * 1000) -- Durée de l'animation

    -- Arrêter l'effet de particules et l'animation, et supprimer l'objet après le temps spécifié
    StopParticleFxLooped(particleEffect, 0)
    ClearPedTasks(playerPed)
    DeleteObject(prop)
end

function _U(entry)
    local locale = ConfigDBP.Locale
    if Locales[locale] and Locales[locale][entry] then
        return Locales[locale][entry]
    else
        return 'Translation [' .. locale .. '][' .. entry .. '] does not exist'
    end
end

local dmbombe = RageUI.CreateMenu("", _U('welcome'), 0, 0, 'DENMENU', 'shopui_title_carmod2')
dmbombe.Closed = function()
    open = false
end

function dbombe()
    if open then
        open = false
        RageUI.Visible(dmbombe, false)
        return
    else
        open = true
        RageUI.Visible(dmbombe, true)
        CreateThread(function()
            while open do
                local pcoords = GetEntityCoords(PlayerPedId())
                local veh, dst = ESX.Game.GetClosestVehicle(pcoords)
                local model = GetEntityModel(veh)
                local nameveh = GetDisplayNameFromVehicleModel(model)
                local plate = GetVehicleNumberPlateText(veh)
                if ConfigDBP.BlackListVehicle[nameveh] then
                    ouiounon = 0
                else
                    ouiounon = 1
                end
                if dst > 5 then
                    RageUI.CloseAll()
                    ESX.ShowNotification(_U('no_vehicle'))
                    return
                end
                RageUI.IsVisible(dmbombe, function()
                    RageUI.Separator(_U('selected_vehicle') .. nameveh)
                    RageUI.Separator(_U('vehicle_plate') .. plate)
                    if ouiounon == 1 then
                        RageUI.Separator(_U('custom_possible'))
                    else
                        RageUI.Separator(_U('custom_not_possible'))
                    end
                    RageUI.List("Couleur", ConfigDBP.ColorName, customindex, nil, {}, ouiounon == 1, {
                        onListChange = function(index)
                            customindex = index
                            colorselected = ConfigDBP.ColorId[ConfigDBP.ColorName[index]]
                        end
                    })
                    RageUI.Button(_U('confirm_modification'), nil, { RightBadge = RageUI.BadgeStyle.Tick }, ouiounon == 1,
                        {
                            onSelected = function()
                                RageUI.CloseAll()
                                vehiclemodif(veh, colorselected, colorselected)
                            end
                        })
                end)
                Citizen.Wait(1)
            end
        end)
    end
end

function DrawTextProgress(Text, Text3, Taille, Text2, Font, Justi, havetext)
    SetTextFont(Font)
    SetTextScale(Taille, Taille)
    SetTextColour(255, 255, 255, 255)
    SetTextJustification(Justi or 1)
    SetTextEntry("STRING")
    if havetext then SetTextWrap(Text, Text + .1) end
    AddTextComponentString(Text2)
    DrawText(Text, Text3)
end

function AddProgressBar(Text, r, g, b, a, Timing)
    if Timing then
        DeleteProgressBar()
        ActiveProgressBar = true
        Citizen.CreateThread(function()
            local Timing1, Timing2 = 0.0, GetGameTimer() + Timing
            local Point, AddLoadPoint = ""
            while ActiveProgressBar and (Timing1 < 1) do
                Citizen.Wait(0)
                if Timing1 < 1 then
                    Timing1 = 1 - ((Timing2 - GetGameTimer()) / Timing)
                end
                if not AddLoadPoint or GetGameTimer() >= AddLoadPoint then
                    AddLoadPoint = GetGameTimer() + 500
                    Point = LoadPoint[string.len(Point) + 1] or ""
                end
                DrawRect(0.5, 0.940, 0.15, 0.03, 0, 0, 0, 100)
                local y, endroit = 0.15 - 0.0025, 0.03 - 0.005
                local chance = math.max(0, math.min(y, y * Timing1))
                DrawRect((0.5 - y / 2) + chance / 2, 0.940, chance, endroit, r, g, b, a)
                DrawTextProgress(0.5, 0.940 - 0.0125, 0.3, (Text or _U('action_in_progress')) .. Point, 0, 0, false)
            end
            DeleteProgressBar()
        end)
    end
end

function DeleteProgressBar()
    ActiveProgressBar = nil
end

RegisterNetEvent("startMenu")
AddEventHandler("startMenu", function()
    dbombe()
end)

function vehiclemodif(vehicle, color1, color2)
    TriggerServerEvent("DEN:RemoveItem")
    AddProgressBar(_U('action_in_progress'), 42, 37, 40, 0.74, ConfigDBP.Time * 1000)
    PlaySprayCanAnimation(ConfigDBP.Time)
    ESX.Game.SetVehicleProperties(vehicle, {
        color1 = color1,
        color2 = color2
    })
end
