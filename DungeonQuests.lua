function DungeonQuests:OnLoad()
	SLASH_DUNGEONQUESTS1 = "/dungeonquests";
	SLASH_DUNGEONQUESTS1 = "/dq";
	SLASH_DUNGEONQUESTSMISSING1 = "/dqm"
	SlashCmdList["DUNGEONQUESTS"] = function(msg) DungeonQuests:HandleSlashCommand(msg) end
	SlashCmdList["DUNGEONQUESTSMISSING"] = function(msg) DungeonQuests:HandleSlashCommand(msg) end

	DungeonQuestsFrame:RegisterEvent("PLAYER_LOGIN")
	DungeonQuestsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	DungeonQuestsFrame:RegisterEvent("ADDON_LOADED")
	DungeonQuestsFrame:RegisterEvent("QUEST_ACCEPTED")
	DungeonQuestsFrame:RegisterEvent("QUEST_REMOVED")
	DungeonQuestsFrame:RegisterEvent("QUEST_TURNED_IN")
	DungeonQuestsFrame:RegisterEvent("QUEST_WATCH_UPDATE")
end


function DungeonQuests:OnEvent(self, event, ...)
	local arg1, arg2, arg3, arg4 = ...
	if event == "ADDON_LOADED" and arg1 == "DungeonQuests" then
		DungeonQuestsFrame:UnregisterEvent("ADDON_LOADED");
	elseif event == "PLAYER_LOGIN" then
		DungeonQuestsFrame:UnregisterEvent("PLAYER_LOGIN");
		DungeonQuests:LoadQuestData();
		DungeonQuests:LoadPlayerData();
		DungeonQuests:LoadSavedData();
		DungeonQuests:PrimeQuestNamesCache();		
		DungeonQuests:UpdateAllPlayerDungeonProgress();
		DungeonQuests:Announce();
	elseif (event == "QUEST_ACCEPTED") then -- returns questLogIndex, questID
		local questID = arg2;
		DungeonQuests:UpdatePlayerDungeonQuestProgress(questID);
	elseif (event == "QUEST_REMOVED") then -- returns questID
		local questID = arg1;
		DungeonQuests:UpdatePlayerDungeonQuestProgress(questID);
	elseif (event == "QUEST_TURNED_IN") then -- returns questID
		local questID = arg1;
		DungeonQuests:UpdatePlayerDungeonQuestProgress(questID);
	elseif (event == "QUEST_WATCH_UPDATE") then -- returns questID
		local questID = arg1;
		DungeonQuests:UpdatePlayerDungeonQuestProgress(questID);
	end
end

function DungeonQuests:LoadPlayerData()

	DungeonQuests.Player = {}
	DungeonQuests.Player.Name = UnitName("player");
	DungeonQuests.Player.Realm = GetRealmName();
	DungeonQuests.Player.Faction = select(1, UnitFactionGroup("player")) -- Select the non-localized (English) faction name
	DungeonQuests.Player.Class = select(2, UnitClass("player")) -- Select the non-localized (English) class name
	DungeonQuests.Player.Race = select(2, UnitRace("player")) -- Select the non-localized (English) class name
	DungeonQuests.Player.ClassColor = '|c'..select(4, GetClassColor(DungeonQuests.Player.Class))
	DungeonQuests.Player.ColoredClassName = DungeonQuests.Player.ClassColor..DungeonQuests.Player.Class..'|r'
	DungeonQuests.Player.ClassColoredPlayerName = DungeonQuests.Player.ClassColor..DungeonQuests.Player.Name..'|r'
	DungeonQuests.Player.Level = UnitLevel("player");
	DungeonQuests.Player.NameWithRealm = DungeonQuests.Player.Name.." - "..DungeonQuests.Player.Realm
end

function DungeonQuests:LoadSavedData()
	if(DungeonQuestsSavedData == nil) then 
		DungeonQuestsSavedData = {} 
	end

	if(DungeonQuestsSavedData[DungeonQuests.Player.Realm] == nil) then
		DungeonQuestsSavedData[DungeonQuests.Player.Realm] = {}
	end

	if(DungeonQuestsSavedData[DungeonQuests.Player.Realm][DungeonQuests.Player.Name] == nil) then
		DungeonQuestsSavedData[DungeonQuests.Player.Realm][DungeonQuests.Player.Name] = {}
	end

	DungeonQuests.Player.Progress = DungeonQuestsSavedData[DungeonQuests.Player.Realm][DungeonQuests.Player.Name] or {}
