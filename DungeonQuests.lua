function DungeonQuests:OnLoad()
	SLASH_DUNGEONQUESTS1 = "/dungeonquests";
	SLASH_DUNGEONQUESTS1 = "/dq";
	SlashCmdList["DUNGEONQUESTS"] = function(msg) DungeonQuests:HandleSlashCommand(msg) end

	DungeonQuestsFrame:RegisterEvent("PLAYER_LOGIN")
	DungeonQuestsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	DungeonQuestsFrame:RegisterEvent("ADDON_LOADED")
end


function DungeonQuests:OnEvent(self, event, ...)
	local arg1, arg2, arg3, arg4 = ...
	if event == "ADDON_LOADED" and arg1 == "DungeonQuests" then
		DungeonQuestsFrame:UnregisterEvent("ADDON_LOADED");
	elseif event == "PLAYER_LOGIN" then
		DungeonQuestsFrame:UnregisterEvent("PLAYER_LOGIN");
		DungeonQuests:LoadPlayerData();
		DungeonQuests:LoadSavedData();
		DungeonQuests:LoadQuestData();
		DungeonQuests:PrimeQuestNamesCache();
		DungeonQuests:Announce();
	elseif event == "PLAYER_LOGOUT" then
		DungeonQuestsFrame:UnregisterEvent("PLAYER_LOGOUT");
	end
end

function DungeonQuests:LoadPlayerData()

	DungeonQuests.Player = {}
	DungeonQuests.Player.Name = UnitName("player");
	DungeonQuests.Player.Realm = GetRealmName();
	DungeonQuests.Player.Faction = select(1, UnitFactionGroup("player")) -- Select the non-localized (English) faction name
	DungeonQuests.Player.Class = select(2, UnitClass("player")) -- Select the non-localized (English) class name
	DungeonQuests.Player.ClassColor = '|c'..select(4, GetClassColor(DungeonQuests.Player.Class))
	DungeonQuests.Player.ColoredClassName = DungeonQuests.Player.ClassColor..DungeonQuests.Player.Class..'|r'
	DungeonQuests.Player.ClassColoredPlayerName = DungeonQuests.Player.ClassColor..DungeonQuests.Player.Name..'|r'
	DungeonQuests.Player.Level = UnitLevel("player");
	DungeonQuests.Player.NameWithRealm = DungeonQuests.Player.Realm.." - "..DungeonQuests.Player.Name
	DungeonQuests.Player.Progress = {}
end

function DungeonQuests:LoadSavedData()
	if(DungeonQuestsSavedData == nil) then 
		DungeonQuestsSavedData = {} 
	end

	if(DungeonQuestsSavedData[DungeonQuests.Player.Realm] == nil) then
		DungeonQuestsSavedData[DungeonQuests.Player.Realm] = {}
	end
end

function DungeonQuests:Announce()
	DungeonQuests:PrintMessageWithAddonPrefix("activated.")
end

function DungeonQuests:HandleSlashCommand(cmd)
 	if cmd ~= nil and cmd ~= "" then
		if(cmd == "all") then
			DungeonQuests:CheckAllDungeonsPlayerProgress()
		else
			DungeonQuests:CheckDungeonPlayerProgress(string.upper(cmd))
		end
	else		
		DungeonQuests:UpdateAllDungeonsPlayerProgress()
		DungeonQuests:PrintMessageWithAddonPrefix('Updated all dungeon progress for '..DungeonQuests.Player.ClassColoredPlayerName..'.|r')
	end
end

function DungeonQuests:GetDungeonPlayerProgress(alias)
	
	if(DungeonQuests.Player.Progress[alias] == nil) then
		DungeonQuests.Player.Progress[alias] = {}
	end

	if(DungeonQuests.Player.Progress[alias].Quests == nil) then
		DungeonQuests.Player.Progress[alias].Quests = {}
	end

	return DungeonQuests.Player.Progress[alias]
end

function DungeonQuests:CheckDungeonPlayerProgress(alias)
	local dungeon = DungeonQuests.Dungeons[alias]
	if(dungeon ~= nil) then
		DungeonQuests:PrintMessageWithAddonPrefix(dungeon.Name..":")		
		DungeonQuests:UpdateDungeonPlayerProgress(dungeon)
		DungeonQuests:DisplayDungeonProgress(dungeon)
		
	else
		DungeonQuests:PrintMessageWithAddonPrefix('Dungeon \''..alias..'\' '..RED_FONT_COLOR_CODE..'not found.')
	end
