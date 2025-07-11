--[[
Feast of Winter Veil    1.2.0    18 December 2004
Noblegarden    1.3.0    7 March 2005    X
Children's Week    1.4.0    5 May 2005
Darkmoon Faire    1.6.0    2 July 2005
Harvest Festival    1.6.0    2 July 2005    X
Hallow's End    1.8.0    10 October 2005
Lunar Festival    1.9.0    3 January 2006    X
Love is in the Air    1.9.3    7 February 2006
Midsummer Fire Festival    1.11.0    20 June 2006
Peon Day    1.12.1    22 August 2006    X

New Year    31st Dec - 1st Jan    New Year's Eve    Gregorian calendar
Lunar Festival    Varies (Spring)    Lunar New Year    Chinese calendar
Love is in the Air    7th Feb - 20th Feb    Valentine's Day
Noblegarden    Varies (Easter)    Easter
Children's Week    1st May - 7th May    Children's Day - Japan
Mother's Day - US (and in most other countries, including: Belgium and the Netherlands)
Midsummer Fire Festival    21st June - 5th July    Midsummer
Canada Day - CAN
Independence Day - US    US observed! Fire in the Sky Engineers' Explosive Extravaganza
Pirates' Day    19th Sept    International Talk Like a Pirate Day    First observed Sept 19th, 2008.
Brewfest    20th Sept - 4th Oct    Oktoberfest - Germany
Harvest Festival    27th Sept - 4th Oct    Roughly Thanksgiving - Canada, US (actually celebrated in October and November in Canada and US, respectively)
Columbus Day - US
US Stress Test ended: September 12, 2004
Peon Day    30th Sept    EU Closed Beta began: September 30, 2004    Observed only in Europe[1]
Hallow's End    18th Oct - 1st Nov    Halloween
Day of the Dead    1st Nov - 2nd Nov    Day of the Dead
WoW's Anniversary    16th Nov - 30th Nov
Pilgrim's Bounty    22nd Nov - 28th Nov    Thanksgiving
Feast of Winter Veil    15th Dec - 2nd Jan    Christmas

Harvest Festival history:         lunar calendar 15/8 in gregorian calendar:
2009: Su-Sa 27/9 - 3/10 (wowpedia)    3/10
2010: Th-We 16/9 - 22/9 (wowpedia)   22/9
2011: Tu-Mo  6/9 - 12/9 (wowpedia)   12/9
2012: Mo-Mo 24/9 - 1/10 (wowpedia)   30/9
2013: Fr-Fr 13/9 - 20/9 (wowpedia)   19/9
2014: Tu-Tu  2/9 -  9/9 (Blizz post)  8/9
2015: Mo-Mo 21/9 - 28/9 (wowpedia)   27/9
2016: Fr-Fr  9/9 - 16/9 (Blizz post) 15/9
2017: Fr-Fr 29/9 - 6/10 (wowpedia)    4/10
2018: Tu-Tu 18/9 - 25/9 (wowpedia)   24/9
2019: Tu-Tu 10/9 - 17/9 (classic Blizz post) 13/9
2020: Tu-Tu 29/9 - 6/10 (retail Blizz post)   1/10
2021: Fr-Fr 17/9 - 24/9 (retail Blizz post)  21/9
]] --

---@class QuestieEvent
---@field public private QuestieEventPrivate
local QuestieEvent = QuestieLoader:CreateModule("QuestieEvent")
---@class QuestieEventPrivate
local _QuestieEvent = QuestieEvent.private

QuestieEvent.activeQuests = {}
_QuestieEvent.eventNamesForQuests = {}

---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
---@type QuestieCorrections
local QuestieCorrections = QuestieLoader:ImportModule("QuestieCorrections")
---@type QuestieNPCFixes
local QuestieNPCFixes = QuestieLoader:ImportModule("QuestieNPCFixes")
---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

--- COMPATIBILITY ---
local C_Calendar = QuestieCompat.C_Calendar
local C_DateAndTime = QuestieCompat.C_DateAndTime

local tinsert = table.insert
local _WithinDates, _LoadDarkmoonFaire, _GetDarkmoonFaireLocation, _GetDarkmoonFaireLocationEra, _GetDarkmoonFaireLocationSoD

local DMF_LOCATIONS = {
    NONE = 0,
    MULGORE = 1,
    ELWYNN_FOREST = 2,
}

function QuestieEvent:Load()
    local year = date("%y")

    -- We want to replace the Lunar Festival date with the date that we estimate
    QuestieEvent.eventDates["Lunar Festival"] = QuestieEvent.lunarFestival[year]
    local activeEvents = {}

    local eventCorrections
    if Questie.IsTBC then
        eventCorrections = QuestieEvent.eventDateCorrections["TBC"]
    elseif Questie.IsClassic then
        eventCorrections = QuestieEvent.eventDateCorrections["CLASSIC"]
    else
        eventCorrections = {}
    end

    for eventName,dates in pairs(eventCorrections) do
        if dates then
            QuestieEvent.eventDates[eventName] = dates
        end
    end

    for eventName, eventData in pairs(QuestieEvent.eventDates) do
        local startDay, startMonth = strsplit("/", eventData.startDate)
        local endDay, endMonth = strsplit("/", eventData.endDate)

        startDay = tonumber(startDay)
        startMonth = tonumber(startMonth)
        endDay = tonumber(endDay)
        endMonth = tonumber(endMonth)

        if _WithinDates(startDay, startMonth, endDay, endMonth) and (eventCorrections[eventName] ~= false) then
            print(Questie:Colorize("[Questie]", "yellow"), "|cFF6ce314" .. l10n("The '%s' world event is active!", l10n(eventName)))
            activeEvents[eventName] = true
        end
    end

    for _, questData in pairs(QuestieEvent.eventQuests) do
        local eventName = questData[1]
        local questId = questData[2]
        local startDay, startMonth = nil, nil
        local endDay, endMonth = nil, nil

        if questData[3] and questData[4] then
            startDay, startMonth = strsplit("/", questData[3])
            endDay, endMonth = strsplit("/", questData[4])
            startDay = tonumber(startDay)
            startMonth = tonumber(startMonth)
            endDay = tonumber(endDay)
            endMonth = tonumber(endMonth)
        end

        _QuestieEvent.eventNamesForQuests[questId] = eventName

        if activeEvents[eventName] == true and _WithinDates(startDay, startMonth, endDay, endMonth) then

            if ((not questData[5]) or (Questie.IsClassic and questData[5] == QuestieCorrections.CLASSIC_ONLY)) then
                QuestieCorrections.hiddenQuests[questId] = nil
                QuestieEvent.activeQuests[questId] = true
            end
        end
    end

    -- TODO: Also handle WotLK which has a different starting schedule
    if Questie.IsClassic then
        _LoadDarkmoonFaire()
    end

    -- Clear the quests to save memory
    QuestieEvent.eventQuests = nil
