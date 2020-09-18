--this script handles saving for the standalone version of mod config menu

--create the mod
local mod = RegisterMod("Mod Config Menu Standalone", 1)

--require some lua libraries
local CallbackHelper = require("scripts.callbackhelper")
local SaveHelper = require("scripts.savehelper")
local MCM = require("scripts.modconfig")

--add MCM's save to savehelper
SaveHelper.AddMod(mod)
SaveHelper.DefaultGameSave(mod, {
	ModConfigSave = false
})

--get and apply the mcm save when savehelper saves and loads data
CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.SH_PRE_MOD_SAVE, function(_, modRef, saveData)

	local mcmSave = MCM.GetSave()
	saveData.ModConfigSave = mcmSave
	
end, mod)

CallbackHelper.AddCallback(mod, CallbackHelper.Callbacks.SH_POST_MOD_LOAD, function(_, modRef, saveData)

	MCM.LoadSave(saveData.ModConfigSave)
	
end, mod)

--OLD VERSION COMPATIBILITY
-- require("scripts.modconfigoldcompatibility")