end

function DungeonQuests:UpdateDungeonPlayerProgress(dungeon)

	DungeonQuests.Player.Level = UnitLevel("player")
	playerDungeonProgress = DungeonQuests:GetDungeonPlayerProgress(dungeon.Alias)

	local totalQuests = 0;
	local completedQuests = 0;

	for _, quest in pairs(dungeon.Quests) do
		if(quest[DungeonQuests.Player.Faction] and (quest.Class == nil or quest.Class == DungeonQuests.Player.Class)) then
			
			-- Update individual quest progress
			playerDungeonProgress.Quests[quest.ID] = {}
			playerDungeonProgress.Quests[quest.ID].IsCompleted = C_QuestLog.IsQuestFlaggedCompleted(quest.ID);
			playerDungeonProgress.Quests[quest.ID].IsReadyForTurnIn = IsQuestComplete(quest.ID);
			playerDungeonProgress.Quests[quest.ID].IsActive = GetQuestLogIndexByID(quest.ID) > 0;
			playerDungeonProgress.Quests[quest.ID].IsHighEnoughLevel = DungeonQuests.Player.Level >= quest.MinimumLevel;
			
			-- Count total quests available
			totalQuests = totalQuests + 1
			
			-- Count total quests already completed
			if(playerDungeonProgress.Quests[quest.ID].IsCompleted) then
				completedQuests = completedQuests + 1;
			end
		end
	end
	
	playerDungeonProgress.QuestsCompleted = completedQuests;
	playerDungeonProgress.TotalQuests = totalQuests;

	DungeonQuests:SavePlayerProgress();
end

function DungeonQuests:DisplayDungeonProgress(dungeon)

	playerProgress = DungeonQuests:GetDungeonPlayerProgress(dungeon.Alias)

	local count = 0;
	-- Loop through each quest progress
	for _, quest in pairs(dungeon.Quests) do
		
		local questProgress = playerProgress.Quests[quest.ID]
		if(questProgress ~= nil) then
			count = count + 1;			

			local questColor = DungeonQuests:GetQuestDifficultyColor(DungeonQuests.Player.Level, quest.Level)
			local questName = questColor..'['..quest.Level..'] '.. quest.Name..'|r' or 'Unknown'
			if(quest.Class ~= nil) then questName = questName..' ['..DungeonQuests.Player.ColoredClassName..'|r only]' end

			-- Player has previously completed the quest
			if(questProgress.IsCompleted) then
				DungeonQuests:PrintMessage('    - '..questName..' - '..GREEN_FONT_COLOR_CODE..'completed!')
			
			-- Player is already on quest and it is ready to turn in
			elseif(questProgress.IsReadyForTurnIn) then
				DungeonQuests:PrintMessage('    - '..questName..' - '..ORANGE_FONT_COLOR_CODE..'ready for turn in!')
			
			-- Player is already on quest and it is not yet finished
			elseif(questProgress.IsActive) then
				DungeonQuests:PrintMessage('    - '..questName..' - '..YELLOW_FONT_COLOR_CODE..'active.')

			-- Quest is missing and player is high enough level
			elseif(questProgress.IsHighEnoughLevel) then
				local message = '    - '..questName..' - '..RED_FONT_COLOR_CODE..'missing|r'

				-- Display if quest is Shareable or not
				if(quest.IsShareable) then
					message = message..' - '..GREEN_FONT_COLOR_CODE..'Shareable|r'
				else
					message = message..' - '..RED_FONT_COLOR_CODE..'Not Shareable|r'
				end
				
				-- Display if quest is part of a longer chain or not
				if(quest.IsChain) then
					message = message..' - '..YELLOW_FONT_COLOR_CODE.."Chain|r"
				end

				-- Display pickup location
				message = message..' - '..quest.Location

				message = message..'|r'
				DungeonQuests:PrintMessage(message)
			elseif(not quest.IsHighEnoughLevel) then
				DungeonQuests:PrintMessage('    - '..questName..' - '..RED_FONT_COLOR_CODE..'not available|r until level '..quest.MinimumLevel..'.')
			else
			end
		end
	end		
	if(count == 0) then
		DungeonQuests:PrintMessage('    '..RED_FONT_COLOR_CODE..'No quests available for your faction.')
	end

end

function DungeonQuests:CheckAllDungeonsPlayerProgress(alias)
	DungeonQuests:UpdateAllDungeonsPlayerProgress();
	DungeonQuests:DisplayAllDungeonProgress();
end