end

---@param dayOfMonth number
---@return boolean
_GetDarkmoonFaireLocation = function()
    if C_Calendar == nil then
        -- This is a band aid fix for private servers which do not support the `C_Calendar` API.
        -- They won't see Darkmoon Faire quests, but that's the price to pay.
        return false
    end

    local currentDate = C_DateAndTime.GetCurrentCalendarTime()

    if Questie.IsSoD then
        return _GetDarkmoonFaireLocationSoD(currentDate)
    else
        return _GetDarkmoonFaireLocationEra(currentDate)
    end
end

_GetDarkmoonFaireLocationEra = function(currentDate)
    local baseInfo = C_Calendar.GetMonthInfo() -- In Era+SoD this returns `GetMinDate` (November 2004)
    -- Calculate the offset in months from GetMinDate to make C_Calendar.GetMonthInfo return the correct month
    local monthOffset = (currentDate.year - baseInfo.year) * 12 + (currentDate.month - baseInfo.month)
    local firstWeekday = C_Calendar.GetMonthInfo(monthOffset).firstWeekday

    local eventLocation = (currentDate.month % 2) == 0 and DMF_LOCATIONS.MULGORE or DMF_LOCATIONS.ELWYNN_FOREST

    local dayOfMonth = currentDate.monthDay
    if firstWeekday == 1 then
        -- The 1st is a Sunday
        if dayOfMonth >= 9 and dayOfMonth < 15 then
            return eventLocation
        end
    elseif firstWeekday == 2 then
        -- The 1st is a Monday
        if dayOfMonth >= 8 and dayOfMonth < 14 then
            return eventLocation
        end
    elseif firstWeekday == 3 then
        -- The 1st is a Tuesday
        if dayOfMonth >= 7 and dayOfMonth < 13 then
            return eventLocation
        end
    elseif firstWeekday == 4 then
        -- The 1st is a Wednesday
        if dayOfMonth >= 6 and dayOfMonth < 12 then
            return eventLocation
        end
    elseif firstWeekday == 5 then
        -- The 1st is a Thursday
        if dayOfMonth >= 5 and dayOfMonth < 11 then
            return eventLocation
        end
    elseif firstWeekday == 6 then
        -- The 1st is a Friday
        if dayOfMonth >= 4 and dayOfMonth < 10 then
            return eventLocation
        end
    elseif firstWeekday == 7 then
        -- The 1st is a Saturday
        if dayOfMonth >= 10 and dayOfMonth < 16 then
            return eventLocation
        end
    end

    return DMF_LOCATIONS.NONE
end

-- DMF in SoD is every second week, starting on the 4th of December 2023
_GetDarkmoonFaireLocationSoD = function(currentDate)
    local initialStartDate = time({year=2023, month=12, day=4, hour=0, min=1}) -- The first time DMF started in SoD
    local initialEndDate = time({year=2023, month=12, day=10, hour=23, min=59}) -- The first time DMF ended in SoD
    currentDate = time({ year = currentDate.year, month = currentDate.month, day = currentDate.monthDay, hour = 0, min = 1 })

    local eventDuration = initialEndDate - initialStartDate
    local timeSinceStart = currentDate - initialStartDate

    local positionInCurrentCycle = timeSinceStart % (eventDuration * 2) -- * 2 because the event repeats every two weeks

    local isEventActive = positionInCurrentCycle < eventDuration

    if (not isEventActive) then
        return DMF_LOCATIONS.NONE
    end

    local weeksSinceStart = math.floor(timeSinceStart / eventDuration)

    if weeksSinceStart % 4 == 0 then
        return DMF_LOCATIONS.MULGORE
    else
        return DMF_LOCATIONS.ELWYNN_FOREST
    end
end

--- https://classic.wowhead.com/guides/classic-darkmoon-faire#darkmoon-faire-location-and-schedule
--- Darkmoon Faire starts its setup the first Friday of the month and will begin the following Monday.
--- The faire ends the sunday after it has begun.
_LoadDarkmoonFaire = function()
    local eventLocation = _GetDarkmoonFaireLocation()
    if (eventLocation == DMF_LOCATIONS.NONE) then
        return
    end

    -- TODO: Also handle Terrokar Forest starting with TBC
    local isInMulgore = eventLocation == DMF_LOCATIONS.MULGORE

    -- The faire is setting up right now or is already up
    local announcingQuestId = 7905 -- Alliance announcement quest
    if isInMulgore then
        announcingQuestId = 7926 -- Horde announcement quest
    end
    QuestieCorrections.hiddenQuests[announcingQuestId] = nil
    QuestieEvent.activeQuests[announcingQuestId] = true

    for _, questData in pairs(QuestieEvent.eventQuests) do
        if questData[1] == "Darkmoon Faire" and ((not questData[5]) or (not Questie.IsSoD) or questData[5] ~= QuestieCorrections.HIDE_SOD) then
            local questId = questData[2]
            QuestieCorrections.hiddenQuests[questId] = nil
            QuestieEvent.activeQuests[questId] = true

            -- Update the NPC spawns based on the place of the faire
            for id, data in pairs(QuestieNPCFixes:LoadDarkmoonFixes(isInMulgore)) do
                QuestieDB.npcDataOverrides[id] = data
            end
        end
    end

    print(Questie:Colorize("[Questie]", "yellow"), "|cFF6ce314" .. l10n("The '%s' world event is active!", l10n("Darkmoon Faire")))
