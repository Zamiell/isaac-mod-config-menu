--this script handles saving for the standalone version of mod config menu

--create the mod
local mod = RegisterMod("Mod Config Menu Standalone", 1)

ModConfigMenu = ModConfigMenu or {}
ModConfigMenu.StandaloneMod = mod

--load mod config menu
require("scripts.modconfig")
