--this script handles saving for the standalone version of mod config menu

--load filepath helper
require("scripts/filepathhelper")
dofile("scripts/filepathhelper")

dofile("scripts/customcallbacks")

--require some lua libraries
local SaveHelper = require("scripts.savehelper")

--create the mod
local mod = RegisterMod("Mod Config Menu Standalone", 1)

--load mod config menu
dofile("scripts/modconfig")

if ModConfigMenu then

	ModConfigMenu.StandaloneMod = mod

	--add MCM's save to savehelper
	SaveHelper.AddMod(mod)
	SaveHelper.DefaultGameSave(mod, {
		ModConfigSave = false
	})

	if CustomCallbackHelper then
	
		--get and apply the mcm save when savehelper saves and loads data
		mod:AddCustomCallback(CustomCallbacks.SH_PRE_MOD_SAVE, function(_, modRef, saveData)

			local mcmSave = ModConfigMenu.GetSave()
			saveData.ModConfigSave = mcmSave
			
		end, mod.Name)

		mod:AddCustomCallback(CustomCallbacks.SH_POST_MOD_LOAD, function(_, modRef, saveData)

			ModConfigMenu.LoadSave(saveData.ModConfigSave)
			
		end, mod.Name)
	
	end

	--OLD VERSION COMPATIBILITY
	-- require("scripts.modconfigoldcompatibility")
	
end