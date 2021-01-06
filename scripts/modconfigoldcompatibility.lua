--this script adds globals to the global table that redirect into mod config menu functions, to add support for older mods that made use of these.
--temporary, this script may be removed or disabled in the future.

if not ModConfigMenu then

	--create the mod
	local mod = RegisterMod("Mod Config Menu Compatibility", 1)

	--require some lua libraries
	local MCM = require("scripts/modconfig")
	-- local CallbackHelper = require("scripts/callbackhelper")
	local InputHelper = require("scripts/inputhelper")

	-------------------------
	--OLD MOD COMPATIBILITY--
	-------------------------

	ModConfigMenu = {}
	ModConfigMenu.Version = 13

	ModConfigMenu.VECTOR_ZERO = Vector(0,0)
	ModConfigMenu.VECTOR_ONE = Vector(1,1)

	ModConfigMenu.VECTOR_LEFT = Vector(-1,0)
	ModConfigMenu.VECTOR_UP = Vector(0,-1)
	ModConfigMenu.VECTOR_RIGHT = Vector(1,0)
	ModConfigMenu.VECTOR_DOWN = Vector(0,1)
	ModConfigMenu.VECTOR_UP_LEFT = Vector(-1,-1)
	ModConfigMenu.VECTOR_UP_RIGHT = Vector(1,-1)
	ModConfigMenu.VECTOR_DOWN_LEFT = Vector(-1,1)
	ModConfigMenu.VECTOR_DOWN_RIGHT = ModConfigMenu.VECTOR_ONE

	ModConfigMenu.COLOR_DEFAULT = Color(1,1,1,1,0,0,0)
	ModConfigMenu.COLOR_HALF = Color(1,1,1,0.5,0,0,0)
	ModConfigMenu.COLOR_INVISIBLE = Color(1,1,1,0,0,0,0)
	ModConfigMenu.KCOLOR_DEFAULT = KColor(1,1,1,1)
	ModConfigMenu.KCOLOR_HALF = KColor(1,1,1,0.5)
	ModConfigMenu.KCOLOR_INVISIBLE = KColor(1,1,1,0)

	local fakeCachedDataToReturn = {
		Game = Game,
		Seeds = function() return Game():GetSeeds() end,
		Level = function() return Game():GetLevel() end,
		Room = function() return Game():GetRoom() end,
		SFX = SFXManager
	}
	setmetatable(ModConfigMenu, {

		__index = function(this, key)

			if fakeCachedDataToReturn[key] then
			
				return fakeCachedDataToReturn[key]()
				
			end

		end

	})

	ModConfigMenu.Config = MCM.Config
	
	ModConfigMenuController = Controller
	ModConfigMenuKeyboardToString = InputHelper.KeyboardToString
	ModConfigMenuControllerToString = InputHelper.ControllerToString

	ModConfigMenuPopupGfx = MCM.PopupGfx
	ModConfigMenuOptionType = MCM.OptionType

	ModConfigMenuData = MCM.MenuData

	ModConfigMenu.SetOldCategoryInfo = function(category)
		MCM.UpdateCategory(category, {
			Info = {
				"This mod adds settings through an older method and may not work right"
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
		-- CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_MODIFY_HUD_OFFSET, functionToAdd)
	end
	ModConfigMenu.AddOverlayChangeCallback = function(functionToAdd)
		-- CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_MODIFY_OVERLAYS, functionToAdd)
	end
	ModConfigMenu.AddChargeBarChangeCallback = function(functionToAdd)
		-- CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_MODIFY_CHARGE_BARS, functionToAdd)
	end
	ModConfigMenu.AddBigBookChangeCallback = function(functionToAdd)
		-- CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.MCM_POST_MODIFY_BIG_BOOKS, functionToAdd)
	end
	
	return true --return true if creating old version stuff was necessary

end

return false --return false if creating old version stuff wasn't necessary
