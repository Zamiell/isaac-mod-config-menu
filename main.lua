local mod = RegisterMod("Mod Config Menu Standalone", 1)
local MCM = require("scripts.modconfig")


----------
--SAVING--
----------

local game = Game()
local level = game:GetLevel()

local skipNextLevelSave = false
local firstPlayerInited = false
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function(_, player) --player init is the first callback to trigger, before game started, new level, new room, etc

	if not firstPlayerInited then
	
		skipNextLevelSave = true
		firstPlayerInited = true
	
		if mod:HasData() then
			MCM.LoadSave(mod:LoadData())
		end
		
	end
	
end)

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
	
	if not skipNextLevelSave then
	
		local saveData = MCM.GetSave()
		mod:SaveData(saveData)
		
	end
	
	skipNextLevelSave = false
	
end)

mod:AddCallback(ModCallbacks.MC_POST_GAME_END, function(_, gameOver)

	firstPlayerInited = false
	
	local saveData = MCM.GetSave()
	mod:SaveData(saveData)
	
end)

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function(_, shouldSave)

	firstPlayerInited = false
	
	local saveData = MCM.GetSave()
	mod:SaveData(saveData)
	
end)


-------------------------
--OLD MOD COMPATIBILITY--
-------------------------

ModConfigMenu = {}
ModConfigMenu.Version = 13

ModConfigMenu.Config = MCM.Config

ModConfigMenuPopupGfx = MCM.PopupGfx
ModConfigMenuOptionType = MCM.OptionType

ModConfigMenu.SetOldCategoryInfo = function(category)
	MCM.UpdateCategory(category, {
		Info = {
			"This mod adds settings through",
			"an older method and may not work right"
		},
		IsOld = true
	})
end

ModConfigMenu.AddSetting = function(category, subcategory, settingTable)
	ModConfigMenu.SetOldCategoryInfo(category)
	return MCM.AddSetting(category, subcategory, settingTable)
end
ModConfigMenu.AddText = function(category, subcategory, text, color)
	ModConfigMenu.SetOldCategoryInfo(category)
	return MCM.AddText(category, subcategory, text, color)
end
ModConfigMenu.AddTitle = function(category, subcategory, text, color)
	ModConfigMenu.SetOldCategoryInfo(category)
	return MCM.AddTitle(category, subcategory, text, color)
end
ModConfigMenu.AddSpace = function(category, subcategory)
	ModConfigMenu.SetOldCategoryInfo(category)
	return MCM.AddSpace(category, subcategory)
end
