--this script adds globals to the global table that redirect into mod config menu functions, to add support for older mods that made use of these.

-------------------------
--OLD MOD COMPATIBILITY--
-------------------------

ModConfigMenu.CompatibilityMode = true

local cachedVectorsAndColors = {

	["VECTOR_ZERO"] = Vector(0,0),
	["VECTOR_ONE"] = Vector(1,1),

	["VECTOR_LEFT"] = Vector(-1,0),
	["VECTOR_UP"] = Vector(0,-1),
	["VECTOR_RIGHT"] = Vector(1,0),
	["VECTOR_DOWN"] = Vector(0,1),
	["VECTOR_UP_LEFT"] = Vector(-1,-1),
	["VECTOR_UP_RIGHT"] = Vector(1,-1),
	["VECTOR_DOWN_LEFT"] = Vector(-1,1),
	["VECTOR_DOWN_RIGHT"] = Vector(1,1),

	["COLOR_DEFAULT"] = Color(1,1,1,1,0,0,0),
	["COLOR_HALF"] = Color(1,1,1,0.5,0,0,0),
	["COLOR_INVISIBLE"] = Color(1,1,1,0,0,0,0),
	["KCOLOR_DEFAULT"] = KColor(1,1,1,1),
	["KCOLOR_HALF"] = KColor(1,1,1,0.5),
	["KCOLOR_INVISIBLE"] = KColor(1,1,1,0)
	
}

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
		
			local warn = "ModConfigMenu." .. key .. " is no longer used. Please update."
		
			Isaac.DebugString(warn)
			if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
				print(warn)
			end
		
			return fakeCachedDataToReturn[key]()
			
		end

		if cachedVectorsAndColors[key] then
		
			local warn = "ModConfigMenu." .. key .. " is no longer used. Please update."
		
			Isaac.DebugString(warn)
			if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
				print(warn)
			end
		
			return cachedVectorsAndColors[key]
			
		end

	end

})

local fakeConfigDefaultToReturn = {
	HudOffset = function() return ModConfigMenu.ConfigDefault["General"].HudOffset end,
	Overlays = function() return ModConfigMenu.ConfigDefault["General"].Overlays end,
	ChargeBars = function() return ModConfigMenu.ConfigDefault["General"].ChargeBars end,
	BigBooks = function() return ModConfigMenu.ConfigDefault["General"].BigBooks end,
}
local fakeConfigToReturn = {
	HudOffset = function() return ModConfigMenu.Config["General"].HudOffset end,
	Overlays = function() return ModConfigMenu.Config["General"].Overlays end,
	ChargeBars = function() return ModConfigMenu.Config["General"].ChargeBars end,
	BigBooks = function() return ModConfigMenu.Config["General"].BigBooks end,
}
ModConfigMenu.SetConfigMetatables = function()

	setmetatable(ModConfigMenu.ConfigDefault, {

		__index = function(this, key)

			if fakeConfigDefaultToReturn[key] then
		
				local warn = "ModConfigMenu.ConfigDefault." .. key .. " is no longer used. Please update to use ModConfigMenu.ConfigDefault.[\"General\"]." .. key .. " instead."
			
				Isaac.DebugString(warn)
				if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
					print(warn)
				end
			
				return fakeConfigDefaultToReturn[key]()
				
			end

		end

	})

	setmetatable(ModConfigMenu.Config, {

		__index = function(this, key)

			if fakeConfigToReturn[key] then
		
				local warn = "ModConfigMenu.Config." .. key .. " is no longer used. Please update to use ModConfigMenu.Config.[\"General\"]." .. key .. " instead."
			
				Isaac.DebugString(warn)
				if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
					print(warn)
				end
			
				return fakeConfigToReturn[key]()
				
			end

		end

	})
	
end

ModConfigMenu.SetConfigMetatables()

ModConfigMenuController = {}
setmetatable(ModConfigMenuController, {

	__index = function(this, key)

		if Controller and Controller[key] then
	
			local warn = "ModConfigMenuController." .. key .. " is no longer used. Please update to use Controller." .. key .. " instead. This enum is added by InputHelper."
		
			Isaac.DebugString(warn)
			if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
				print(warn)
			end
		
			return Controller[key]
			
		end

	end

})

ModConfigMenuKeyboardToString = {}
setmetatable(ModConfigMenuKeyboardToString, {

	__index = function(this, key)

		if InputHelper and InputHelper.KeyboardToString and InputHelper.KeyboardToString[key] then
	
			local warn = "ModConfigMenuKeyboardToString." .. key .. " is no longer used. Please update to use InputHelper.KeyboardToString." .. key .. " instead."
		
			Isaac.DebugString(warn)
			if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
				print(warn)
			end
		
			return InputHelper.KeyboardToString[key]
			
		end

	end

})

