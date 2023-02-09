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

local function getFrameworkPlayerBalance(FPlayer)
	local balance = 0
	local payMethod = Config.PayMethod
	if (ESX) then
		if (payMethod == 'cash') then payMethod = 'money' end
		balance = FPlayer.getAccount(payMethod).money
	elseif (QBCore) then
		if (payMethod == 'money') then payMethod = 'cash' end
		balance = FPlayer.Functions.GetMoney(payMethod)
	end

	return tonumber(balance)
end
local function removeFrameworkPlayerMoney(FPlayer, amount)
	local payMethod = Config.PayMethod
	if (ESX) then
		if (payMethod == 'cash') then payMethod = 'money' end
		FPlayer.removeAccountMoney(payMethod, amount)
	elseif (QBCore) then
		if (payMethod == 'cash') then payMethod = 'money' end
		FPlayer.Functions.RemoveMoney(payMethod, amount)
	end
end

local function canAfford(source, cb, totalPrice, shoppingCart)
	local _source = source
	local FPlayer = ESX and ESX.GetPlayerFromId(_source) or QBCore and QBCore.Functions.GetPlayer(_source)
	local playerBalance = getFrameworkPlayerBalance(FPlayer)
	totalPrice = tonumber(totalPrice)

	if (playerBalance and playerBalance >= totalPrice) then
		for k, v in pairs(shoppingCart) do
			if (ESX) then FPlayer.addInventoryItem(v.item, v.amount or 1)
			elseif (QBCore) then FPlayer.Functions.AddItem(v.item, v.amount or 1)
			end
		end

		removeFrameworkPlayerMoney(FPlayer, totalPrice)

		cb(true)
	else
		cb(false)
	end
end

if (ESX) then ESX.RegisterServerCallback('if-shopv1:canAfford', canAfford)
elseif (QBCore) then QBCore.Functions.CreateCallback('if-shopv1:canAfford', canAfford)
end