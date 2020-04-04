local CacheHelper = {}
CacheHelper.Version = 1

--[[

Cache Helper v1
by piber

Make sure this is located in MOD/scripts/cachehelper.lua otherwise it wont load properly!

Do not edit this script file as it could conflict with the release version of this file used by other mods. If you find a bug or need to something changed, let me know.

]]

--create the mod
local CacheHelperMod = RegisterMod("Cache Helper", 1)

CacheHelper.Game = Game()

CacheHelper.Level = CacheHelper.Game:GetLevel()
CacheHelper.Room = CacheHelper.Game:GetRoom()

CacheHelper.ItemPool = CacheHelper.Game:GetItemPool()
CacheHelper.ItemConfig = Isaac.GetItemConfig()

CacheHelper.Music = MusicManager()
CacheHelper.SFX = SFXManager()

CacheHelper.Seeds = CacheHelper.Game:GetSeeds()

CacheHelper.Players = {}
CacheHelper.Player = nil

CacheHelper.VecZero = Vector(0,0)
CacheHelper.VecZeroOne = Vector(0,1)
CacheHelper.VecOneZero = Vector(1,0)
CacheHelper.VecOne = Vector(1,1)

CacheHelper.Color =        Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0)
CacheHelper.ColorBlack =   Color(0.0, 0.0, 0.0, 1.0, 0, 0, 0)
CacheHelper.ColorRed =     Color(1.0, 0.0, 0.0, 1.0, 0, 0, 0)
CacheHelper.ColorGreen =   Color(0.0, 1.0, 0.0, 1.0, 0, 0, 0)
CacheHelper.ColorBlue =    Color(0.0, 0.0, 1.0, 1.0, 0, 0, 0)
CacheHelper.ColorYellow =  Color(1.0, 1.0, 0.0, 1.0, 0, 0, 0)
CacheHelper.ColorMagenta = Color(1.0, 0.0, 1.0, 1.0, 0, 0, 0)
CacheHelper.ColorCyan =    Color(0.0, 1.0, 1.0, 1.0, 0, 0, 0)

CacheHelper.ColorHalf =        Color(1.0, 1.0, 1.0, 0.5, 0, 0, 0)
CacheHelper.ColorHalfBlack =   Color(0.0, 0.0, 0.0, 0.5, 0, 0, 0)
CacheHelper.ColorHalfRed =     Color(1.0, 0.0, 0.0, 0.5, 0, 0, 0)
CacheHelper.ColorHalfGreen =   Color(0.0, 1.0, 0.0, 0.5, 0, 0, 0)
CacheHelper.ColorHalfBlue =    Color(0.0, 0.0, 1.0, 0.5, 0, 0, 0)
CacheHelper.ColorHalfYellow =  Color(1.0, 1.0, 0.0, 0.5, 0, 0, 0)
CacheHelper.ColorHalfMagenta = Color(1.0, 0.0, 1.0, 0.5, 0, 0, 0)
CacheHelper.ColorHalfCyan =    Color(0.0, 1.0, 1.0, 0.5, 0, 0, 0)

CacheHelper.ColorInvis =        Color(1.0, 1.0, 1.0, 0.0, 0, 0, 0)
CacheHelper.ColorInvisBlack =   Color(0.0, 0.0, 0.0, 0.0, 0, 0, 0)
CacheHelper.ColorInvisRed =     Color(1.0, 0.0, 0.0, 0.0, 0, 0, 0)
CacheHelper.ColorInvisGreen =   Color(0.0, 1.0, 0.0, 0.0, 0, 0, 0)
CacheHelper.ColorInvisBlue =    Color(0.0, 0.0, 1.0, 0.0, 0, 0, 0)
CacheHelper.ColorInvisYellow =  Color(1.0, 1.0, 0.0, 0.0, 0, 0, 0)
CacheHelper.ColorInvisMagenta = Color(1.0, 0.0, 1.0, 0.0, 0, 0, 0)
CacheHelper.ColorInvisCyan =    Color(0.0, 1.0, 1.0, 0.0, 0, 0, 0)

CacheHelper.KColor =        KColor(1.0, 1.0, 1.0, 1.0)
CacheHelper.KColorBlack =   KColor(0.0, 0.0, 0.0, 1.0)
CacheHelper.KColorRed =     KColor(1.0, 0.0, 0.0, 1.0)
CacheHelper.KColorGreen =   KColor(0.0, 1.0, 0.0, 1.0)
CacheHelper.KColorBlue =    KColor(0.0, 0.0, 1.0, 1.0)
CacheHelper.KColorYellow =  KColor(1.0, 1.0, 0.0, 1.0)
CacheHelper.KColorMagenta = KColor(1.0, 0.0, 1.0, 1.0)
CacheHelper.KColorCyan =    KColor(0.0, 1.0, 1.0, 1.0)

CacheHelper.KColorHalf =        KColor(1.0, 1.0, 1.0, 0.5)
CacheHelper.KColorHalfBlack =   KColor(0.0, 0.0, 0.0, 0.5)
CacheHelper.KColorHalfRed =     KColor(1.0, 0.0, 0.0, 0.5)
CacheHelper.KColorHalfGreen =   KColor(0.0, 1.0, 0.0, 0.5)
CacheHelper.KColorHalfBlue =    KColor(0.0, 0.0, 1.0, 0.5)
CacheHelper.KColorHalfYellow =  KColor(1.0, 1.0, 0.0, 0.5)
CacheHelper.KColorHalfMagenta = KColor(1.0, 0.0, 1.0, 0.5)
CacheHelper.KColorHalfCyan =    KColor(0.0, 1.0, 1.0, 0.5)

CacheHelper.KColorInvis =        KColor(1.0, 1.0, 1.0, 0.0)
CacheHelper.KColorInvisBlack =   KColor(0.0, 0.0, 0.0, 0.0)
CacheHelper.KColorInvisRed =     KColor(1.0, 0.0, 0.0, 0.0)
CacheHelper.KColorInvisGreen =   KColor(0.0, 1.0, 0.0, 0.0)
CacheHelper.KColorInvisBlue =    KColor(0.0, 0.0, 1.0, 0.0)
CacheHelper.KColorInvisYellow =  KColor(1.0, 1.0, 0.0, 0.0)
CacheHelper.KColorInvisMagenta = KColor(1.0, 0.0, 1.0, 0.0)
CacheHelper.KColorInvisCyan =    KColor(0.0, 1.0, 1.0, 0.0)

function CacheHelper.ReCacheData()
	
	CacheHelper.Level = CacheHelper.Game:GetLevel()
	CacheHelper.Room = CacheHelper.Game:GetRoom()
	
	CacheHelper.ItemPool = CacheHelper.Game:GetItemPool()
	
	CacheHelper.Seeds = CacheHelper.Game:GetSeeds()
	
	CacheHelper.ReCachePlayers()
	
end

function CacheHelper.ReCachePlayers()
	
	CacheHelper.Players = {}
	for i=1, CacheHelper.Game:GetNumPlayers() do
		CacheHelper.Players[i] = Isaac.GetPlayer(i-1)
	end
	CacheHelper.Player = CacheHelper.Players[1]
	
end

CacheHelperMod:AddCallback(ModCallbacks.MC_POST_RENDER, CacheHelper.ReCacheData)
CacheHelperMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, CacheHelper.ReCacheData)
CacheHelperMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, CacheHelper.ReCachePlayers)

return CacheHelper