end

--- Checks wheather the current date is within the given date range
---@param startDay number?
---@param startMonth number?
---@param endDay number?
---@param endMonth number?
---@return boolean @True if the current date is between the given, false otherwise
_WithinDates = function(startDay, startMonth, endDay, endMonth)
    if (not startDay) and (not startMonth) and (not endDay) and (not endMonth) then
        return true
    end
    local date = (C_DateAndTime.GetTodaysDate or C_DateAndTime.GetCurrentCalendarTime)()
    local day = date.day or date.monthDay
    local month = date.month
    if (startMonth <= endMonth) -- Event start and end during same year
        and ((month < startMonth) or (month > endMonth)) -- Too early or late in the year
        or ((month < startMonth) and (month > endMonth)) -- Event span across year change
        or (month == startMonth and day < startDay) -- Too early in the correct month
        or (month == endMonth and day > endDay) then -- Too late in the correct month
        return false
    else
        return true
    end
end

---@return string
function QuestieEvent:GetEventNameFor(questId)
    return _QuestieEvent.eventNamesForQuests[questId] or ""
end

function QuestieEvent:IsEventQuest(questId)
    return _QuestieEvent.eventNamesForQuests[questId] ~= nil
end

-- EUROPEAN FORMAT! NO FUCKING AMERICAN SHIDAZZLE FORMAT!
QuestieEvent.eventDates = {
    ["Lunar Festival"] = { -- WARNING THIS DATE VARIES!!!!
        startDate = "3/2",
        endDate = "24/2"
    },
    ["Love is in the Air"] = {startDate = "04/2", endDate = "18/2"},
    ["Noblegarden"] = { -- WARNING THIS DATE VARIES!!!!
        startDate = "20/4",
        endDate = "27/4"
    },
    ["Children's Week"] = {startDate = "29/4", endDate = "6/5"},
    ["Midsummer"] = {startDate = "21/6", endDate = "4/7"},
    ["Brewfest"] = {startDate = "20/9", endDate = "5/10"}, -- TODO: This might be different (retail date)
    ["Harvest Festival"] = { -- WARNING THIS DATE VARIES!!!!
        startDate = "26/9",
        endDate = "2/10"
    },
    ["Pilgrim's Bounty"] = {
        startDate = "21/11",
        endDate = "27/11"
    },
    ["Hallow's End"] = {startDate = "18/10", endDate = "31/10"},
    ["Winter Veil"] = {startDate = "15/12", endDate = "1/1"}
}

-- ["EventName"] = false -> event doesn't exists in expansion
-- ["EventName"] = {startDate = "12/3", endDate = "12/3"} -> change dates for the expansion
QuestieEvent.eventDateCorrections = {
    ["CLASSIC"] = {
        ["Brewfest"] = false,
        ["Pilgrim's Bounty"] = false,
        ["Love is in the Air"] = {startDate = "11/2", endDate = "16/2"},
    },
    ["TBC"] = {
        ["Harvest Festival"] = false,
    },
}

QuestieEvent.lunarFestival = {
    ["25"] = {startDate = "2/2", endDate = "16/2"},
    ["26"] = {startDate = "2/2", endDate = "16/2"},
    -- Below are estimates
    ["27"] = {startDate = "7/2", endDate = "21/2"},
    ["28"] = {startDate = "27/1", endDate = "10/2"}
}

-- This variable will be cleared at the end of the load, do not use, use QuestieEvent.activeQuests.
QuestieEvent.eventQuests = {}

tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8619}) -- Morndeep the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8635}) -- Splitrock the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8636}) -- Rumblerock the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8642}) -- Silvervein the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8643}) -- Highpeak the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8644}) -- Stonefort the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8645}) -- Obsidian the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8646}) -- Hammershout the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8647}) -- Bellowrage the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8648}) -- Darkcore the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8649}) -- Stormbrow the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8650}) -- Snowcrown the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8651}) -- Ironband the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8652}) -- Graveborn the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8653}) -- Goldwell the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8654}) -- Primestone the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8670}) -- Runetotem the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8671}) -- Ragetotem the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8672}) -- Stonespire the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8673}) -- Bloodhoof the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8674}) -- Winterhoof the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8675}) -- Skychaser the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8676}) -- Wildmane the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8677}) -- Darkhorn the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8678}) -- Proudhorn the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8679}) -- Grimtotem the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8680}) -- Windtotem the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8681}) -- Thunderhorn the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8682}) -- Skyseer the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8683}) -- Dawnstrider the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8684}) -- Dreamseer the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8685}) -- Mistwalker the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8686}) -- High Mountain the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8688}) -- Windrun the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8713}) -- Starsong the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8714}) -- Moonstrike the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8715}) -- Bladeleaf the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8716}) -- Starglade the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8717}) -- Moonwarden the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8718}) -- Bladeswift the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8719}) -- Bladesing the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8720}) -- Skygleam the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8721}) -- Starweave the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8722}) -- Meadowrun the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8723}) -- Nightwind the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8724}) -- Morningdew the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8725}) -- Riversong the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8726}) -- Brightspear the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8727}) -- Farwhisper the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8862, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Elune's Candle
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8863, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Festival Dumplings
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8864, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Festive Lunar Dresses
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8865, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Festive Lunar Pant Suits
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8866}) -- Bronzebeard the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8867}) -- Lunar Fireworks
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8868}) -- Elune's Blessing
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8870}) -- The Lunar Festival
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8871}) -- The Lunar Festival
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8872}) -- The Lunar Festival
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8873}) -- The Lunar Festival
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8874}) -- The Lunar Festival
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8875}) -- The Lunar Festival
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8876, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Small Rockets
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8877, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Firework Launcher
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8878, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Festive Recipes
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8879, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Large Rockets
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8880, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Cluster Rockets
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8881, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Large Cluster Rockets
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8882, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Cluster Launcher
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 8883}) -- Valadar Starsong
-- Northrend Elders
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13012}) -- Sardis the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13013}) -- Beldak the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13014}) -- Morthie the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13015}) -- Fargal the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13016}) -- Northal the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13017}) -- Jarten the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13018}) -- Sandrene the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13019}) -- Thoim the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13020}) -- Stonebeard the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13021}) -- Igasho the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13022}) -- Nurgen the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13023}) -- Kilias the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13024}) -- Wanikaya the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13025}) -- Lunaro the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13026}) -- Bluewolf the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13027}) -- Tauros the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13028}) -- Graymane the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13029}) -- Pamuya the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13030}) -- Whurain the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13031}) -- Skywarden the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13032}) -- Muraco the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13033}) -- Arp the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13065}) -- Ohanzee the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13066}) -- Yurauk the Elder
tinsert(QuestieEvent.eventQuests, {"Lunar Festival", 13067}) -- Chogan'gada the Elder

tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8897}) -- Dearest Colara
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8898}) -- Dearest Colara
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8899}) -- Dearest Colara
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8900}) -- Dearest Elenia
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8901}) -- Dearest Elenia
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8902}) -- Dearest Elenia
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8903}) -- Dangerous Love
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8904}) -- Dangerous Love
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8979}) -- Fenstad's Hunch
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8980}) -- Zinge's Assessment
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8981, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Gift Giving
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8982}) -- Tracing the Source
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8983}) -- Tracing the Source
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8984}) -- The Source Revealed
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 8993, nil, nil, QuestieCorrections.CLASSIC_ONLY}) -- Gift Giving
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 9024}) -- Aristan's Hunch
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 9025}) -- Morgan's Discovery
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 9026}) -- Tracing the Source
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 9027}) -- Tracing the Source
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 9028}) -- The Source Revealed
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 9029}) -- A Bubbling Cauldron

tinsert(QuestieEvent.eventQuests, {"Children's Week", 171}) -- A Warden of the Alliance
tinsert(QuestieEvent.eventQuests, {"Children's Week", 172}) -- Children's Week
tinsert(QuestieEvent.eventQuests, {"Children's Week", 558}) -- Jaina's Autograph
tinsert(QuestieEvent.eventQuests, {"Children's Week", 910}) -- Down at the Docks
tinsert(QuestieEvent.eventQuests, {"Children's Week", 911}) -- Gateway to the Frontier
tinsert(QuestieEvent.eventQuests, {"Children's Week", 915}) -- You Scream, I Scream...
tinsert(QuestieEvent.eventQuests, {"Children's Week", 925}) -- Cairne's Hoofprint
tinsert(QuestieEvent.eventQuests, {"Children's Week", 1468}) -- Children's Week
tinsert(QuestieEvent.eventQuests, {"Children's Week", 1479}) -- The Bough of the Eternals
tinsert(QuestieEvent.eventQuests, {"Children's Week", 1558}) -- The Stonewrought Dam
tinsert(QuestieEvent.eventQuests, {"Children's Week", 1687}) -- Spooky Lighthouse
tinsert(QuestieEvent.eventQuests, {"Children's Week", 1800}) -- Lordaeron Throne Room
tinsert(QuestieEvent.eventQuests, {"Children's Week", 4822}) -- You Scream, I Scream...
tinsert(QuestieEvent.eventQuests, {"Children's Week", 5502}) -- A Warden of the Horde

tinsert(QuestieEvent.eventQuests, {"Harvest Festival", 8149}) -- Honoring a Hero
tinsert(QuestieEvent.eventQuests, {"Harvest Festival", 8150}) -- Honoring a Hero

tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8373}) -- The Power of Pine
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 1658}) -- Crashing the Wickerman Festival
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8311}) -- Hallow's End Treats for Jesper!
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8312}) -- Hallow's End Treats for Spoops!
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8322}) -- Rotten Eggs
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 1657}) -- Stinking Up Southshore
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8409}) -- Ruined Kegs
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8357}) -- Dancing for Marzipan
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8355}) -- Incoming Gumdrop
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8356}) -- Flexing for Nougat
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8358}) -- Incoming Gumdrop
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8353}) -- Chicken Clucking for a Mint
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8359}) -- Flexing for Nougat
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8354}) -- Chicken Clucking for a Mint
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 8360}) -- Dancing for Marzipan

