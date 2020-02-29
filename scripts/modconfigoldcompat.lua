local MCM = require("scripts.modconfig")

ModConfigMenu = {}
ModConfigMenu.Version = 13

ModConfigMenu.Config = MCM.Config

ModConfigMenuPopupGfx = MCM.PopupGfx
ModConfigMenuOptionType = MCM.OptionType

ModConfigMenu.SetOldCategoryInfo = function(category)
	MCM.UpdateCategory(category, {
		Info = {
			"This mod adds settings through",
			"an older method and may not work right"
		},
		IsOld = true
	})
end

ModConfigMenu.AddSetting = function(category, subcategory, settingTable)
	ModConfigMenu.SetOldCategoryInfo(category)
	return MCM.AddSetting(category, subcategory, settingTable)
end
ModConfigMenu.AddText = function(category, subcategory, text, color)
	ModConfigMenu.SetOldCategoryInfo(category)
	return MCM.AddText(category, subcategory, text, color)
end
ModConfigMenu.AddTitle = function(category, subcategory, text, color)
	ModConfigMenu.SetOldCategoryInfo(category)
	return MCM.AddTitle(category, subcategory, text, color)
end
ModConfigMenu.AddSpace = function(category, subcategory)
	ModConfigMenu.SetOldCategoryInfo(category)
	return MCM.AddSpace(category, subcategory)
end