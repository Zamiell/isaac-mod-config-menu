local mod = RegisterMod("mod config menu standalone", 1)
ModConfigMenuIsStandalone = true

local _, err = pcall(require, "scripts.modconfig")
err = tostring(err)
if not string.match(err, "attempt to call a nil value %(field 'ForceError'%)") then
	if string.match(err, "true") then
		err = "Error: require passed in modconfig"
	end
	error(err)
end

ModConfigMenuIsStandalone = nil
if ModConfigMenu then
	ModConfigMenu.StandaloneMod = true

	if ModConfigMenu.FinishedLoadingMessage then
		ModConfigMenu.FinishedLoadingMessage = "Mod Config Menu v" .. ModConfigMenu.Version .. " Standalone loaded!"
		Isaac.DebugString(ModConfigMenu.FinishedLoadingMessage)
		print(ModConfigMenu.FinishedLoadingMessage)
	end
end