ModConfigMenuControllerToString = {}
setmetatable(ModConfigMenuControllerToString, {

	__index = function(this, key)

		if InputHelper and InputHelper.ControllerToString and InputHelper.ControllerToString[key] then
	
			local warn = "ModConfigMenuControllerToString." .. key .. " is no longer used. Please update to use InputHelper.ControllerToString." .. key .. " instead."
		
			Isaac.DebugString(warn)
			if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
				print(warn)
			end
		
			return InputHelper.ControllerToString[key]
			
		end

	end

})

ModConfigMenuPopupGfx = {}
setmetatable(ModConfigMenuPopupGfx, {

	__index = function(this, key)

		if ModConfigMenu.PopupGfx[key] then
	
			local warn = "ModConfigMenuPopupGfx." .. key .. " is no longer used. Please update to use ModConfigMenu.PopupGfx." .. key .. " instead."
		
			Isaac.DebugString(warn)
			if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
				print(warn)
			end
		
			return ModConfigMenu.PopupGfx[key]
			
		end

	end

})

ModConfigMenuOptionType = {}
setmetatable(ModConfigMenuOptionType, {

	__index = function(this, key)

		if ModConfigMenu.OptionType[key] then
	
			local warn = "ModConfigMenuOptionType." .. key .. " is no longer used. Please update to use ModConfigMenu.OptionType." .. key .. " instead."
		
			Isaac.DebugString(warn)
			if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
				print(warn)
			end
		
			return ModConfigMenu.OptionType[key]
			
		end

	end

})

ModConfigMenuData = ModConfigMenu.MenuData

local oldRequire = require
local function newRequire(toRequire, ...)

	if toRequire == "scripts.callbackhelper" then
		toRequire = "scripts.customcallbacks"
	elseif toRequire == "scripts/callbackhelper" then
		toRequire = "scripts/customcallbacks"
	end
	
	local fileLoaded, returned = pcall(oldRequire, toRequire)
	
	if fileLoaded then
		return returned
	else
		error(returned, 2)
	end
	
end
require = newRequire

CustomCallbackHelper.Callbacks = CustomCallbackHelper.Callbacks or {}

CustomCallbackHelper.Callbacks.MCM_POST_MODIFY_HUD_OFFSET = 4300
ModConfigMenu.StandaloneMod:AddCustomCallback(CustomCallbacks.CCH_PRE_ADD_CUSTOM_CALLBACK, function(mod, modRef, callbackId, fn, args)
	
	local warn = "CallbackHelper.Callbacks.MCM_POST_MODIFY_HUD_OFFSET is no longer used. Please update to use CustomCallbacks.MCM_POST_MODIFY_SETTING with extra variables \"General\" and \"HudOffset\"."

	Isaac.DebugString(warn)
	if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
		print(warn)
	end
	
	modRef:AddCustomCallback(CustomCallbacks.MCM_POST_MODIFY_SETTING, function(modRef, settingTable, currentSetting)
		fn(modRef, currentSetting)
	end, "General", "HudOffset")
	
	return false
	
end, CustomCallbackHelper.Callbacks.MCM_POST_MODIFY_HUD_OFFSET)

CustomCallbackHelper.Callbacks.MCM_POST_MODIFY_OVERLAYS = 4301
ModConfigMenu.StandaloneMod:AddCustomCallback(CustomCallbacks.CCH_PRE_ADD_CUSTOM_CALLBACK, function(mod, modRef, callbackId, fn, args)
	
	local warn = "CallbackHelper.Callbacks.MCM_POST_MODIFY_HUD_OFFSET is no longer used. Please update to use CustomCallbacks.MCM_POST_MODIFY_SETTING with extra variables \"General\" and \"Overlays\"."

	Isaac.DebugString(warn)
	if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
		print(warn)
	end
	
	modRef:AddCustomCallback(CustomCallbacks.MCM_POST_MODIFY_SETTING, function(modRef, settingTable, currentSetting)
		fn(modRef, currentSetting)
	end, "General", "Overlays")
	
	return false
	
end, CustomCallbackHelper.Callbacks.MCM_POST_MODIFY_OVERLAYS)

