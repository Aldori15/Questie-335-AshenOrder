---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
 
QuestieCompat.RegisterCorrection("itemData", function()
    local itemKeys = QuestieDB.itemKeys
 
    return {
        [36785] = {
            [itemKeys.name] = "Tough Abomination Flesh",
            [itemKeys.relatedQuests] = {30026},
        },
        [60084] = {
            [itemKeys.name] = "Light-Infused Ribbon",
            [itemKeys.relatedQuests] = {30003},
        },
        [60085] = {
            [itemKeys.name] = "Box of Traps",
            [itemKeys.relatedQuests] = {30004,30009},
        },
        [60115] = {
            [itemKeys.name] = "Shadow-Drenched Cloth",
            [itemKeys.relatedQuests] = {30010},
        },
        [60118] = {
            [itemKeys.name] = "Moonwell Vial",
            [itemKeys.relatedQuests] = {30016},
        },
        [60119] = {
            [itemKeys.name] = "Filled Moonwell Vial",
            [itemKeys.relatedQuests] = {30016},
        },
        [65002] = {
            [itemKeys.name] = "Teleporter",
            [itemKeys.relatedQuests] = {30006},
        },
        [65003] = {
            [itemKeys.name] = "Turret Zapper",
            [itemKeys.relatedQuests] = {30008},
        },
        [65005] = {
            [itemKeys.name] = "Skull of an Undead Warlord",
            [itemKeys.startQuest] = 30014,
            [itemKeys.relatedQuests] = {30014},
        },
        [65006] = {
            [itemKeys.name] = "Eternal Ember",
            [itemKeys.relatedQuests] = {30015},
        },
        [65007] = {
            [itemKeys.name] = "The Crusader's Tome",
            [itemKeys.relatedQuests] = {30017},
        },
        [800069] = {
            [itemKeys.name] = "Bouquet of Moon Lilies",
            [itemKeys.relatedQuests] = {30030},
        },
        [800070] = {
            [itemKeys.name] = "Light-infused Crystal",
            [itemKeys.relatedQuests] = {30032},
        },
        [800071] = {
            [itemKeys.name] = "Squirrel Meat",
            [itemKeys.relatedQuests] = {30040},
        },
        [800072] = {
            [itemKeys.name] = "Rat Meat",
            [itemKeys.relatedQuests] = {30040},
        },
        [800075] = {
            [itemKeys.name] = "A Shadowy Message",
            [itemKeys.relatedQuests] = {30033,30034},
        },
        [800077] = {
            [itemKeys.name] = "Revealing Letter",
            [itemKeys.relatedQuests] = {30037},
        },
        [800079] = {
            [itemKeys.name] = "Grappling Hook",
            [itemKeys.relatedQuests] = {30038},
        },
        [800081] = {
            [itemKeys.name] = "Interrogation",
            [itemKeys.relatedQuests] = {30035},
        },
        [800083] = {
            [itemKeys.name] = "Delivery of Fish",
            [itemKeys.relatedQuests] = {30043},
        },
        [800087] = {
            [itemKeys.name] = "Gloomroot Extract",
            [itemKeys.relatedQuests] = {100001,100005},
        },
        [800088] = {
            [itemKeys.name] = "Fresh Boar Meat",
            [itemKeys.relatedQuests] = {100002},
        },
        [800089] = {
            [itemKeys.name] = "Fresh Deer Meat",
            [itemKeys.relatedQuests] = {100002},
        },
        [800090] = {
            [itemKeys.name] = "Potion of Lucidity",
            [itemKeys.relatedQuests] = {100003,100028},
        },
        [800091] = {
            [itemKeys.name] = "Chicken Eggs",
            [itemKeys.relatedQuests] = {100007},
        },
        [800092] = {
            [itemKeys.name] = "Selene's Necklace",
            [itemKeys.relatedQuests] = {100011},
        },
        [800095] = {
            [itemKeys.name] = "Spider Leg",
            [itemKeys.relatedQuests] = {100014},
        },
        [800096] = {
            [itemKeys.name] = "Blackwald Spider Silk",
            [itemKeys.relatedQuests] = {100015},
        },
        [800101] = {
            [itemKeys.name] = "Lycanthea Diary",
            [itemKeys.startQuest] = 100023,
        },
        [800102] = {
            [itemKeys.name] = "Lycanthea Diary",
            [itemKeys.relatedQuests] = {100022,100023},
        },
        [800103] = {
            [itemKeys.name] = "Shadowfang Heart",
            [itemKeys.relatedQuests] = {100026},
        },
        [800104] = {
            [itemKeys.name] = "The Lady's Letter",
            [itemKeys.relatedQuests] = {100027},
        },
        [800108] = {
            [itemKeys.name] = "Operation Supply Disruption",
            [itemKeys.relatedQuests] = {100030},
        },
        [800109] = {
            [itemKeys.name] = "Critical Dispatch",
            [itemKeys.relatedQuests] = {100031},
        },
        [801931] = {
            [itemKeys.name] = "Rognar's Claw",
            [itemKeys.relatedQuests] = {50176},
        },
        [822457] = {
            [itemKeys.name] = "Tempest Lord's Essence",
            [itemKeys.relatedQuests] = {881431},
        },
        [830798] = {
            [itemKeys.name] = "Thundergut's Cracked Tooth",
            [itemKeys.relatedQuests] = {884501},
        },
        [883348] = {
            [itemKeys.name] = "Swallowed Clock",
            [itemKeys.relatedQuests] = {40471},
        },
    }
end)