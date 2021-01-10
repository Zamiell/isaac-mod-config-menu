--this script adds globals to the global table that redirect into mod config menu functions, to add support for older mods that made use of these.

-------------------------
--OLD MOD COMPATIBILITY--
-------------------------

ModConfigMenu.CompatibilityMode = true

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

if InputHelper then

	ModConfigMenuController = Controller
	ModConfigMenuKeyboardToString = InputHelper.KeyboardToString
	ModConfigMenuControllerToString = InputHelper.ControllerToString
	
end

ModConfigMenuPopupGfx = ModConfigMenu.PopupGfx
ModConfigMenuOptionType = ModConfigMenu.OptionType

ModConfigMenuData = ModConfigMenu.MenuData

ModConfigMenu.AddHudOffsetChangeCallback = function(functionToAdd)
	print("ModConfigMenu.AddHudOffsetChangeCallback doesn't work anymore.")
end

ModConfigMenu.AddOverlayChangeCallback = function(functionToAdd)
	print("ModConfigMenu.AddOverlayChangeCallback doesn't work anymore.")
end

ModConfigMenu.AddChargeBarChangeCallback = function(functionToAdd)
	print("ModConfigMenu.AddChargeBarChangeCallback doesn't work anymore.")
end

ModConfigMenu.AddBigBookChangeCallback = function(functionToAdd)
	print("ModConfigMenu.AddBigBookChangeCallback doesn't work anymore.")
end