CustomCallbackHelper.Callbacks.MCM_POST_MODIFY_CHARGE_BARS = 4302
ModConfigMenu.StandaloneMod:AddCustomCallback(CustomCallbacks.CCH_PRE_ADD_CUSTOM_CALLBACK, function(mod, modRef, callbackId, fn, args)
	
	local warn = "CallbackHelper.Callbacks.MCM_POST_MODIFY_HUD_OFFSET is no longer used. Please update to use CustomCallbacks.MCM_POST_MODIFY_SETTING with extra variables \"General\" and \"ChargeBars\"."

	Isaac.DebugString(warn)
	if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
		print(warn)
	end
	
	modRef:AddCustomCallback(CustomCallbacks.MCM_POST_MODIFY_SETTING, function(modRef, settingTable, currentSetting)
		fn(modRef, currentSetting)
	end, "General", "ChargeBars")
	
	return false
	
end, CustomCallbackHelper.Callbacks.MCM_POST_MODIFY_CHARGE_BARS)

CustomCallbackHelper.Callbacks.MCM_POST_MODIFY_BIG_BOOKS = 4303
ModConfigMenu.StandaloneMod:AddCustomCallback(CustomCallbacks.CCH_PRE_ADD_CUSTOM_CALLBACK, function(mod, modRef, callbackId, fn, args)
	
	local warn = "CallbackHelper.Callbacks.MCM_POST_MODIFY_HUD_OFFSET is no longer used. Please update to use CustomCallbacks.MCM_POST_MODIFY_SETTING with extra variables \"General\" and \"BigBooks\"."

	Isaac.DebugString(warn)
	if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
		print(warn)
	end
	
	modRef:AddCustomCallback(CustomCallbacks.MCM_POST_MODIFY_SETTING, function(modRef, settingTable, currentSetting)
		fn(modRef, currentSetting)
	end, "General", "BigBooks")
	
	return false
	
end, CustomCallbackHelper.Callbacks.MCM_POST_MODIFY_BIG_BOOKS)

ModConfigMenu.AddHudOffsetChangeCallback = function(functionToAdd)
	
	local warn = "ModConfigMenu.AddHudOffsetChangeCallback is no longer used. Please update to use mod:AddCustomCallback added by CustomCallbackHelper using CustomCallbacks.MCM_POST_MODIFY_SETTING with extra variables \"General\" and \"HudOffset\"."

	Isaac.DebugString(warn)
	if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
		print(warn)
	end
	
	ModConfigMenu.StandaloneMod:AddCustomCallback(CustomCallbacks.MCM_POST_MODIFY_SETTING, function(modRef, settingTable, currentSetting)
		functionToAdd(currentSetting)
	end, "General", "HudOffset")
	
end

ModConfigMenu.AddOverlayChangeCallback = function(functionToAdd)
	
	local warn = "ModConfigMenu.AddOverlayChangeCallback is no longer used. Please update to use mod:AddCustomCallback added by CustomCallbackHelper using CustomCallbacks.MCM_POST_MODIFY_SETTING with extra variables \"General\" and \"Overlays\"."

	Isaac.DebugString(warn)
	if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
		print(warn)
	end
	
	ModConfigMenu.StandaloneMod:AddCustomCallback(CustomCallbacks.MCM_POST_MODIFY_SETTING, function(modRef, settingTable, currentSetting)
		functionToAdd(currentSetting)
	end, "General", "Overlays")
	
end

ModConfigMenu.AddChargeBarChangeCallback = function(functionToAdd)
	
	local warn = "ModConfigMenu.AddChargeBarChangeCallback is no longer used. Please update to use mod:AddCustomCallback added by CustomCallbackHelper using CustomCallbacks.MCM_POST_MODIFY_SETTING with extra variables \"General\" and \"ChargeBars\"."

	Isaac.DebugString(warn)
	if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
		print(warn)
	end
	
	ModConfigMenu.StandaloneMod:AddCustomCallback(CustomCallbacks.MCM_POST_MODIFY_SETTING, function(modRef, settingTable, currentSetting)
		functionToAdd(currentSetting)
	end, "General", "ChargeBars")
	
end

ModConfigMenu.AddBigBookChangeCallback = function(functionToAdd)
	
	local warn = "ModConfigMenu.AddBigBookChangeCallback is no longer used. Please update to use mod:AddCustomCallback added by CustomCallbackHelper using CustomCallbacks.MCM_POST_MODIFY_SETTING with extra variables \"General\" and \"BigBooks\"."

	Isaac.DebugString(warn)
	if not ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer then
		print(warn)
	end
	
	ModConfigMenu.StandaloneMod:AddCustomCallback(CustomCallbacks.MCM_POST_MODIFY_SETTING, function(modRef, settingTable, currentSetting)
		functionToAdd(currentSetting)
	end, "General", "BigBooks")
	
end
