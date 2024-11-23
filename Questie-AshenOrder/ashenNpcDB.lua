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
        [10299] = {
            [npcKeys.questStarts] = {4742,4743},
            [npcKeys.questEnds] = {4742,4743},
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