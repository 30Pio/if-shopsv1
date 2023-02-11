local FrameworkSelected = Config.Framework and Config.Framework:lower() or nil

local ESX = nil
local QBCore = nil

if (FrameworkSelected == "esx") then
    if (Config.FrameworkCore) then
        ESX = exports[Config.FrameworkCore]:getSharedObject()
        if (not ESX) then
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end
    else
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
    if (not ESX) then
        print('     ERROR: Invalid FrameworkCore! Pls fix it on Config!!!')
    end
elseif (FrameworkSelected == "qb" or FrameworkSelected == "qb-core" or FrameworkSelected == "qbcore") then
    if (Config.FrameworkCore) then
        QBCore = exports[Config.FrameworkCore]:GetCoreObject()
    else
        print('     ERROR: Invalid FrameworkCore! Pls fix it on Config!!!')
    end
else
    print('     ERROR: Unknown Framework! Available: ESX or QB!')
end

-- [ MAIN ] --

local shopItems = Config.Items

local function toggleField(enable)
    SetNuiFocus(enable, enable)

    if enable then
        SendNUIMessage({
            action = 'open'
        })
    else
        SendNUIMessage({
            action = 'close'
        })
    end
end

RegisterNUICallback('escape', function(data, cb)
    toggleField(false)
    SetNuiFocus(false, false)

    cb('ok')
end)

RegisterNUICallback('buy', function(data, cb)
    local shoppingCart = data.shoppingCart
    local totalprice = 0
    for item, v in pairs(shoppingCart) do
        local configItem = shopItems[item]
        totalprice += (v.amount * configItem.price)
    end

    if (ESX) then
        ESX.TriggerServerCallback('if-shopv1:canAfford', function(bool)
            if (bool) then
                Config.Notification(Config.Locale.buyed:format(totalprice), 'success')
            else
                Config.Notification(Config.Locale.nomoney, 'error')
            end
            SetNuiFocus(not bool, not bool)
            cb(bool)
        end, totalprice, shoppingCart)
    elseif (QBCore) then
        QBCore.Functions.TriggerCallback('if-shopv1:canAfford', function(bool)
            if (bool) then
                Config.Notification(Config.Locale.buyed:format(totalprice), 'success')
            else
                Config.Notification(Config.Locale.nomoney, 'error')
            end
            SetNuiFocus(not bool, not bool)
            cb(bool)
        end, totalprice, shoppingCart)
    end
end)

local function addItem(category, item, display, price, description)
    SendNUIMessage({
        action = 'add',
        category = category,
        item = item,
        display = display,
        price = price,
        description = description,
    })
end

local function ShowHelpNotification(msg)
    AddTextEntry('shopsHelpNotification', msg)
    DisplayHelpTextThisFrame('shopsHelpNotification', false)
end

CreateThread(function()
    while true do
        local msec = 750
        local pCoords = GetEntityCoords(PlayerPedId())
        for key, value in pairs(Config.Shops) do
            local dist = #(pCoords - vector3(value.x, value.y, value.z))
            if (dist <= 20.0) then
                msec = 0
                DrawMarker(20, vector3(value.x, value.y, value.z + 1), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)
                if dist <= 2.0 then
                    ShowHelpNotification(Config.Locale.Interact)

                    if IsControlJustReleased(0, 38) then
                        SendNUIMessage({
                            action = 'clear'
                        })
                        for item, value2 in pairs(shopItems) do
                            addItem(value2.category, item, value2.display, value2.price, value2.description)
                        end
                        toggleField(true)
                    end
                end
            end
        end
        Wait(msec)
    end
end)

CreateThread(function()
    for k, coords in pairs(Config.Shops) do
        local blip = AddBlipForCoord(vector3(coords.x, coords.y, coords.z))

        SetBlipSprite(blip, coords.blipsprite)
        SetBlipScale(blip, coords.blipscale)
        SetBlipColour(blip, coords.blipcolor)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(coords.blipname)
        EndTextCommandSetBlipName(blip)
    end
end)