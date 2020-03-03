local mod = RegisterMod("Mod Config Menu Standalone", 1)
local MCM = require("scripts.modconfig")


----------
--SAVING--
----------
local CallbackHelper = require("scripts.callbackhelper")

local game = Game()
local level = game:GetLevel()

local skipNextLevelSave = false
CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.CH_GAME_START, function(_, player, isSaveGame)

	skipNextLevelSave = true

	if mod:HasData() then
		MCM.LoadSave(mod:LoadData())
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
	
	local saveData = MCM.GetSave()
	mod:SaveData(saveData)
	
end)

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function(_, shouldSave)
	
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

ModConfigMenu.AddHudOffsetChangeCallback = function(functionToAdd)
	CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_MODIFY_HUD_OFFSET, functionToAdd)
end
ModConfigMenu.AddOverlayChangeCallback = function(functionToAdd)
	CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_MODIFY_OVERLAYS, functionToAdd)
end
ModConfigMenu.AddChargeBarChangeCallback = function(functionToAdd)
	CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_CHARGE_BARS, functionToAdd)
end
ModConfigMenu.AddBigBookChangeCallback = function(functionToAdd)
	CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_BIG_BOOKS, functionToAdd)
end
