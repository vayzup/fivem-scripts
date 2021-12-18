Config = {}
Config.Recipes = {
    ['vodka_battery'] = {
        Amount = 1, 
        Animation = 'PROP_HUMAN_BUM_BIN', 
        Ingredients = { 
            ['battery'] = 1,
            ['vodka'] = 1,
            ['ice'] = 1
        }
    },
    ['mojito'] = {
        Amount = 1, 
        Animation = 'PROP_HUMAN_BUM_BIN', 
        Ingredients = { 
            ['rom'] = 1,
            ['limejuice'] = 1,
            ['sukker'] = 1,
            ['mynteblad'] = 1,
            ['ice'] = 1
        }
    },   
    ['romcola'] = {
        Amount = 1, 
        Animation = 'PROP_HUMAN_BUM_BIN', 
        Ingredients = { 
            ['cocacola'] = 1,
            ['rom'] = 1,
            ['ice'] = 1
        }
    }   
    
}

Config.shop = {
    vector3(928.76,-1826.86,30.78)
}
Config.Items = {
    label = "Vinmonopolet",
    slots = 30,
    items = {
        [1] = {
            name = "sukker",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "ice",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "mynteblad",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "vodka",
            price = 50,
            amount = 100,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "rom",
            price = 50,
            amount = 100,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "beer",
            price = 30,
            amount = 100,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "whiskey",
            price = 70,
            amount = 100,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "wine",
            price = 50,
            amount = 100,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "cocacola",
            price = 25,
            amount = 1500,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "limejuice",
            price = 25,
            amount = 1500,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "battery",
            price = 25,
            amount = 1500,
            info = {},
            type = "item",
            slot = 11,
        }
    }
}


Config.AuthorizedIds = {}