end

function DungeonQuests:Announce()
	DungeonQuests:PrintMessageWithAddonPrefix("activated.")
end

function DungeonQuests:HandleSlashCommand(cmd)
 	if cmd ~= nil and cmd ~= "" then
		if(cmd == "all") then
			DungeonQuests:CheckAllPlayerDungeonProgress()
		else
			DungeonQuests:CheckPlayerDungeonProgress(string.upper(cmd))
		end
	else		
		DungeonQuests:UpdateAllPlayerDungeonProgress()
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

function DungeonQuests:CheckPlayerDungeonProgress(alias)
	local dungeon = DungeonQuests.Dungeons[alias]
	if(dungeon ~= nil) then
		DungeonQuests:PrintMessageWithAddonPrefix(dungeon.Name..":")		
		DungeonQuests:UpdatePlayerDungeonProgress(dungeon)		
		playerProgress = DungeonQuests:GetDungeonPlayerProgress(dungeon.Alias)
		DungeonQuests:DisplayDungeonProgress(dungeon, playerProgress)
		
	else
		DungeonQuests:PrintMessageWithAddonPrefix('Dungeon \''..alias..'\' '..RED_FONT_COLOR_CODE..'not found.')
	end
end

function DungeonQuests:UpdatePlayerDungeonQuestProgress(questID)
	for _, dungeon in pairs(DungeonQuests.Dungeons) do
		for _, quest in pairs(dungeon.Quests) do
			if(quest.ID == questID) then
				DungeonQuests:UpdatePlayerDungeonProgress(dungeon)
				break
			end
		end
	end
end

function DungeonQuests:UpdatePlayerDungeonProgress(dungeon)

	DungeonQuests.Player.Level = UnitLevel("player")
	playerDungeonProgress = DungeonQuests:GetDungeonPlayerProgress(dungeon.Alias)

	local totalQuests = 0;
	local completedQuests = 0;
	local activeQuests = 0;
	local missingQuests = 0;

	for _, quest in pairs(dungeon.Quests) do				
		quest.Link = DungeonQuests:GetQuestLink(quest)

		local isFaction = quest[DungeonQuests.Player.Faction]
		local isClass = quest.Class == nil or quest.Class == DungeonQuests.Player.Class
		local isRace = quest.Race == nil or quest.Race == DungeonQuests.Player.Race

		playerDungeonProgress.Quests[quest.ID] = {}
		local questProgress = playerDungeonProgress.Quests[quest.ID]

		if(isFaction and isClass and isRace) then			
			-- Count total quests available
			totalQuests = totalQuests + 1

			-- Update individual quest progress						
			if(C_QuestLog.IsQuestFlaggedCompleted(quest.ID)) then
				questProgress.IsCompleted = true
				completedQuests = completedQuests + 1;
			elseif(IsQuestComplete(quest.ID)) then
				questProgress.IsReadyForTurnIn = true
				activeQuests = activeQuests + 1
			elseif(GetQuestLogIndexByID(quest.ID) > 0) then
				questProgress.IsActive = true
				activeQuests = activeQuests + 1
			elseif(DungeonQuests.Player.Level >= quest.MinimumLevel) then
				questProgress.IsAvailable = true
				missingQuests = missingQuests + 1			
			elseif(DungeonQuests.Player.Level < quest.MinimumLevel) then
				print(quest.Name..' ('..quest.MinimumLevel..')')
				questProgress.IsNotYetAvailable = true
			end
		else
			if(not isClass) then
				questProgress.IsNotAvailableToClass = not isClass
			elseif(not isRace) then
				questProgress.IsNotAvailableToRace = not isRace
			elseif(not isFaction) then
				questProgress.IsNotAvailableToFaction = not isFaction
			end
		end
	end
	
	playerDungeonProgress.MissingQuests = missingQuests;
	playerDungeonProgress.ActiveQuests = activeQuests;
	playerDungeonProgress.QuestsCompleted = completedQuests;
	playerDungeonProgress.TotalQuests = totalQuests;

	DungeonQuests:SavePlayerProgress();
end