tinsert(QuestieEvent.eventQuests, {"Winter Veil", 6961}) -- Great-father Winter is Here!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7021}) -- Great-father Winter is Here!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7022}) -- Greatfather Winter is Here!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7023}) -- Greatfather Winter is Here!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7024}) -- Great-father Winter is Here!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 6962}) -- Treats for Great-father Winter
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7025}) -- Treats for Greatfather Winter
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7043}) -- You're a Mean One...
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 6983}) -- You're a Mean One...
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 6984}) -- A Smokywood Pastures' Thank You!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7045}) -- A Smokywood Pastures' Thank You!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7063}) -- The Feast of Winter Veil
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7061}) -- The Feast of Winter Veil
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 6963}) -- Stolen Winter Veil Treats
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7042}) -- Stolen Winter Veil Treats
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 7062}) -- The Reason for the Season
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8763}) -- The Hero of the Day
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8799}) -- The Hero of the Day
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 6964}) -- The Reason for the Season
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8762}) -- Metzen the Reindeer
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8746}) -- Metzen the Reindeer
-- New SoD quests
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 79482}) -- Stolen Winter Veil Treats
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 79483}) -- Stolen Winter Veil Treats
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 79484}) -- You're a Mean One...
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 79485}) -- You're a Mean One...
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 79486}) -- A Smokywood Pastures' Thank You!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 79487}) -- A Smokywood Pastures' Thank You!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 79492}) -- Metzen the Reindeer
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 79495}) -- Metzen the Reindeer
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8744, "25/12", "2/1"}) -- A Carefully Wrapped Present
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8767, "25/12", "2/1"}) -- A Gently Shaken Gift
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8768, "25/12", "2/1"}) -- A Gaily Wrapped Present
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8769, "25/12", "2/1"}) -- A Ticking Present
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8788, "25/12", "2/1"}) -- A Gently Shaken Gift
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8803, "25/12", "2/1"}) -- A Festive Gift
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8827, "25/12", "2/1"}) -- Winter's Presents
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8828, "25/12", "2/1"}) -- Winter's Presents
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8860, "31/12", "1/1"}) -- New Year Celebrations!
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 8861, "31/12", "1/1"}) -- New Year Celebrations!

tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7902}) -- Vibrant Plumes
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7903}) -- Evil Bat Eyes
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 8222}) -- Glowing Scorpid Blood
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7901, nil, nil, QuestieCorrections.HIDE_SOD}) -- Soft Bushy Tails
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7899, nil, nil, QuestieCorrections.HIDE_SOD}) -- Small Furry Paws
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7940}) -- 1200 Tickets - Orb of the Darkmoon
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7900, nil, nil, QuestieCorrections.HIDE_SOD}) -- Torn Bear Pelts
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7907}) -- Darkmoon Beast Deck
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7927}) -- Darkmoon Portals Deck
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7929}) -- Darkmoon Elementals Deck
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7928}) -- Darkmoon Warlords Deck
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7946, nil, nil, QuestieCorrections.HIDE_SOD}) -- Spawn of Jubjub
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 8223}) -- More Glowing Scorpid Blood
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7934}) -- 50 Tickets - Darkmoon Storage Box
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7981}) -- 1200 Tickets - Amulet of the Darkmoon
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7943}) -- More Bat Eyes
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7894, nil, nil, QuestieCorrections.HIDE_SOD}) -- Copper Modulator
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7933}) -- 40 Tickets - Greater Darkmoon Prize
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7898}) -- Thorium Widget
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7885}) -- Armor Kits
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7942}) -- More Thorium Widgets
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7883, nil, nil, QuestieCorrections.HIDE_SOD}) -- The World's Largest Gnome!
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7892}) -- Big Black Mace
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7937}) -- Your Fortune Awaits You...
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7939}) -- More Dense Grinding Stones
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7893}) -- Rituals of Strength
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7891, nil, nil, QuestieCorrections.HIDE_SOD}) -- Green Iron Bracers
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7896, nil, nil, QuestieCorrections.HIDE_SOD}) -- Green Fireworks
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7884}) -- Crocolisk Boy and the Bearded Murloc
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7882, nil, nil, QuestieCorrections.HIDE_SOD}) -- Carnival Jerkins
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7897}) -- Mechanical Repair Kits
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7895, nil, nil, QuestieCorrections.HIDE_SOD}) -- Whirring Bronze Gizmo
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7941}) -- More Armor Kits
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7881, nil, nil, QuestieCorrections.HIDE_SOD}) -- Carnival Boots
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7890, nil, nil, QuestieCorrections.HIDE_SOD}) -- Heavy Grinding Stone
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7889, nil, nil, QuestieCorrections.HIDE_SOD}) -- Coarse Weightstone
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7945}) -- Your Fortune Awaits You...
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7935}) -- 10 Tickets - Last Month's Mutton
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7938}) -- Your Fortune Awaits You...
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7944}) -- Your Fortune Awaits You...
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7932}) -- 12 Tickets - Lesser Darkmoon Prize
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7930}) -- 5 Tickets - Darkmoon Flower
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7931}) -- 5 Tickets - Minor Darkmoon Prize
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 7936}) -- 50 Tickets - Last Year's Mutton
-- New SoD quests
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 79588}) -- Small Furry Paws
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 79589}) -- Torn Bear Pelts
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 79590}) -- Heavy Grinding Stone
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 79591}) -- Whirring Bronze Gizmo
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 79592}) -- Carnival Jerkins
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 79593}) -- Coarse Weightstone
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 79594}) -- Copper Modulator
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 79595}) -- Carnival Boots
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 80421}) -- Green Iron Bracers
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 80422}) -- Green Fireworks
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 80423}) -- The World's Largest Gnome!

-- New TBC event quests

tinsert(QuestieEvent.eventQuests, {"Children's Week", 10942}) -- Children's Week
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10943}) -- Children's Week
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10945}) -- Hch'uu and the Mushroom People
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10950}) -- Auchindoun and the Ring of Observance
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10951}) -- A Trip to the Dark Portal
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10952}) -- A Trip to the Dark Portal
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10953}) -- Visit the Throne of the Elements
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10954}) -- Jheel is at Aeris Landing!
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10956}) -- The Seat of the Naaru
-- tinsert(QuestieEvent.eventQuests, {"Children's Week", 10960}) -- When I Grow Up... -- Not in the game
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10962}) -- Time to Visit the Caverns
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10963}) -- Time to Visit the Caverns
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10966}) -- Back to the Orphanage
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10967}) -- Back to the Orphanage
tinsert(QuestieEvent.eventQuests, {"Children's Week", 10968}) -- Call on the Farseer
tinsert(QuestieEvent.eventQuests, {"Children's Week", 11975}) -- Now, When I Grow Up...

tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 9249}) -- 40 Tickets - Schematic: Steam Tonk Controller
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 10938}) -- Darkmoon Blessings Deck
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 10939}) -- Darkmoon Storms Deck
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 10940}) -- Darkmoon Furies Deck
tinsert(QuestieEvent.eventQuests, {"Darkmoon Faire", 10941}) -- Darkmoon Lunacy Deck

tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11450}) -- Fire Training
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11356}) -- Costumed Orphan Matron
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11357}) -- Masked Orphan Matron
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11131}) -- Stop the Fires!
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11135, nil, nil, QuestieCorrections.TBC_ONLY}) -- The Headless Horseman
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11220, nil, nil, QuestieCorrections.TBC_ONLY}) -- The Headless Horseman
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11219}) -- Stop the Fires!
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11361}) -- Fire Training
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11360}) -- Fire Brigade Practice
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11449}) -- Fire Training
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11440}) -- Fire Brigade Practice
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11439}) -- Fire Brigade Practice
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12133}) -- Smash the Pumpkin
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12135}) -- Let the Fires Come!
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12139}) -- Let the Fires Come!
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12155}) -- Smash the Pumpkin
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12286}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12331}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12332}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12333}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12334}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12335}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12336}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12337}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12338}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12339}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12340}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12341}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12342}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12343}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12344}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12345}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12346}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12347}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12348}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12349}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12350}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12351}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12352}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12353}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12354}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12355}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12356}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12357}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12358}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12359}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12360}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12361}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12362}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12363}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12364}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12365}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12366}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12367}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12368}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12369}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12370}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12371}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12373}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12374}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12375}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12376}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12377}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12378}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12379}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12380}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12381}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12382}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12383}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12384}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12385}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12386}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12387}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12388}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12389}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12390}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12391}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12392}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12393}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12394}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12395}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12396}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12397}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12398}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12399}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12400}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12401}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12402}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12403}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12404}) -- Candy Bucket
--tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12405}) -- Candy Bucket -- doesn't exist
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12406}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12407}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12408}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12409}) -- Candy Bucket
--tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12410}) -- Candy Bucket -- doesn't exist
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11392, nil, nil, QuestieCorrections.TBC_ONLY}) -- Call the Headless Horseman
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11401, nil, nil, QuestieCorrections.TBC_ONLY}) -- Call the Headless Horseman
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11403}) -- Free at Last!
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11242}) -- Free at Last!
--tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11404}) -- Call the Headless Horseman
--tinsert(QuestieEvent.eventQuests, {"Hallow's End", 11405}) -- Call the Headless Horseman

tinsert(QuestieEvent.eventQuests, {"Brewfest", 11127}) -- <NYI>Thunderbrew Secrets
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12022}) -- Chug and Chuck!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11122}) -- There and Back Again
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11412}) -- There and Back Again
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11117}) -- Catch the Wild Wolpertinger!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11431}) -- Catch the Wild Wolpertinger!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11318}) -- Now This is Ram Racing... Almost.
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11409}) -- Now This is Ram Racing... Almost.
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11438}) -- [PH] Beer Garden B
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12020}) -- This One Time, When I Was Drunk...
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12192}) -- This One Time, When I Was Drunk...
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11437}) -- [PH] Beer Garden A
--tinsert(QuestieEvent.eventQuests, {"Brewfest", 11454}) -- Seek the Saboteurs
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12420}) -- Brew of the Month Club
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12421}) -- Brew of the Month Club
--tinsert(QuestieEvent.eventQuests, {"Brewfest", 12306}) -- Brew of the Month Club
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11120}) -- Pink Elekks On Parade
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11400}) -- Brewfest Riding Rams
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11442}) -- Welcome to Brewfest!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11447}) -- Welcome to Brewfest!
--tinsert(QuestieEvent.eventQuests, {"Brewfest", 12278}) -- Brew of the Month Club
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11118}) -- Pink Elekks On Parade
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11320}) -- [NYI] Now this is Ram Racing... Almost.
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11441}) -- Brewfest!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11446}) -- Brewfest!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12062}) -- Insult Coren Direbrew
--tinsert(QuestieEvent.eventQuests, {"Brewfest", 12194}) -- Say, There Wouldn't Happen to be a Souvenir This Year, Would There?
--tinsert(QuestieEvent.eventQuests, {"Brewfest", 12193}) -- Say, There Wouldn't Happen to be a Souvenir This Year, Would There?
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12191}) -- Chug and Chuck!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11293}) -- Bark for the Barleybrews!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11294}) -- Bark for the Thunderbrews!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11407}) -- Bark for Drohn's Distillery!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 11408}) -- Bark for T'chali's Voodoo Brewery!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12318}) -- Save Brewfest!
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12491}) -- Direbrew's Dire Brew
tinsert(QuestieEvent.eventQuests, {"Brewfest", 12492}) -- Direbrew's Dire Brew


tinsert(QuestieEvent.eventQuests, {"Midsummer", 9324}) -- Stealing Orgrimmar's Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 9325}) -- Stealing Thunder Bluff's Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 9326}) -- Stealing the Undercity's Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 9330}) -- Stealing Stormwind's Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 9331}) -- Stealing Ironforge's Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 9332}) -- Stealing Darnassus's Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 9339}) -- A Thief's Reward
tinsert(QuestieEvent.eventQuests, {"Midsummer", 9365}) -- A Thief's Reward

