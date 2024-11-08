local WatchFrame_Update = QuestWatch_Update or WatchFrame_Update

---@class Hooks
local Hooks = QuestieLoader:CreateModule("Hooks")

---@type QuestieTracker
local QuestieTracker = QuestieLoader:ImportModule("QuestieTracker")
---@type QuestieLink
local QuestieLink = QuestieLoader:ImportModule("QuestieLink")

--- COMPATIBILITY ---
local GetQuestLogTitle = QuestieCompat.GetQuestLogTitle
local GetQuestIDFromLogIndex = QuestieCompat.GetQuestIDFromLogIndex

function Hooks:HookQuestLogTitle()
    Questie:Debug(Questie.DEBUG_DEVELOP, "[Hooks] Hooking Quest Log Title")
    local baseQLTB_OnClick = QuestLogTitleButton_OnClick

    -- We can not use hooksecurefunc because this needs to be a pre-hook to work properly unfortunately
    QuestLogTitleButton_OnClick = function(self, button)
        if (not self) or self.isHeader or (not IsShiftKeyDown()) then
            baseQLTB_OnClick(self, button)
            return
        end

        local questLogLineIndex
        if Questie.IsWotlk or QuestieCompat.Is335 then
            -- With Wotlk the offset is no longer required cause the API already hands the correct index
            questLogLineIndex = self:GetID()
        else
            questLogLineIndex = self:GetID() + FauxScrollFrame_GetOffset(QuestLogListScrollFrame)
        end

        if (IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow()) then
            local title, level, _, _, _, _, _, questId = GetQuestLogTitle(questLogLineIndex)
            ChatEdit_InsertLink(QuestieLink:GetQuestLinkString(level, title, questId))
        else
            -- only call if we actually want to fix this quest (normal quests already call AQW_insert)
            if Questie.db.profile.trackerEnabled and GetNumQuestLeaderBoards(questLogLineIndex) == 0 and (not IsQuestWatched(questLogLineIndex)) then
                QuestieTracker:AQW_Insert(questLogLineIndex, QUEST_WATCH_NO_EXPIRE)
                WatchFrame_Update()
                QuestLog_SetSelection(questLogLineIndex)
                QuestLog_Update()
            else
                baseQLTB_OnClick(self, button)
            end
        end
    end
end
