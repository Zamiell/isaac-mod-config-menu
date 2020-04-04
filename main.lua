--this script handles saving for the standalone version of mod config menu, and adds globals to the global table that redirect into mod config menu functions, to add support for older mods that made use of these

--create the mod
local mod = RegisterMod("Mod Config Menu Standalone", 1)

--require some lua libraries
local MCM = require("scripts.modconfig")
local CallbackHelper = require("scripts.callbackhelper")
local SaveHelper = require("scripts.savehelper")


----------
--SAVING--
----------

SaveHelper.AddMod(mod)
SaveHelper.DefaultGameSave(mod, {
	ModConfigSave = {}
})

CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.SH_PRE_MOD_SAVE, function(_, modRef, saveData)

	local mcmSave = MCM.GetSave()
	saveData.ModConfigSave = mcmSave
	
end, mod)

CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.SH_POST_MOD_LOAD, function(_, modRef, saveData)

	MCM.LoadSave(saveData.ModConfigSave)
	
end, mod)


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
	CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_MODIFY_CHARGE_BARS, functionToAdd)
end
ModConfigMenu.AddBigBookChangeCallback = function(functionToAdd)
	CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_MODIFY_BIG_BOOKS, functionToAdd)
end