function DungeonQuests:DisplayDungeonProgress(dungeon, progress)


	local count = 0;
	-- Loop through each quest progress
	for _, quest in pairs(dungeon.Quests) do
		
		local questProgress = progress.Quests[quest.ID]
		if(questProgress ~= nil) then
			count = count + 1;

			-- Player has previously completed the quest
			if(questProgress.IsCompleted) then
				DungeonQuests:PrintMessage('    - '..quest.Link..' - '..GREEN_FONT_COLOR_CODE..'completed!')
			
			-- Player is already on quest and it is ready to turn in
			elseif(questProgress.IsReadyForTurnIn) then
				DungeonQuests:PrintMessage('    - '..quest.Link..' - '..ORANGE_FONT_COLOR_CODE..'ready for turn in!')
			
			-- Player is already on quest and it is not yet finished
			elseif(questProgress.IsActive) then
				DungeonQuests:PrintMessage('    - '..quest.Link..' - '..YELLOW_FONT_COLOR_CODE..'active.')

			-- Quest is missing and player is high enough level
			elseif(questProgress.IsAvailable) then
				local message = '    - '..quest.Link..' - '..RED_FONT_COLOR_CODE..'missing|r'

				-- Display if quest is Shareable or not
				-- if(quest.IsShareable) then
				-- 	message = message..' - '..GREEN_FONT_COLOR_CODE..'Shareable|r'
				-- else
				-- 	message = message..' - '..RED_FONT_COLOR_CODE..'Not Shareable|r'
				-- end
				
				-- -- Display if quest is part of a longer chain or not
				-- if(quest.IsChain) then
				-- 	message = message..' - '..YELLOW_FONT_COLOR_CODE.."Chain|r"
				-- end

				-- -- Display pickup location
				-- message = message..' - '..quest.Location

				message = message..'|r'
				DungeonQuests:PrintMessage(message)
			elseif(quest.IsNotYetAvailable) then
				DungeonQuests:PrintMessage('    - '..quest.Link..' - '..RED_FONT_COLOR_CODE..'not available|r until level '..quest.MinimumLevel..'.')
			elseif(quest.IsNotAvailableToClass) then
				DungeonQuests:PrintMessage('    - '..quest.Link..' - '..RED_FONT_COLOR_CODE..'not available to your class')
			elseif(quest.IsNotAvailableToRace) then
				DungeonQuests:PrintMessage('    - '..quest.Link..' - '..RED_FONT_COLOR_CODE..'not available to  your race')
			elseif(quest.IsNotAvailableToFaction) then
				DungeonQuests:PrintMessage('    - '..quest.Link..' - '..RED_FONT_COLOR_CODE..'not available to your faction')			
			end
		end
	end		
	if(count == 0) then
		DungeonQuests:PrintMessage('    '..RED_FONT_COLOR_CODE..'No quests available.')
	end

end

function DungeonQuests:CheckAllPlayerDungeonProgress(alias)
	DungeonQuests:UpdateAllPlayerDungeonProgress();
	DungeonQuests:DisplayAllDungeonProgress();
end

function DungeonQuests:UpdateAllPlayerDungeonProgress()

	for _, dungeon in pairs(DungeonQuests.Dungeons) do
		DungeonQuests:UpdatePlayerDungeonProgress(dungeon)
	end
end

function DungeonQuests:DisplayAllDungeonProgress()

	local completedHeader = GREEN_FONT_COLOR_CODE.."completed|r"
	local activeHeader = YELLOW_FONT_COLOR_CODE.."active|r"
	local missingHeader = RED_FONT_COLOR_CODE.."missing|r"
	DungeonQuests:PrintMessageWithAddonPrefix("Dungeon progress: ("..missingHeader.." / "..activeHeader.." / "..completedHeader..")")

	for _, dungeon in pairs(DungeonQuests.Dungeons) do		
		progress = DungeonQuests:GetDungeonPlayerProgress(dungeon.Alias)
		if(progress.TotalQuests > 0) then
			local completed = GREEN_FONT_COLOR_CODE..progress.QuestsCompleted.."|r"
			local active = YELLOW_FONT_COLOR_CODE..progress.ActiveQuests.."|r"
			local missing = RED_FONT_COLOR_CODE..progress.MissingQuests.."|r"

			DungeonQuests:PrintMessage('    - '..dungeon.Name..": "..missing.." / "..active.." / "..completed)
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
		if(DungeonQuests.Player.Progress == nil) then
			DungeonQuestsSavedData[DungeonQuests.Player.Realm][DungeonQuests.Player.Name] = nil		
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