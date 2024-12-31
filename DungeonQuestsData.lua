DungeonQuests = {}

function DungeonQuests:LoadQuestData()

	local RFC = {}
	RFC.Name = 'Ragefire Chasm'
	RFC.Alias = 'RFC'
	RFC.MinimumLevel = 9
	RFC.Quests = {
		{
			ID = 5722, -- Searching for the Lost Satchel
			Location = 'Thunder Bluff',
			IsShareable = true,
			Level = 16,
			MinimumLevel = 9,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 5723, -- Testing an Enemy's Strength
			Location = 'Thunder Bluff',
			IsShareable = true,
			Level = 15,
			MinimumLevel = 9,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 5761, -- Slaying the Beast
			Location = 'Orgrimmar',
			IsShareable = true,
			Level = 16,
			MinimumLevel = 9,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 5725, -- The Power to Destroy
			Location = 'The Undercity',
			IsShareable = true,
			Level = 16,
			MinimumLevel = 9,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 5728, -- Hidden Enemies
			Location = 'Orgrimmar',
			IsShareable = true,
			Level = 16,
			MinimumLevel = 9,
			IsChain = true,
			PreviousQuestID = 5272,
			Alliance = false,
			Horde = true
		}
	}

	local WC = {}
	WC.Name = 'Wailing Caverns'
	WC.Alias = 'WC'
	WC.MinimumLevel = 15
	WC.Quests = {
		{
			ID = 962, -- Serpent Bloom
			Location = 'Thunder Bluff',
			IsShareable = true,
			Level = 18,
			MinimumLevel = 14,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1491, -- Smart Drinks
			Location = 'Ratchet',
			IsShareable = true,
			Level = 18,
			MinimumLevel = 13,
			IsChain = true,
			PreviousQuestID = 865,
			Alliance = true,
			Horde = true
		},
		{
			ID = 959, -- Trouble at the Docks
			Location = 'Ratchet',
			IsShareable = true,
			Level = 18,
			MinimumLevel = 14,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 1486, -- Deviate Hides
			Location = 'Wailing Caverns',
			IsShareable = true,
			Level = 17,
			MinimumLevel = 13,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 1487, -- Deviate Eradication
			Location = 'Wailing Caverns',
			IsShareable = true,
			Level = 21,
			MinimumLevel = 15,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 914, -- Leaders of the Fang
			Location = 'Thunderbluff',
			IsShareable = true,
			Level = 21,
			MinimumLevel = 10,
			IsChain = true,
			PreviousQuestID = 1490,
			Alliance = false,
			Horde = true
		},		
		{
			ID = 6981, -- The Glowing Shard
			Location = 'Wailing Caverns',
			IsShareable = false,
			Level = 26,
			MinimumLevel = 15,
			IsChain = false,
			Alliance = true,
			Horde = true
		}
	}

	local SFK = {}
	SFK.Name = 'Shadowfang Keep'
	SFK.Alias = 'SFK'
	SFK.MinimumLevel = 18
	SFK.Quests = {
		{
			ID = 1013, -- The Book of Ur
			Location = 'The Undercity',
			IsShareable = true,
			Level = 26,
			MinimumLevel = 16,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1098, -- Deathstalkers in Shadowfang
			Location = 'The Sepulcher',
			IsShareable = true,
			Level = 25,
			MinimumLevel = 18,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1014, -- Arugal Must Die
			Location = 'The Sepulcher',
			IsShareable = true,
			Level = 27,
			MinimumLevel = 18,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1740, -- The Orb of Soran'ruk
			Location = 'The Barrens',
			IsShareable = true,
			Level = 25,
			MinimumLevel = 20,
			IsChain = false,			
			Alliance = true,
			Horde = true,
			Class = "WARLOCK"
		},
		{
			ID = 1654, -- The Test of Righteousness
			Location = 'Ironforge',
			IsShareable = false,
			Level = 22,
			MinimumLevel = 20,
			IsChain = true,
			PreviousQuestID = 1653,
			Alliance = true,
			Horde = false,
			Class = "PALADIN"
		}
	}



	local RFK = {}
	RFK.Name = 'Razorfen Kraul'
	RFK.Alias = 'RFK'
	RFK.MinimumLevel = 25
	RFK.Quests = {
		{
			ID = 1102, -- A Vengeful Fate
			Location = 'Thunder Bluff',
			IsShareable = true,
			Level = 34,
			MinimumLevel = 29,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1109, -- Going, going, Guano!
			Location = 'The Undercity',
			IsShareable = true,
			Level = 33,
			MinimumLevel = 30,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 6522, -- An Unholy Alliance
			Location = 'Razorfen Kraul',
			IsShareable = false,
			Level = 36,
			MinimumLevel = 28,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1101, -- The Crone of the Kraul
			Location = 'Thousand Needles',
			IsShareable = true,
			Level = 34,
			MinimumLevel = 29,
			IsChain = true,
			Alliance = true,
			Horde = false
		},
		{
			ID = 1142, -- Mortality Wanes
			Location = 'Razorfen Kraul',
			IsShareable = true,
			Level = 30,
			MinimumLevel = 25,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 1221, -- Blueleaf Tubers
			Location = 'Ratchet',
			IsShareable = false,
			Level = 26,
			MinimumLevel = 20,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 1144, -- Willix the Importer
			Location = 'Razorfen Kraul',
			IsShareable = false,
			Level = 30,
			MinimumLevel = 22,
			IsChain = false,
			Alliance = true,
			Horde = true
		}
	}

	local STOCK = {}
	STOCK.Name = 'The Stockade'
	STOCK.Alias = 'STOCK'
	STOCK.MinimumLevel = 22
	STOCK.Quests = {
		{
			ID = 387, -- Quell the Uprising
			Location = 'Stormwind City',
			IsShareable = true,
			MinimumLevel = 22,
			Level = 26,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 388, -- The Color of Blood
			Location = 'Stormwind City',
			IsShareable = true,
			Level = 26,
			MinimumLevel = 22,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 377, -- Crime and Punishment
			Location = 'Darkshire',
			IsShareable = true,
			Level = 26,
			MinimumLevel = 22,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 386, -- What Comes Around...
			Location = 'Lakeshire',
			IsShareable = true,
			Level = 25,
			MinimumLevel = 22,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 378, -- The Fury Runs Deep
			Location = 'Dun Modr',
			IsShareable = true,
			Level = 27,
			MinimumLevel = 25,
			IsChain = true,
			Alliance = true,
			Horde = false
		},
		{
			ID = 391, -- The Stockade Riots
			Location = 'Stormwind City',
			IsShareable = true,
			MinimumLevel = 16,
			Level = 29,
			IsChain = true,
			Alliance = true,
			Horde = false
		}
	}

	local RFD = {}
	RFD.Name = 'Razorfen Downs'
	RFD.Alias = 'RFD'
	RFD.MinimumLevel = 35
	RFD.Quests = {
		{
			ID = 3341, -- Bring the End
			Location = 'Undercity',
			IsShareable = true,
			Level = 42,
			MinimumLevel = 37,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 6521, -- An Unholy Alliance
			Location = 'The Undercity',
			IsShareable = true,
			Level = 36,
			MinimumLevel = 28,
			IsChain = true,
			PreviousQuestID = 6522,
			Alliance = false,
			Horde = true
		},
		{
			ID = 3636, -- Bring the Light
			Location = 'Stormwind',
			IsShareable = false,
			Level = 42,
			MinimumLevel = 39,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 6626, -- A Host of Evil
			Location = 'Razorfen Downs (outside)',
			IsShareable = true,
			Level = 35,
			MinimumLevel = 28,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 3523, -- Scourge of the Downs
			Location = 'Razorfen Downs',
			IsShareable = false,
			Level = 37,
			MinimumLevel = 32,
			IsChain = false,
			Alliance = true,
			Horde = true
		}
	}

	local SM = {}
	SM.Name = 'Scarlet Monastery'
	SM.Alias = 'SM'
	SM.MinimumLevel = 26
	SM.Quests = {
		{
			ID = 1048, -- Into the Scarlet Monastery
			Location = 'Undercity',
			IsShareable = true,
			Level = 42,
			MinimumLevel = 33,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1053, -- In the Name of the Light
			Location = 'Southshore',
			IsShareable = true,
			Level = 40,
			MinimumLevel = 34,
			IsChain = true,
			-- PreviousQuest = {
			-- 	ID = 1052, -- Down the Scarlet Path
			-- 	Start
			-- 	PreviousQuest = {
			-- 		ID = 261, -- Down the Scarlet Path
			-- 		PreviousQuest = {
			-- 			ID = 6141, -- Brother Anton
			-- 			StartLocation = 'Stormwind',
			-- 			StartNpc 
			-- 			PreviousQuest = nil
			-- 		}
			-- 	}
			-- }			
			Alliance = true,
			Horde = false,
		},
		{
			ID = 1051, -- Vorrel's Revenge
			Location = 'Scarlet Monastery',
			IsShareable = true,
			Level = 33,
			MinimumLevel = 25,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1113, -- Hearts of Zeal
			Location = 'Undercity',
			IsShareable = true,
			Level = 33,
			MinimumLevel = 30,
			IsChain = true,
			PreviousQuestID = 1109, -- Going Going Guano
			Alliance = false,
			Horde = true
		},
		{
			ID = 1049, -- Compendium of the Fallen
			Location = 'Thunderbluff',
			IsShareable = true,
			Level = 38,
			MinimumLevel = 28,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1160, -- Test of Lore
			Location = 'Undercity',
			IsShareable = true,
			Level = 36,
			MinimumLevel = 25,
			IsChain = true,
			PreviousQuestID = 1159, -- Test of Lore
			Alliance = false,
			Horde = true
		},
		{
			ID = 1050, -- Mythology of the Titans
			Location = 'Ironforge',
			IsShareable = true,
			Level = 38,
			MinimumLevel = 28,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 1951, -- Rituals of Power (Mage)
			Location = 'Orgrimmar/Stormwind',
			IsShareable = true,
			Level = 40,
			MinimumLevel = 30,
			IsChain = true,
			PreviousQuestID = 1950, -- Get the Scoop
			Alliance = true,
			Horde = true,
			Class = 'MAGE'
		}
	}

	

	local ULDA = {}
	ULDA.Name = 'Uldaman'
	ULDA.Alias = 'ULDA'
	ULDA.MinimumLevel = 37
	ULDA.Quests = {
		{
			ID = 2418, -- Power Stones
			Location = 'Badlands',
			IsShareable = true,
			Level = 36,
			MinimumLevel = 30,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 709, -- Solution to Doom
			Location = 'Badlands',
			IsShareable = true,
			Level = 40,
			MinimumLevel = 30,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 2278, -- The Platinum Discs
			Location = 'Uldaman',
			IsShareable = false,
			Level = 47,
			MinimumLevel = 40,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 2342, -- Reclaimed Treasures
			Location = 'Undercity',
			IsShareable = true,
			Level = 43,
			MinimumLevel = 33,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 2202, -- Uldaman Reagent Run
			Location = 'Badlands',
			IsShareable = true,
			Level = 42,
			MinimumLevel = 36,
			IsChain = true,
			Alliance = false,
			Horde = true
		},
		{
			ID = 2341, -- Necklace Recovery, Take 3
			Location = 'Orgrimmar',
			IsShareable = true,
			Level = 44,
			MinimumLevel = 37,
			IsChain = true,
			Alliance = false,
			Horde = true
		},
		{
			ID = 1360, -- Reclaimed Treasures
			Location = 'Ironforge',
			IsShareable = true,
			Level = 43,
			MinimumLevel = 33,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 722, -- Amulet of Secrets
			Location = 'Badlands',
			IsShareable = true,
			Level = 40,
			MinimumLevel = 35,
			IsChain = true,
			Alliance = true,
			Horde = false
		},
		{
			ID = 704, -- Agmond's Fate
			Location = 'Ironforge',
			IsShareable = true,
			MinimumLevel = 30,
			Level = 38,
			IsChain = true,
			Alliance = true,
			Horde = false
		},
		{
			ID = 1139, -- The Lost Tablets of Will
			Location = 'Ironforge',
			IsShareable = true,
			Level = 45,
			MinimumLevel = 35,
			IsChain = true,
			Alliance = true,
			Horde = false
		},
		{
			ID = 2204, -- Restoring the Necklace
			Location = 'Uldaman',
			IsShareable = true,
			Level = 44,
			MinimumLevel = 37,
			IsChain = true,
			Alliance = true,
			Horde = false
		},
		{
			ID = 1956, -- Power in Uldaman
			Location = 'Dustwallow Marsh',
			IsShareable = true,
			Level = 40,
			MinimumLevel = 35,
			IsChain = true,
			Alliance = true,
			Horde = true,
			Class = 'MAGE'
		}
	}

	local ZF = {}
	ZF.Name = 'Zul\'Farrak'
	ZF.Alias = 'ZF'
	ZF.MinimumLevel = 40
	ZF.Quests = {
		{
			ID = 2768, -- Divino-matic Rod
			Location = 'Gadgetzan',
			IsShareable = true,
			Level = 47,
			MinimumLevel = 40,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 2865, -- Scarab Shells
			Location = 'Gadgetzan',
			IsShareable = true,
			Level = 45,
			MinimumLevel = 40,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 3042, -- Troll Temper
			Location = 'Gadgetzan',
			IsShareable = true,
			Level = 45,
			MinimumLevel = 40,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 2846, -- Tiara of the Deep
			Location = 'Dustwallow Marsh',
			IsShareable = true,
			MinimumLevel = 40,
			Level = 46,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 2770, -- Gahz'rilla
			Location = 'Shimmering Flats',
			IsShareable = true,
			Level = 50,
			MinimumLevel = 40,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 3527, -- The Prophecy of Mosh'aru
			Location = 'Steamwheedle Port',
			IsShareable = true,
			Level = 47,
			MinimumLevel = 40,
			IsChain = true,
			Alliance = true,
			Horde = true
		},
		{
			ID = 2936, -- The Spider God
			Location = 'Sen\'jin Village',
			IsShareable = true,
			Level = 45,
			MinimumLevel = 40,
			IsChain = true,
			Alliance = false,
			Horde = true
		},
		{
			ID = 2991, -- Nekrum's Medallion
			Location = 'Nethergarde Keep',
			IsShareable = true,
			Level = 47,
			MinimumLevel = 40,
			IsChain = true,
			Alliance = true,
			Horde = false
		}
	}

	local MARA = {}
	MARA.Name = 'Maraudon'
	MARA.Alias = 'MARA'
	MARA.MinimumLevel = 40
	MARA.Quests = {
		{
			ID = 7028, -- Twisted Evils
			Location = 'Desolace',
			IsShareable = true,
			Level = 47,
			MinimumLevel = 41,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 7067, -- The Pariah's Instructions
			Location = 'Desolace',
			IsShareable = false,
			Level = 48,
			MinimumLevel = 39,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 7044, -- Legends of Maraudon
			Location = 'Maraudon Orange Side (outside)',
			IsShareable = true,
			Level = 49,
			MinimumLevel = 41,
			IsChain = false,
			Alliance = true,
			Horde = true
		},		
		{
			ID = 7066, -- Seed of Life
			Location = 'Maraudon (after killing Princess)',
			IsShareable = false,
			Level = 51,
			MinimumLevel = 39,
			IsChain = false,
			Alliance = true,
			Horde = true
		},
		{
			ID = 7046, -- The Scepter of Celebras
			Location = 'Maraudon (after completing the Legends of Mauradon)',
			IsShareable = false,
			Level = 49,
			MinimumLevel = 41,
			IsChain = true,
			Alliance = true,
			Horde = true
		},
		{
			ID = 7068, -- Shadowshard Fragments
			Location = 'Orgrimmar',
			IsShareable = true,
			Level = 42,
			MinimumLevel = 39,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 7029, -- Vyletongue Corruption
			Location = 'Shadowprey Village',
			IsShareable = false,
			Level = 47,
			MinimumLevel = 39,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 7064, -- Corruption of Earth and Seed
			Location = 'Shadowprey Village',
			IsShareable = true,
			Level = 51,
			MinimumLevel = 45,
			IsChain = false,
			Alliance = false,
			Horde = true
		},
		{
			ID = 7070, -- Shadowshard Fragments
			Location = 'Theramore',
			IsShareable = true,
			Level = 42,
			MinimumLevel = 39,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 7041, -- Vyletongue Corruption
			Location = 'Nije\'ls Point',
			IsShareable = false,
			Level = 47,
			MinimumLevel = 41,
			IsChain = false,
			Alliance = true,
			Horde = false
		},
		{
			ID = 7065, -- Corruption of Earth and Seed
			Location = 'Nijel\'s Point',
			IsShareable = true,
			Level = 51,
			MinimumLevel = 45,
			IsChain = false,
			Alliance = true,
			Horde = false
		}
	}

	DungeonQuests.Dungeons = {}
	DungeonQuests.Dungeons[RFC.Alias] = RFC
	DungeonQuests.Dungeons[WC.Alias] = WC
	DungeonQuests.Dungeons[SFK.Alias] = SFK
	DungeonQuests.Dungeons[STOCK.Alias] = STOCK
	DungeonQuests.Dungeons[RFK.Alias] = RFK
	DungeonQuests.Dungeons[SM.Alias] = SM
	DungeonQuests.Dungeons[RFD.Alias] = RFD
	DungeonQuests.Dungeons[ULDA.Alias] = ULDA
	DungeonQuests.Dungeons[ZF.Alias] = ZF
	DungeonQuests.Dungeons[MARA.Alias] = MARA
end

function DungeonQuests:PrimeQuestNamesCache()
	for _, dungeon in pairs(DungeonQuests.Dungeons) do
		for _, quest in pairs(dungeon.Quests) do
			DungeonQuests:PrimeQuestNameCache(quest)
		end
	end
end

function DungeonQuests:PrimeQuestNameCache(quest)
	quest.Name = C_QuestLog.GetQuestInfo(quest.ID) -- Prime quest data cache
end