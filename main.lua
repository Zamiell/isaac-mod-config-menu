--this script handles saving for the standalone version of mod config menu

--load filepath helper
require("scripts/filepathhelper")
dofile("scripts/filepathhelper")

--load some scripts
dofile("scripts/customcallbacks")
dofile("scripts/savehelper")

--create the mod
local mod = RegisterMod("Mod Config Menu Standalone", 1)

--load mod config menu

--we load it like this instead of using dofile because the game caches the require function
require("scripts.modconfig")

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

	ModConfigMenu.LoadSave(saveData.ModConfigSave)
	
	--OLD VERSION COMPATIBILITY
	if ModConfigMenu.Config["Mod Config Menu"].CompatibilityLayer and not ModConfigMenu.CompatibilityMode then
		dofile("scripts/modconfigoldcompatibility")
	end
	
end, mod.Name)

SaveHelper.Load(mod)
