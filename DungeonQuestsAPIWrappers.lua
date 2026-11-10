DungeonQuests = {}

function DungeonQuests:GetQuestTitle(questID)
    if(C_QuestLog.GetQuestInfo ~= nil) then -- Classic Era
        return C_QuestLog.GetQuestInfo(questID)
    elseif(C_QuestLog.GetTitleForQuestID ~= nil) then -- Forever
        return C_QuestLog.GetTitleForQuestID(questID)
    else
        return "";
    end
end

function DungeonQuests:IsQuestCompleted(questID)

	if(C_QuestLog.IsQuestFlaggedCompleted ~= nil) then
		return C_QuestLog.IsQuestFlaggedCompleted(questID)
	else
		return false;
    end
end

function DungeonQuests:IsQuestReadyForTurnIn(questID)
	if(IsQuestComplete ~= nil) then -- Classic Era
		return IsQuestComplete(questID)
	elseif(C_QuestLog.IsComplete ~= nil) then -- Forever
		return C_QuestLog.IsComplete(questID)
	else
		return false;
    end
end

function DungeonQuests:IsQuestActive(questID)

    if(GetQuestLogIndexByID ~= nil) then -- Classic Era
        return GetQuestLogIndexByID(questID) or 0 > 0
    elseif(C_QuestLog.GetLogIndexForQuestID ~= nil) then -- Forever
        return C_QuestLog.GetLogIndexForQuestID(questID) or 0 > 0
    else
        return false;
    end
end

function DungeonQuests:IsQuestTrivial(playerLevel, questLevel)
    local threshold
    if(GetQuestGreenRange ~= nil) then -- Classic Era
        threshold = GetQuestGreenRange()
    elseif(UnitQuestTrivialLevelRange ~= nil) then -- Forever
        threshold = UnitQuestTrivialLevelRange("player")
    else
        threshold = 0
    end
    return (playerLevel - questLevel >= threshold)
end