function DungeonQuests:UpdateAllDungeonsPlayerProgress()

	for _, dungeon in pairs(DungeonQuests.Dungeons) do
		DungeonQuests:UpdateDungeonPlayerProgress(dungeon)
	end
end

function DungeonQuests:DisplayAllDungeonProgress()

	DungeonQuests:PrintMessageWithAddonPrefix("Dungeon progress: ")

	for _, dungeon in pairs(DungeonQuests.Dungeons) do		
		progress = DungeonQuests:GetDungeonPlayerProgress(dungeon.Alias)
		if(progress.TotalQuests > 0) then
			local colorCode; 
			if(progress.QuestsCompleted == 0) then
				colorCode = RED_FONT_COLOR_CODE
			elseif(progress.QuestsCompleted < progress.TotalQuests) then			
				colorCode = YELLOW_FONT_COLOR_CODE
			elseif(progress.QuestsCompleted == progress.TotalQuests) then			
				colorCode = GREEN_FONT_COLOR_CODE
			end
			DungeonQuests:PrintMessage('    - '..dungeon.Name..": "..colorCode..progress.QuestsCompleted.." / "..progress.TotalQuests)
		end
	end
end

function DungeonQuests:CheckSpecificCharacter(character, realm)
	local name = character.." - "..realm
	local progress = nil

	if DungeonQuestsSavedData[realm] ~= nil and DungeonQuestsSavedData[realm][character] ~= nil then
		progress = DungeonQuestsSavedData[realm][character]
	end
		
	if progress ~= nil then
		DungeonQuests:PrintCharacterProgress(character, realm)	
	else		
		DungeonQuests:PrintMessageWithAddonPrefix("Entry for "..character..RED_FONT_COLOR_CODE.." not found!")
	end
end


function DungeonQuests:SavePlayerProgress()

	if(DungeonQuestsSavedData[DungeonQuests.Player.Realm] ~= nil) then
		-- Delete character progress if it's nil
		if(shredder.PlayerProgress == nil) then
			DungeonQuestsSavedData[DungeonQuests.Player.Realm][DungeonQuests.Player.Name] = nil
		-- Delete character progress if there is no main quest or chapter progress
		-- elseif (shredder.PlayerProgress["completed"] == nil and shredder.PlayerProgress["ready"] == nil and shredder.PlayerProgress["chapters"] == nil) then
		-- 	ShredderCharacterProgress[shredder.CurrentRealm][shredder.PlayerName] = nil
		-- Save character progress
		else			
			DungeonQuestsSavedData[DungeonQuests.Player.Realm][DungeonQuests.Player.Name] = DungeonQuests.Player.Progress
		end

		-- After updating character progress, check if there are any characters recorded on this realm
		local hasRealmProgress = false
		for _,_ in pairs(DungeonQuestsSavedData[DungeonQuests.Player.Realm]) do	
			hasRealmProgress = true;
			break;
		end

		-- If there are no recorded characters on this realm, delete the realm too
		if(hasRealmProgress == false) then
			DungeonQuestsSavedData[DungeonQuests.Player.Realm] = nil
		end
	end
end

function DungeonQuests:PrintMessageWithAddonPrefix(message)

	DungeonQuests:PrintMessage(YELLOW_FONT_COLOR_CODE.."DungeonQuests |r| "..message)
end

function DungeonQuests:PrintHeader(characterName)
	DungeonQuests:PrintMessageWithAddonPrefix("progress for "..YELLOW_FONT_COLOR_CODE..characterName.."|r...");	
end

function DungeonQuests:PrintMessage(message)

	DEFAULT_CHAT_FRAME:AddMessage(message)
end

function DungeonQuests:GetQuestDifficultyColor(playerLevel, questLevel)

	-- Red if quest is 5 or more levels above player level
	if(questLevel >= playerLevel + 5) then
		return RED_FONT_COLOR_CODE
	-- Orange if quest is 3 or 4 levels above player level
	elseif(questLevel >= playerLevel + 3) then
		return ORANGE_FONT_COLOR_CODE
	-- Yellow if quest is between 2 levels below and 2 levels above player level
	elseif(questLevel >= playerLevel - 2) then
		return YELLOW_FONT_COLOR_CODE
	-- Green if quest level is below a variable threshold depending on player current level
	else
		local threshold = GetQuestGreenRange()		
		
		if(questLevel > playerLevel - threshold) then
			return GREEN_FONT_COLOR_CODE
		else
			return GRAY_FONT_COLOR_CODE
		end
	end

end