--this script handles saving for the standalone version of mod config menu
local json = require("json")

--create the mod
local mod = RegisterMod("Mod Config Menu Standalone", 1)

ModConfigMenu = {}
ModConfigMenu.StandaloneMod = mod

--load mod config menu
require("scripts.modconfig")

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function(_, p)
	local TotPlayers = #Isaac.FindByType(EntityType.ENTITY_PLAYER) -- Change to Isaac.CountEntities() when they fix it (without the #).
	if TotPlayers == 0 then
		ModConfigMenu.SaveData = json.decode(Isaac.LoadModData(mod))
		mod:SaveData(json.encode(ModConfigMenu.Config))
	end
end)

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function(_)
	mod:SaveData(json.encode(ModConfigMenu.Config))
end)