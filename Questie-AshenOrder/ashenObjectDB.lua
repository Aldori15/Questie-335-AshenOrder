---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
---@type ZoneDB
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
 
QuestieCompat.RegisterCorrection("objectData", function()
    local objectKeys = QuestieDB.objectKeys
    local zoneIDs = ZoneDB.zoneIDs
 
    return {
        [174682] = {
            [objectKeys.questStarts] = {4501,884501},
        },
        [888649] = {
            [objectKeys.name] = "Alliance Taskboard",
            [objectKeys.questStarts] = {39533,39534,39537,39538,41537,41538,41541,41542,41544,41546,41549},
            [objectKeys.zoneID] = zoneIDs.STORMWIND_CITY,
            [objectKeys.spawns] = {
                [zoneIDs.STORMWIND_CITY] = {{62.9,71.6}},
            },
        },
        [888650] = {
            [objectKeys.name] = "Horde Taskboard",
            [objectKeys.questStarts] = {39533,39535,39536,39538,41536,41539,41540,41543,41545,41547,41548},
            [objectKeys.zoneID] = zoneIDs.ORGRIMMAR,
            [objectKeys.spawns] = {
                [zoneIDs.ORGRIMMAR] = {{50.5,70.5}},
            },
        },
        [890021] = {
            [objectKeys.name] = "Witch's Cauldron",
            [objectKeys.questEnds] = {39533},
            [objectKeys.zoneID] = zoneIDs.DUSKWOOD,
            [objectKeys.spawns] = {
                [zoneIDs.DUSKWOOD] = {{20.6,28.6}},
            },
        },
        [893062] = {
            [objectKeys.name] = "Corn Kernels",
            [objectKeys.zoneID] = zoneIDs.THUNDER_BLUFF,
            [objectKeys.spawns] = {
                [zoneIDs.THUNDER_BLUFF] = {{40.3,50.5},{34.4,54.1},{52.6,58.1},{53.3,81.4},{59.7,75.6},{61.8,48.7},{48.5,33.6},{69.5,31.5},{74.9,27.3}},
            },
        },
        [1000010] = {
            [objectKeys.name] = "Lost Journal",
            [objectKeys.questEnds] = {100022},
            [objectKeys.zoneID] = zoneIDs.GILNEAS,
        },
    }
end)