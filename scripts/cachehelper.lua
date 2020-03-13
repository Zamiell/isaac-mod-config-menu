local CacheHelper = {}
CacheHelper.Version = 1

--[[

Cache Helper v1
by piber

Make sure this is located in MOD/scripts/cachehelper.lua otherwise it wont load properly!

Do not edit this script file as it could conflict with the release version of this file used by other mods. If you find a bug or need to something changed, let me know.\

]]

--create the mod
local CacheHelperMod = RegisterMod("Cache Helper", 1)

function CacheHelper.ReCacheData()

	CacheHelper.Game = Game()
	
	CacheHelper.Level = CacheHelper.Game:GetLevel()
	CacheHelper.Room = CacheHelper.Game:GetRoom()
	
	CacheHelper.ItemPool = CacheHelper.Game:GetItemPool()
	CacheHelper.ItemConfig = Isaac.GetItemConfig()
	
	CacheHelper.Seeds = CacheHelper.Game:GetSeeds()
	CacheHelper.Music = MusicManager()
	CacheHelper.SFX = SFXManager()
	
	CacheHelper.Players = {}
	for i=1, CacheHelper.Game:GetNumPlayers() do
		CacheHelper.Players[i] = Isaac.GetPlayer(i-1)
	end
	CacheHelper.Player = CacheHelper.Players[1]
	
end

CacheHelper.ReCacheData()

CacheHelperMod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	CacheHelper.ReCacheData()
end)
CacheHelperMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	CacheHelper.ReCacheData()
end)
CacheHelperMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
	CacheHelper.ReCacheData()
end)
CacheHelperMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function()
	CacheHelper.ReCacheData()
end)

return CacheHelper
