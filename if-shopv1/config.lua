Config = {}

Config.Framework = 'QB' -- ESX or QB
Config.FrameworkCore = 'if-core' -- es_extended, qb-core, if-core, ...

Config.Notification = function(message, type)
  --  TriggerEvent('esx:showNotification', message, type, 2500)
    TriggerEvent('QBCore:Notify', message, type, 5000)
end

Config.PayMethod = 'money' -- money/cash, bank

Config.Items = {
    ['hotdog'] = { -- Item
        category = "category_1", -- Category
        display = "Tomato", -- Display Name
        price = 5, -- Price per unit
        description = "A fresh tomato, great for your receipts...", -- Description
    },
    ['burger'] = {
        category = "category_2",
        display = "Hamburger",
        price = 10,
        description = "A delicious hamburger...",
    },
    ['potato'] = {
        category = "category_2",
        display = "Potato",
        price = 10,
        description = "A delicious Potato With Sus...",
    },
    ['cake'] = {
        category = "category_3",
        display = "Cake",
        price = 10,
        description = "A delicious Cake With Cream...",
    },
    ['icecream'] = {
        category = "category_3",
        display = "Ice-Cream",
        price = 10,
        description = "Nuttela Ice-cream Enjoy it..",
    },
    ['drink1'] = {
        category = "category_1",
        display = "Blueberry Juice",
        price = 10,
        description = "Blue Juice with OPS..",
    },
    ['drink2'] = {
        category = "category_1",
        display = "Lemon Juice",
        price = 10,
        description = "Lemon Juice with OPS..",
    },
    ['drink3'] = {
        category = "category_1",
        display = "Coffee PEPS",
        price = 10,
        description = "Micheal Jackson Coffee..",
    },
    ['drink4'] = {
        category = "category_1",
        display = "Hell Juice",
        price = 10,
        description = "Fucking Hell Juice..",
    },
    ['drink5'] = {
        category = "category_1",
        display = "Wine",
        price = 10,
        description = "Russian Wine IQ..",
    },
    ['popcorn'] = {
        category = "category_4",
        display = "Popcorn",
        price = 10,
        description = "Eat popcorn with Movie..",
    },
    ['snack'] = {
        category = "category_4",
        display = "Snack",
        price = 10,
        description = "Salty Snack..",
    },
    ['dunat'] = {
        category = "category_3",
        display = "Chocolate Dunat",
        price = 10,
        description = "Pop Donut..",
    },
}

Config.Locale = {
    buyed = "You made a purchase, paid $%s.",
    nomoney = "You can't afford the purchase!",
    Interact = "Press ~INPUT_CONTEXT~ to access the Shop",
}

Config.Shops = {
    { x = 373.875,   y = 325.896,   z = 102.566, blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 2557.458,  y = 382.282,   z = 107.622, blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -3038.939, y = 585.954,   z = 6.908,   blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -3241.927, y = 1001.462,  z = 11.830,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -2191.65,  y = 4285.4,    z = 49.18,   blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 1961.464,  y = 3740.672,  z = 31.343,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 2678.916,  y = 3280.671,  z = 54.241,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 1729.216,  y = 6414.131,  z = 34.037,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 1135.808,  y = -982.281,  z = 45.415,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 25.7,      y = -1346.7,   z = 28.4,    blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -1222.915, y = -906.983,  z = 11.326,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -1487.553, y = -379.107,  z = 39.163,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -2968.243, y = 390.910,   z = 14.043,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 1166.024,  y = 2708.930,  z = 37.157,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 1392.562,  y = 3604.684,  z = 33.980,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 127.830,   y = -1284.796, z = 28.280,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -1393.409, y = -606.624,  z = 29.319,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -559.906,  y = 287.093,   z = 81.176,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -48.519,   y = -1757.514, z = 28.421,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 1163.373,  y = -323.801,  z = 68.205,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -707.501,  y = -914.260,  z = 18.215,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = -1820.523, y = 792.518,   z = 137.118, blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 },
    { x = 1698.388,  y = 4924.404,  z = 41.063,  blipname = "Store", blipsprite = 590, blipcolor = 0, blipscale = 1.0, dist = 2.5 }
}