--this script handles saving for the standalone version of mod config menu

--load filepath helper
require("scripts/filepathhelper")
dofile("scripts/filepathhelper")

--load some scripts
dofile("scripts/customcallbacks")
dofile("scripts/savehelper")

--create the mod
local mod = RegisterMod("Mod Config Menu Standalone", 1)

ModConfigMenu = ModConfigMenu or {}
ModConfigMenu.StandaloneMod = mod

--add MCM's save to savehelper
SaveHelper.AddMod(mod)
SaveHelper.DefaultGameSave(mod, {
	ModConfigSave = false
})

--get and apply the mcm save when savehelper saves and loads data
mod:AddCustomCallback(CustomCallbacks.SH_PRE_MOD_SAVE, function(_, modRef, saveData)

	local mcmSave = ModConfigMenu.GetSave()
	saveData.ModConfigSave = mcmSave
	
end, mod.Name)

mod:AddCustomCallback(CustomCallbacks.SH_POST_MOD_LOAD, function(_, modRef, saveData)

	local mcmSave = ModConfigMenu.LoadSave(saveData.ModConfigSave)
	
end, mod.Name)

--load mod config menu

--we load it like this instead of using dofile because the game caches the require function
require("scripts.modconfig")
dofile("scripts/modconfig")