-- Removed in TBC
--tinsert(QuestieEvent.eventQuests, {"Midsummer", 9388}) -- Flickering Flames in Kalimdor
--tinsert(QuestieEvent.eventQuests, {"Midsummer", 9389}) -- Flickering Flames in the Eastern Kingdoms
--tinsert(QuestieEvent.eventQuests, {"Midsummer", 9319}) -- A Light in Dark Places
--tinsert(QuestieEvent.eventQuests, {"Midsummer", 9386}) -- A Light in Dark Places
--tinsert(QuestieEvent.eventQuests, {"Midsummer", 9367}) -- The Festival of Fire
--tinsert(QuestieEvent.eventQuests, {"Midsummer", 9368}) -- The Festival of Fire
--tinsert(QuestieEvent.eventQuests, {"Midsummer", 9322}) -- Wild Fires in Kalimdor
--tinsert(QuestieEvent.eventQuests, {"Midsummer", 9323}) -- Wild Fires in the Eastern Kingdoms

tinsert(QuestieEvent.eventQuests, {"Midsummer", 11580}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11581}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11583}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11584}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11657}) -- Torch Catching
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11691}) -- Summon Ahune
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11696}) -- Ahune is Here!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11731}) -- Torch Tossing
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11732}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11734}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11735}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11736}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11737}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11738}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11739}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11740}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11741}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11742}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11743}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11744}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11745}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11746}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11747}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11748}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11749}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11750}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11751}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11752}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11753}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11754}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11755}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11756}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11757}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11758}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11759}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11760}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11761}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11762}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11763}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11764}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11765}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11766}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11767}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11768}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11769}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11770}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11771}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11772}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11773}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11774}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11775}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11776}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11777}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11778}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11779}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11780}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11781}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11782}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11783}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11784}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11785}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11786}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11787}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11799}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11800}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11801}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11802}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11803}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11804}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11805}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11806}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11807}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11808}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11809}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11810}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11811}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11812}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11813}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11814}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11815}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11816}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11817}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11818}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11819}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11820}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11821}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11822}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11823}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11824}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11825}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11826}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11827}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11828}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11829}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11830}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11831}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11832}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11833}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11834}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11835}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11836}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11837}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11838}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11839}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11840}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11841}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11842}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11843}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11844}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11845}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11846}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11847}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11848}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11849}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11850}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11851}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11852}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11853}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11854}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11855}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11856}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11857}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11858}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11859}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11860}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11861}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11862}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11863}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11882}) -- Playing with Fire
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11886}) -- Unusual Activity
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11891}) -- An Innocent Disguise
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11915}) -- Playing with Fire
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11917}) -- Striking Back (level 22)
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11921}) -- Midsummer
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11922}) -- Midsummer
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11923}) -- Torch Catching
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11924}) -- More Torch Catching
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11925}) -- More Torch Catching
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11926}) -- Midsummer
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11933}) -- Stealing the Exodar's Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11935}) -- Stealing Silvermoon's Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11947}) -- Striking Back (level 32)
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11948}) -- Striking Back (level 43)
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11952}) -- Striking Back (level 51)
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11953}) -- Striking Back (level 60)
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11954}) -- Striking Back (level 67)
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11955}) -- Ahune, the Frost Lord
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11972}) -- Shards of Ahune
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11964}) -- Incense for the Summer Scorchlings
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11966}) -- Incense for the Festival Scorchlings
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11970}) -- The Master of Summer Lore
tinsert(QuestieEvent.eventQuests, {"Midsummer", 11971}) -- The Spinner of Summer Tales
tinsert(QuestieEvent.eventQuests, {"Midsummer", 12012}) -- Inform the Elder

tinsert(QuestieEvent.eventQuests, {"Winter Veil", 11528, "25/12", "2/1"}) -- A Winter Veil Gift
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 13203, "25/12", "2/1"}) -- A Winter Veil Gift
tinsert(QuestieEvent.eventQuests, {"Winter Veil", 13966, "25/12", "2/1"}) -- A Winter Veil Gift

--- Wotlk event quests

tinsert(QuestieEvent.eventQuests, {"Noblegarden", 13483}) -- Spring Gatherers
tinsert(QuestieEvent.eventQuests, {"Noblegarden", 13484}) -- Spring Collectors
tinsert(QuestieEvent.eventQuests, {"Noblegarden", 13479}) -- The Great Egg Hunt
tinsert(QuestieEvent.eventQuests, {"Noblegarden", 13480}) -- The Great Egg Hunt
tinsert(QuestieEvent.eventQuests, {"Noblegarden", 13502}) -- A Tisket, a Tasket, a Noblegarden Basket
tinsert(QuestieEvent.eventQuests, {"Noblegarden", 13503}) -- A Tisket, a Tasket, a Noblegarden Basket

tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 14483}) -- Something is in the Air (and it Ain't Love)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 14488}) -- You've Been Served
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24597}) -- A Gift for the King of Stormwind
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24609}) -- A Gift for the Lord of Ironforge
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24610}) -- A Gift for the High Priestess of Elune
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24611}) -- A Gift for the Prophet
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24612}) -- A Gift for the Warchief
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24613}) -- A Gift for the Banshee Queen
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24614}) -- A Gift for the High Chieftain
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24615}) -- A Gift for the Regent Lord of Quel'Thalas
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24629}) -- A Perfect Puff of Perfume
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24635}) -- A Cloudlet of Classy Cologne
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24636}) -- Bonbon Blitz
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24536}) -- Something Stinks
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24655}) -- Something Stinks
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24541}) -- Pilfering Perfume
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24656}) -- Pilfering Perfume
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24745}) -- Something is in the Air (and it Ain't Love)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24804}) -- Uncommon Scents
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24805}) -- Uncommon Scents

tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24576}) -- A Friendly Chat...
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24657}) -- A Friendly Chat...

-- These seem to be breadcrumbs to "You've Been Served" (14488) but aren't available
-- Might either not be in game at all or guarded behind finishing one of the two "A Friendly Chat..." quests above
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24792}) -- Man on the Inside
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24793}) -- Man on the Inside

tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24848}) -- Fireworks At The Gilded Rose
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24849}) -- Hot On The Trail
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24850}) -- Snivel's Sweetheart
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24851}) -- Hot On The Trail

-- These "Crushing the Crown" quests are dailies, handed out based on the player's current level.
-- The Durotar + Elwynn quests are available at level 5, with each successive quest being available
-- at 14, 23, 32, 41, 51, 61, and 71, respectively. They are exclusive to each other; once you hit 14,
-- you can no longer pick up the level 5 quest. However, since we have no way of filtering quests based
-- on a "maximum" level, we simply hide all of the higher level ones, which will be picked up automatically
-- instead of the level 5 one. Users can only tell the difference if they're watching quest IDs.
-- TODO: If we implement maxLevel, these hacky workarounds should be implemented properly.
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24638}) -- Crushing the Crown (Durotar)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24645}) -- Crushing the Crown (Ambermill)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24647}) -- Crushing the Crown (Hillsbrad H)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24648}) -- Crushing the Crown (Theramore H)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24649}) -- Crushing the Crown (Aerie Peak H)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24650}) -- Crushing the Crown (Everlook H)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24651}) -- Crushing the Crown (Shattrath H)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24652}) -- Crushing the Crown (Crystalsong H)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24658}) -- Crushing the Crown (Elwynn)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24659}) -- Crushing the Crown (Darkshore)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24660}) -- Crushing the Crown (Hillsbrad A)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24662}) -- Crushing the Crown (Theramore A)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24663}) -- Crushing the Crown (Aerie Peak A)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24664}) -- Crushing the Crown (Everlook A)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24665}) -- Crushing the Crown (Shattrath A)
tinsert(QuestieEvent.eventQuests, {"Love is in the Air", 24666}) -- Crushing the Crown (Crystalsong A)

tinsert(QuestieEvent.eventQuests, {"Children's Week", 13926}) -- Little Orphan Roo Of The Oracles
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13927}) -- Little Orphan Kekek Of The Wolvar
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13929}) -- The Biggest Tree Ever!
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13930}) -- Home Of The Bear-Men
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13933}) -- The Bronze Dragonshrine
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13934}) -- The Bronze Dragonshrine
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13937}) -- A Trip To The Wonderworks
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13938}) -- A Visit To The Wonderworks
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13950}) -- Playmates!
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13951}) -- Playmates!
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13954}) -- The Dragon Queen
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13955}) -- The Dragon Queen
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13956}) -- Meeting a Great One
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13957}) -- The Mighty Hemet Nesingwary
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13959}) -- Back To The Orphanage
tinsert(QuestieEvent.eventQuests, {"Children's Week", 13960}) -- Back To The Orphanage

tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12940}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12941}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12944}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12945}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12946}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12947}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 12950}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13433}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13434}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13435}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13436}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13437}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13438}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13439}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13448}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13452}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13456}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13459}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13460}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13461}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13462}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13463}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13464}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13465}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13466}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13467}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13468}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13469}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13470}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13471}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13472}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13473}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13474}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13501}) -- Candy Bucket
tinsert(QuestieEvent.eventQuests, {"Hallow's End", 13548}) -- Candy Bucket

--tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14036}) -- Pilgrim's Bounty
--tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14022}) -- Pilgrim's Bounty
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14023}) -- Spice Bread Stuffing
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14024}) -- Pumpkin Pie
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14028}) -- Cranberry Chutney
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14030}) -- They're Ravenous In Darnassus
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14033}) -- Candied Sweet Potatoes
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14035}) -- Slow-roasted Turkey
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14037}) -- Spice Bread Stuffing
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14040}) -- Pumpkin Pie
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14041}) -- Cranberry Chutney
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14043}) -- Candied Sweet Potatoes
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14044}) -- Undersupplied in the Undercity
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14047}) -- Slow-roasted Turkey
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14048}) -- Can't Get Enough Turkey
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14051}) -- Don't Forget The Stuffing
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14053}) -- We're Out of Cranberry Chutney Again?
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14054}) -- Easy As Pie
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14055}) -- She Says Potato
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14058}) -- She Says Potato
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14059}) -- We're Out of Cranberry Chutney Again?
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14060}) -- Easy As Pie
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14061}) -- Can't Get Enough Turkey
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14062}) -- Don't Forget The Stuffing
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14064}) -- Sharing a Bountiful Feast
tinsert(QuestieEvent.eventQuests, {"Pilgrim's Bounty", 14065}) -- Sharing a Bountiful Feast

tinsert(QuestieEvent.eventQuests, {"Brewfest", 13931}) -- Another Year, Another Souvenir. -- Doesn't seem to be in the game
tinsert(QuestieEvent.eventQuests, {"Brewfest", 13932}) -- Another Year, Another Souvenir. -- Doesn't seem to be in the game

tinsert(QuestieEvent.eventQuests, {"Midsummer", 13440}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13441}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13442}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13443}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13444}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13445}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13446}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13447}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13449}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13450}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13451}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13453}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13454}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13455}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13457}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13458}) -- Desecrate this Fire!
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13485}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13486}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13487}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13488}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13489}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13490}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13491}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13492}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13493}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13494}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13495}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13496}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13497}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13498}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13499}) -- Honor the Flame
tinsert(QuestieEvent.eventQuests, {"Midsummer", 13500}) -- Honor the Flame
