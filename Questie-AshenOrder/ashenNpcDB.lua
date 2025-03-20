---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
 
QuestieCompat.RegisterCorrection("npcData", function()
    local npcKeys = QuestieDB.npcKeys
    local zoneIDs = ZoneDB.zoneIDs
 
    return {
        [1327] = {
            [npcKeys.questEnds] = {30043},
        },
        [1402] = {
            [npcKeys.questEnds] = {30040},
        },
        [1405] = {
            [npcKeys.questStarts] = {30040},
        },
        [2094] = {
            [npcKeys.questStarts] = {471,484,40471},
            [npcKeys.questEnds] = {469,471,484,40471},
        },
        [8383] = {
            [npcKeys.questStarts] = {900600},
            [npcKeys.questEnds] = {900600},
        },
        [9997] = {
            [npcKeys.questEnds] = {4491,4501,884501},
        },
        [10299] = {
            [npcKeys.questStarts] = {4742,4743},
            [npcKeys.questEnds] = {4742,4743},
        },
        [18102] = {
            [npcKeys.questStarts] = {881431},
            [npcKeys.questEnds] = {881431},
        },
        [100139] = {
            [npcKeys.name] = "Aquila Empyrean",
            [npcKeys.subName] = "High Priestess",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.questStarts] = {30032},
            [npcKeys.questEnds] = {30031,30032,30039},
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{37.0,78.0}},
            },
        },
        [100140] = {
            [npcKeys.name] = "Kloveriell",
            [npcKeys.subName] = "The Silver Covenant",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.questStarts] = {30030,50000},
            [npcKeys.questEnds] = {50000},
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{37.2,78.2}},
            },
        },
        [100141] = {
            [npcKeys.name] = "Raelis Silentstep",
            [npcKeys.subName] = "Order of the Empyrean Void",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.questStarts] = {30035,30036,30037,30038,30039},
            [npcKeys.questEnds] = {30034,30035,30036,30037,30038},
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{78.4,70.5}},
            },
        },
        [100147] = {
            [npcKeys.name] = "Elandra Sagequill",
            [npcKeys.subName] = "Keeper of Lore",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.questStarts] = {30034},
            [npcKeys.questEnds] = {30033},
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{38.7,81.3}},
            },
        },
        [100157] = {
            [npcKeys.name] = "Eldreth Spellshard",
            [npcKeys.subName] = "The Silver Covenant",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.questStarts] = {30031},
            [npcKeys.questEnds] = {30030},
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{46.6,21.1}},
            },
        },
        [100164] = {
            [npcKeys.name] = "Avery",
            [npcKeys.subName] = "Defias Brotherhood",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{78.4,32.9}},
            },
        },
        [100165] = {
            [npcKeys.name] = "Defias Ritualist",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{78.2,33.3},{78.2,32.6},{78.7,32.5}},
            },
        },
        [100166] = {
            [npcKeys.name] = "Defias Infiltrator",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{77.7,34.9},{79.0,30.9},{81.9,39.0},{73.6,40.6}},
            },
        },
        [100167] = {
            [npcKeys.name] = "Farmer David",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 8,
            [npcKeys.questStarts] = {30041,30042},
            [npcKeys.questEnds] = {30041,30042},
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{52.7,5.4}},
            },
        },
        [110000] = {
            [npcKeys.name] = "Duke Willford Wellington",
            [npcKeys.subName] = "House of Nobles",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{77.7,49.6}},
            },
        },
        [110001] = {
            [npcKeys.name] = "Lord Maximilian Whitmore",
            [npcKeys.subName] = "House of Nobles",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{69.4,29.7}},
            },
        },
        [180016] = {
            [npcKeys.name] = "Alaric Ashenford",
            [npcKeys.subName] = "Journeyman Alchemist",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.questStarts] = {100003,100006},
            [npcKeys.questEnds] = {100003,100005},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{37.7,64.4}},
            },
        },
        [180028] = {
            [npcKeys.name] = "Giovanny Swail",
            [npcKeys.subName] = "Journeyman Tailor",
            [npcKeys.minLevel] = 22,
            [npcKeys.maxLevel] = 22,
            [npcKeys.questStarts] = {100015,100016},
            [npcKeys.questEnds] = {100015,100016},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{64.4,91.0}},
            },
        },
        [300000] = {
            [npcKeys.name] = "Scourge Force",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
        },
        [301000] = {
            [npcKeys.name] = "Onyxia",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
            [npcKeys.zoneID] = zoneIDs.ONYXIAS_LAIR,
        },
        [351019] = {
            [npcKeys.name] = "Kel'Thuzad",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
            [npcKeys.zoneID] = zoneIDs.NAXXRAMAS_FROSTWYRM_LAIR,
        },
        [400010] = {
            [npcKeys.name] = "Ghoul",
            [npcKeys.minLevel] = 14,
            [npcKeys.maxLevel] = 15,
            [npcKeys.zoneID] = zoneIDs.WESTFALL,
            [npcKeys.spawns] = {
                [zoneIDs.WESTFALL] = {{47.8,45.5},{55.3,46.9},{43.7,67.9},{53.3,52.4},{38.0,53.4},{41.9,40.6},{45.4,35.6},{54.6,32.9},{50.5,22.6}},
            },
        },
        [400112] = {
            [npcKeys.name] = "Hate Shrieker",
            [npcKeys.minLevel] = 19,
            [npcKeys.maxLevel] = 24,
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.spawns] = {
                [zoneIDs.THE_BARRENS] = {{51.9,28.7},{52.4,26.5},{51.0,31.6},{52.1,33.8},{53.7,31.8}},
            },
        },
        [400113] = {
            [npcKeys.name] = "Sutures",
            [npcKeys.minLevel] = 27,
            [npcKeys.maxLevel] = 27,
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.spawns] = {
                [zoneIDs.THE_BARRENS] = {{50.1,40.5},{53.4,31.3},{56.6,43.1},{47.4,57.1},{47.5,48.5}},
            },
        },
        [400114] = {
            [npcKeys.name] = "Lithe Prowler",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.spawns] = {
                [zoneIDs.THE_BARRENS] = {{52.1,33.5},{53.8,31.9},{52.4,26.7},{49.6,29.0}},
            },
        },
        [400015] = {
            [npcKeys.name] = "Lithe Stalker",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 20,
            [npcKeys.zoneID] = zoneIDs.WESTFALL,
            [npcKeys.spawns] = {
                [zoneIDs.WESTFALL] = {{57.9,27.7}},
            },
        },
        [400016] = {
            [npcKeys.name] = "Skeletal Warrior",
            [npcKeys.minLevel] = 16,
            [npcKeys.maxLevel] = 17,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.spawns] = {
                [zoneIDs.REDRIDGE_MOUNTAINS] = {{35.6,43.4},{29.0,67.6},{28.1,68.2}},
                [zoneIDs.THE_BARRENS] = {{52.0,33.8},{53.7,31.7},{52.3,26.7},{49.7,29.1}},
            },
        },
        [400118] = {
            [npcKeys.name] = "Suture's Remains",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.questStarts] = {30023},
            [npcKeys.questEnds] = {30022},
        },
        [400028] = {
            [npcKeys.name] = "Panicked Stormwind Citizen",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 63,
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{63.6,65.4},{71.9,65.3},{64.3,48.4},{54.5,59.8},{44.7,59.2},{47.6,73.1}},
            },
        },
        [400034] = {
            [npcKeys.name] = "Dummy NPC",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
        },
        [400037] = {
            [npcKeys.name] = "Anti-Scourge Cannon",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.spawns] = {
                [zoneIDs.ORGRIMMAR] = {{61.4,37.8},{63.1,41.3},{74.1,31.6},{76.7,33.6},{49.0,36.3},{52.2,58.2},{46.3,65.2},{46.0,75.6},{53.6,84.5}},
            },
        },
        [400064] = {
            [npcKeys.name] = "Grand Apothecary Putress",
            [npcKeys.subName] = "Lich Rune Vendor",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.npcFlags] = 131,
            [npcKeys.friendlyToFaction] = "H",
            [npcKeys.questStarts] = {30005,30007,30009,30010,30028},
            [npcKeys.questEnds] = {30006,30008,30009,30010,30028},
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.spawns] = {
                [zoneIDs.ORGRIMMAR] = {{32.1,36.6}},
            },
        },
        [400067] = {
            [npcKeys.name] = "Orgrimmar Citizen",
            [npcKeys.minLevel] = 55,
            [npcKeys.maxLevel] = 60,
            [npcKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [npcKeys.spawns] = {
                [zoneIDs.ORGRIMMAR] = {{37.5,64.8},{54.7,67.9},{49.1,54.3},{45.4,38.0},{52.5,45.0},{55.6,36.8},{59.8,49.0},{69.1,39.6},{72.3,29.9},{70.7,27.0},{65.6,22.2},{73.6,19.6},{77.8,12.6},{75.8,9.5}},
            },
        },
        [400077] = {
            [npcKeys.name] = "Blistering Zombie",
            [npcKeys.minLevel] = 17,
            [npcKeys.maxLevel] = 18,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.spawns] = {
                [zoneIDs.REDRIDGE_MOUNTAINS] = {{35.5,42.3},{35.9,43.0},{36.2,43.8},{32.3,62.7},{31.2,65.2},{30.6,64.8}},
                [zoneIDs.THE_BARRENS] = {{52.0,33.9},{53.8,31.9},{52.3,26.4},{49.5,29.0},{50.0,40.5}},
            },
        },
        [400080] = {
            [npcKeys.name] = "Lakeshire Villager",
            [npcKeys.minLevel] = 18,
            [npcKeys.maxLevel] = 23,
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.spawns] = {
                [zoneIDs.REDRIDGE_MOUNTAINS] = {{30.7,48.4},{29.5,47.9},{28.6,47.8},{28.3,47.0},{26.6,46.8},{26.6,46.1},{26.6,45.7},{26.9,45.4}},
            },
        },
        [400095] = {
            [npcKeys.name] = "Dummy NPC",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
        },
        [400096] = {
            [npcKeys.name] = "Loremaster Talandria",
            [npcKeys.minLevel] = 24,
            [npcKeys.maxLevel] = 24,
            [npcKeys.questStarts] = {30015,30016,30017,30018},
            [npcKeys.questEnds] = {30014,30015,30016,30017,30018},
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
            [npcKeys.spawns] = {
                [zoneIDs.REDRIDGE_MOUNTAINS] = {{22.8,43.2}},
            },
        },
        [400097] = {
            [npcKeys.name] = "Undead Warlord's Remains",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
            [npcKeys.questStarts] = {30014},
            [npcKeys.zoneID] = zoneIDs.REDRIDGE_MOUNTAINS,
        },
        [400103] = {
            [npcKeys.name] = "Spirit of Thalgorath",
            [npcKeys.minLevel] = 30,
            [npcKeys.maxLevel] = 30,
        },
        [400104] = {
            [npcKeys.name] = "Crossroads Villager",
            [npcKeys.minLevel] = 19,
            [npcKeys.maxLevel] = 25,
            [npcKeys.zoneID] = zoneIDs.THE_BARRENS,
            [npcKeys.spawns] = {
                [zoneIDs.THE_BARRENS] = {{52.2,31.8},{52.2,31.0},{52.1,31.0},{51.9,30.0},{51.1,29.0},{51.0,29.6},{51.3,30.3}},
            },
        },
        [400120] = {
            [npcKeys.name] = "Patchqwerk's Remains",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
        },
        [400121] = {
            [npcKeys.name] = "Skalathrax's Remains",
            [npcKeys.minLevel] = 25,
            [npcKeys.maxLevel] = 25,
        },
        [800058] = {
            [npcKeys.name] = "Invisible Thorns Bunny",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{63.0,91.1}},
            },
        },
        [800059] = {
            [npcKeys.name] = "Invisible Claw Marks Bunny",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{65.2,90.6}},
            },
        },
        [800060] = {
            [npcKeys.name] = "Invisible Grave Bunny",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{62.5,93.5}},
            },
        },
        [810010] = {
            [npcKeys.name] = "Grizzle Snout",
            [npcKeys.subName] = "Thunderhoof Boars",
            [npcKeys.minLevel] = 33,
            [npcKeys.maxLevel] = 33,
            [npcKeys.questStarts] = {300000},
            [npcKeys.questEnds] = {300000},
            [npcKeys.zoneID] = zoneIDs.RAZORFEN_KRAUL,
            [npcKeys.spawns] = {
                [zoneIDs.RAZORFEN_KRAUL] = {{65.5,64.9}},
            },
        },
        [810119] = {
            [npcKeys.name] = "Crystallon, the Stonehearted",
            [npcKeys.minLevel] = 63,
            [npcKeys.maxLevel] = 63,
            [npcKeys.zoneID] = zoneIDs.STONETALON_MOUNTAINS,
            [npcKeys.spawns] = {
                [zoneIDs.STONETALON_MOUNTAINS] = {{44.5,20.3}},
            },
        },
        [883296] = {
            [npcKeys.name] = "Orgrimmar Grunt",
            [npcKeys.minLevel] = 15,
            [npcKeys.maxLevel] = 55,
            [npcKeys.questStarts] = {5722,5723,5728,5761,14356},
            [npcKeys.zoneID] = zoneIDs.RAGEFIRE_CHASM,
            [npcKeys.spawns] = {
                [zoneIDs.RAGEFIRE_CHASM] = {{65.1,9.3}},
            },
        },
        [900003] = {
            [npcKeys.name] = "Foe Reaper 9001",
            [npcKeys.minLevel] = 23,
            [npcKeys.maxLevel] = 23,
            [npcKeys.zoneID] = zoneIDs.WESTFALL,
            [npcKeys.spawns] = {
                [zoneIDs.WESTFALL] = {{54.8,32.6}},
            },
        },
        [950000] = {
            [npcKeys.name] = "Sir Cedric Blackwood",
            [npcKeys.subName] = "Enclave Member",
            [npcKeys.minLevel] = 9,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{54.6,27.8}},
            },
        },
        [950002] = {
            [npcKeys.name] = "Notarius Blackwood",
            [npcKeys.subName] = "Enclave Member",
            [npcKeys.minLevel] = 8,
            [npcKeys.maxLevel] = 9,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{51.7,33.6}},
            },
        },
        [950005] = {
            [npcKeys.name] = "Marisa Bristol",
            [npcKeys.subName] = "Enclave Member",
            [npcKeys.minLevel] = 12,
            [npcKeys.maxLevel] = 13,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{56.6,33.5}},
            },
        },
        [950006] = {
            [npcKeys.name] = "Mira Nightwhisper",
            [npcKeys.subName] = "The Nightcloaks",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.questStarts] = {100033,100034},
            [npcKeys.questEnds] = {100031,100032,100033,100034},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{52.6,36.1}},
            },
        },
        [950009] = {
            [npcKeys.name] = "Ravenous Worgen",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 12,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
        },
        [950010] = {
            [npcKeys.name] = "Ravenous Worgen",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 12,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
        },
        [950012] = {
            [npcKeys.name] = "Trueblood Worgen",
            [npcKeys.minLevel] = 11,
            [npcKeys.maxLevel] = 12,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
        },
        [950013] = {
            [npcKeys.name] = "Bridge Barricade",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
        },
        [1000000] = {
            [npcKeys.name] = "Victor Hawthorn",
            [npcKeys.subName] = "Duskhaven's Vigilant",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.questStarts] = {100000,100004},
            [npcKeys.questEnds] = {100000},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{36.3,64.1}},
            },
        },
        [1000001] = {
            [npcKeys.name] = "Obsidian Wolf",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 2,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{34.6,68.5}},
            },
        },
        [1000002] = {
            [npcKeys.name] = "Cormac Blackwood",
            [npcKeys.subName] = "Gilnean Herbologist",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.questStarts] = {100001,100002,100005},
            [npcKeys.questEnds] = {100001,100002,100004},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{38.1,64.7}},
            },
        },
        [1000003] = {
            [npcKeys.name] = "Feral Worgen",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 4,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{37.5,74.5}},
            },
        },
        [1000009] = {
            [npcKeys.name] = "Cursed Gilnean",
            [npcKeys.minLevel] = 4,
            [npcKeys.maxLevel] = 4,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{36.4,61.3}},
            },
        },
        [1000012] = {
            [npcKeys.name] = "Lorna Crowley",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.questStarts] = {100012},
            [npcKeys.questEnds] = {100006,100020},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{26.6,47.0}},
            },
        },
        [1000013] = {
            [npcKeys.name] = "Aldric Wolfheart",
            [npcKeys.minLevel] = 4,
            [npcKeys.maxLevel] = 4,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{32.5,77.5}},
            },
        },
        [1000014] = {
            [npcKeys.name] = "Eleanor Silverpaw",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.questStarts] = {100007},
            [npcKeys.questEnds] = {100007},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{36.9,64.3}},
            },
        },
        [1000015] = {
            [npcKeys.name] = "Eamon Greyson",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.questStarts] = {100008},
            [npcKeys.questEnds] = {100008},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{35.8,74.5}},
            },
        },
        [1000016] = {
            [npcKeys.name] = "Emilli Greyson",
            [npcKeys.minLevel] = 4,
            [npcKeys.maxLevel] = 4,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{29.0,63.6}},
            },
        },
        [1000017] = {
            [npcKeys.name] = "Rugged Thorne",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.questStarts] = {100009},
            [npcKeys.questEnds] = {100009},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{29.1,61.0}},
            },
        },
        [1000018] = {
            [npcKeys.name] = "Stray Horse",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{26.8,67.1},{28.7,69.5},{26.0,71.3},{24.5,68.3},{26.1,58.1},{24.4,60.8}},
            },
        },
        [1000019] = {
            [npcKeys.name] = "Brook Harrington",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.questStarts] = {100010},
            [npcKeys.questEnds] = {100010},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{36.3,82.2}},
            },
        },
        [1000020] = {
            [npcKeys.name] = "Murloc",
            [npcKeys.minLevel] = 4,
            [npcKeys.maxLevel] = 5,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{35.0,82.7},{33.6,85.7},{36.9,83.4},{36.4,87.4},{37.3,86.0},{38.9,84.0}},
            },
        },
        [1000021] = {
            [npcKeys.name] = "Thresher",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{35.1,87.9},{33.3,88.4},{29.2,86.5}},
            },
        },
        [1000025] = {
            [npcKeys.name] = "Carriage",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{29.0,54.0}},
            },
        },
        [1000026] = {
            [npcKeys.name] = "Munira Hammond",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.questStarts] = {100011,100017},
            [npcKeys.questEnds] = {100011,100019},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{27.9,67.0}},
            },
        },
        [1000030] = {
            [npcKeys.name] = "Darius Crowley",
            [npcKeys.subName] = "Lord",
            [npcKeys.minLevel] = 23,
            [npcKeys.maxLevel] = 23,
            [npcKeys.questStarts] = {100013},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
        },
        [1000031] = {
            [npcKeys.name] = "Crazed Worgen",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 5,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{49.2,80.1}},
            },
        },
        [1000033] = {
            [npcKeys.name] = "Blackwald Spider",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 7,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{67.5,89.7},{66.8,87.3},{66.5,90.7}},
            },
        },
        [1000034] = {
            [npcKeys.name] = "Arachnothorn Weaver",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 7,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{67.7,82.9},{67.0,84.9},{66.2,85.7}},
            },
        },
        [1000044] = {
            [npcKeys.name] = "Alden Croley",
            [npcKeys.minLevel] = 23,
            [npcKeys.maxLevel] = 23,
            [npcKeys.questStarts] = {100014},
            [npcKeys.questEnds] = {100013,100014},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
        },
        [1000048] = {
            [npcKeys.name] = "Alexandar Hammond",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.questStarts] = {100018},
            [npcKeys.questEnds] = {100017},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{27.8,66.7}},
            },
        },
        [1000049] = {
            [npcKeys.name] = "Selene Hammond",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.questStarts] = {100019},
            [npcKeys.questEnds] = {100018},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{47.0,81.8}},
            },
        },
        [1000050] = {
            [npcKeys.name] = "Selene Hammond",
            [npcKeys.minLevel] = 5,
            [npcKeys.maxLevel] = 5,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
        },
        [1000051] = {
            [npcKeys.name] = "Snoutripper the Tuskbane",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 5,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{46.8,83.8},{50.7,83.1},{48.6,86.9}},
            },
        },
        [1000052] = {
            [npcKeys.name] = "Hamlet",
            [npcKeys.minLevel] = 6,
            [npcKeys.maxLevel] = 6,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{47.0,81.8}},
            },
        },
        [1000053] = {
            [npcKeys.name] = "Carlisle Harmond",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.questStarts] = {100020},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{51.7,81.0}},
            },
        },
        [1000054] = {
            [npcKeys.name] = "Grom'thar the Sorcerer",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 5,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{45.9,88.1},{47.9,86.1},{49.6,83.3}},
            },
        },
        [1000061] = {
            [npcKeys.name] = "Eadric Greymane",
            [npcKeys.subName] = "Captain",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 30,
            [npcKeys.questEnds] = {100012},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{59.0,92.9}},
            },
        },
        [1000062] = {
            [npcKeys.name] = "Delina Ravenshadow",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 30,
            [npcKeys.questStarts] = {100022,100024,100025,100026,100027},
            [npcKeys.questEnds] = {100021,100023,100024,100025,100026},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{63.8,91.7}},
            },
        },
        [1000067] = {
            [npcKeys.name] = "Bound Villager",
            [npcKeys.minLevel] = 20,
            [npcKeys.maxLevel] = 30,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
        },
        [1000068] = {
            [npcKeys.name] = "Invisible Egg Bunny",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{68.2,83.5}},
            },
        },
        [1000069] = {
            [npcKeys.name] = "Rennick Shadowclaw",
            [npcKeys.subName] = "The Nightcloaks",
            [npcKeys.minLevel] = 3,
            [npcKeys.maxLevel] = 3,
            [npcKeys.questStarts] = {100028,100029,100030,100031,100032},
            [npcKeys.questEnds] = {100027,100028,100029,100030},
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{74.1,76.0}},
            },
        },
        [1000070] = {
            [npcKeys.name] = "Thalorin Fangclaw",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{78.2,72.2}},
            },
        },
        [1000071] = {
            [npcKeys.name] = "Garok Ironfur",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{77.4,72.4}},
            },
        },
        [1000072] = {
            [npcKeys.name] = "Lyran Shadowpelt",
            [npcKeys.minLevel] = 7,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{77.2,72.2}},
            },
        },
        [1000073] = {
            [npcKeys.name] = "Invisible Cage Bunny",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{78.3,70.7}},
            },
        },
        [1000075] = {
            [npcKeys.name] = "Invisible House Bunny",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
            [npcKeys.spawns] = {
                [zoneIDs.GILNEAS] = {{78.2,65.9}},
            },
        },
        [1000079] = {
            [npcKeys.name] = "Renegades Carriage",
            [npcKeys.minLevel] = 10,
            [npcKeys.maxLevel] = 10,
            [npcKeys.zoneID] = zoneIDs.GILNEAS,
        },
        [1400060] = {
            [npcKeys.name] = "Jared Long",
            [npcKeys.subName] = "Fisherman",
            [npcKeys.minLevel] = 1,
            [npcKeys.maxLevel] = 1,
            [npcKeys.questStarts] = {30043},
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{47.9,52.6}},
            },
        },
        [1500017] = {
            [npcKeys.name] = "Elathalis Shadowcloud",
            [npcKeys.subName] = "Order of the Empyrean Void",
            [npcKeys.minLevel] = 60,
            [npcKeys.maxLevel] = 60,
            [npcKeys.questStarts] = {30033},
            [npcKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [npcKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{36.8,77.6}},
            },
        },
    }
end)