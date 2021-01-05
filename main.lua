--this script handles saving for the standalone version of mod config menu

require("scripts.customcallbacks")

--create the mod
local mod = RegisterMod("Mod Config Menu Standalone", 1)

--require some lua libraries
local SaveHelper = require("scripts.savehelper")
local MCM = require("scripts.modconfig")

--add MCM's save to savehelper
SaveHelper.AddMod(mod)
SaveHelper.DefaultGameSave(mod, {
	ModConfigSave = false
})

--get and apply the mcm save when savehelper saves and loads data
mod:AddCustomCallback(CustomCallbacks.SH_PRE_MOD_SAVE, function(_, modRef, saveData)

	local mcmSave = MCM.GetSave()
	saveData.ModConfigSave = mcmSave
	
end, mod.Name)

mod:AddCustomCallback(CustomCallbacks.SH_POST_MOD_LOAD, function(_, modRef, saveData)

	MCM.LoadSave(saveData.ModConfigSave)
	
end, mod.Name)

--OLD VERSION COMPATIBILITY
-- require("scripts.modconfigoldcompatibility")