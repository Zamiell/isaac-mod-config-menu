local mod = RegisterMod("Mod Config Menu Standalone", 1)
local MCM = require("scripts.modconfig")

local game = Game()
local level = game:GetLevel()

local skipNextLevelSave = false
local firstPlayerInited = false
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function(_, player) --player init is the first callback to trigger, before game started, new level, new room, etc

	if not firstPlayerInited then
	
		skipNextLevelSave = true
		firstPlayerInited = true
	
		if mod:HasData() then
			MCM.LoadSave(mod:LoadData())
		end
		
	end
	
end)

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
	
	if not skipNextLevelSave then
	
		local saveData = MCM.GetSave()
		mod:SaveData(saveData)
		
	end
	
	skipNextLevelSave = false
	
end)

mod:AddCallback(ModCallbacks.MC_POST_GAME_END, function(_, gameOver)

	firstPlayerInited = false
	
	local saveData = MCM.GetSave()
	mod:SaveData(saveData)
	
end)

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function(_, shouldSave)

	firstPlayerInited = false
	
	local saveData = MCM.GetSave()
	mod:SaveData(saveData)
	
end)

--some handling to let old mods work
require("scripts.modconfigoldcompat")
