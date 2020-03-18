local SaveHelper = {}
SaveHelper.Version = 1

--[[

SAVE HELPER v1
by piber

Make sure this is located in MOD/scripts/savehelper.lua otherwise it wont load properly!

Do not edit this script file as it could conflict with the release version of this file used by other mods. If you find a bug or need to something changed, let me know.

-------

REQUIREMENTS:
- CallbackHelper
- TableHelper

]]

--create the mod
local SaveHelperMod = RegisterMod("Cache Helper", 1)

--require some lua libraries
local json = require("json")
local CallbackHelper = require("scripts.callbackhelper")
local TableHelper = require("scripts.tablehelper")


--------------------
--CUSTOM CALLBACKS--
--------------------

--triggered before a mod saves its data
--function(modref, savedata)
--extra variable is the desired mod reference to only run your code on
--return false to prevent the save from being saved
CallbackHelper.Callbacks.SH_PRE_MOD_SAVE = 1200

--triggered after a mod saves its data
--function(modref, savedata)
--extra variable is the desired mod reference to only run your code on
CallbackHelper.Callbacks.SH_POST_MOD_SAVE = 1201

--triggered before a mod loads its data
--function(modref, savedata)
--extra variable is the desired mod reference to only run your code on
--return false to prevent the save from being loaded
CallbackHelper.Callbacks.SH_PRE_MOD_LOAD = 1202

--triggered after a mod loads its data
--function(modref, savedata)
--extra variable is the desired mod reference to only run your code on
CallbackHelper.Callbacks.SH_POST_MOD_LOAD = 1202


--------------
--SET UP MOD--
--------------
SaveHelper.ModsToSave = {}
function SaveHelper.AddMod(modRef)

	modRef.SaveHelper_DefaultSaveData = modRef.SaveHelper_DefaultSaveData or {}
	modRef.SaveHelper_DefaultSaveData.Run = modRef.SaveHelper_DefaultSaveData.Run or {}
	modRef.SaveHelper_DefaultSaveData.Run.Level = modRef.SaveHelper_DefaultSaveData.Run.Level or {}
	modRef.SaveHelper_DefaultSaveData.Run.Level.Room = modRef.SaveHelper_DefaultSaveData.Run.Level.Room or {}

	modRef.SaveHelper_SaveData = modRef.SaveHelper_SaveData or {}
	modRef.SaveHelper_SaveData.Run = modRef.SaveHelper_SaveData.Run or {}
	modRef.SaveHelper_SaveData.Run.Level = modRef.SaveHelper_SaveData.Run.Level or {}
	modRef.SaveHelper_SaveData.Run.Level.Room = modRef.SaveHelper_SaveData.Run.Level.Room or {}
	
	SaveHelper.ModsToSave[#SaveHelper.ModsToSave+1] = modRef
	
end

-----------------------------
--SET/GET DEFAULT SAVE DATA--
-----------------------------
function SaveHelper.DefaultGameSave(modRef, saveTable)
	
	if type(saveTable) == "table" then
	
		modRef.SaveHelper_DefaultSaveData = saveTable
		
		modRef.SaveHelper_DefaultSaveData.Run = modRef.SaveHelper_DefaultSaveData.Run or {}
		modRef.SaveHelper_DefaultSaveData.Run.Level = modRef.SaveHelper_DefaultSaveData.Run.Level or {}
		modRef.SaveHelper_DefaultSaveData.Run.Level.Room = modRef.SaveHelper_DefaultSaveData.Run.Level.Room or {}
		
	end
	
	return modRef.SaveHelper_DefaultSaveData
	
end

function SaveHelper.DefaultRunSave(modRef, saveTable)
	
	if type(saveTable) == "table" then
	
		modRef.SaveHelper_DefaultSaveData = modRef.SaveHelper_DefaultSaveData or {}
		
		modRef.SaveHelper_DefaultSaveData.Run = saveTable
		
		modRef.SaveHelper_DefaultSaveData.Run.Level = modRef.SaveHelper_DefaultSaveData.Run.Level or {}
		modRef.SaveHelper_DefaultSaveData.Run.Level.Room = modRef.SaveHelper_DefaultSaveData.Run.Level.Room or {}
		
	end
	
	return modRef.SaveHelper_DefaultSaveData.Run
	
end

function SaveHelper.DefaultLevelSave(modRef, saveTable)
	
	if type(saveTable) == "table" then
	
		modRef.SaveHelper_DefaultSaveData = modRef.SaveHelper_DefaultSaveData or {}
		modRef.SaveHelper_DefaultSaveData.Run = modRef.SaveHelper_DefaultSaveData.Run or {}
		
		modRef.SaveHelper_DefaultSaveData.Run.Level = saveTable
		
		modRef.SaveHelper_DefaultSaveData.Run.Level.Room = modRef.SaveHelper_DefaultSaveData.Run.Level.Room or {}
		
	end
	
	return modRef.SaveHelper_DefaultSaveData.Run.Level
	
end

function SaveHelper.DefaultRoomSave(modRef, saveTable)
	
	if type(saveTable) == "table" then
	
		modRef.SaveHelper_DefaultSaveData = modRef.SaveHelper_DefaultSaveData or {}
		modRef.SaveHelper_DefaultSaveData.Run = modRef.SaveHelper_DefaultSaveData.Run or {}
		modRef.SaveHelper_DefaultSaveData.Run.Level = modRef.SaveHelper_DefaultSaveData.Run.Level or {}
		
		modRef.SaveHelper_DefaultSaveData.Run.Level.Room = saveTable
		
	end
	
	return modRef.SaveHelper_DefaultSaveData.Run.Level.Room
	
end


----------------------------
--SET/GET ACTIVE SAVE DATA--
----------------------------
function SaveHelper.GameSave(modRef, saveTable)
	
	if type(saveTable) == "table" then
	
		modRef.SaveHelper_SaveData = saveTable
		
		modRef.SaveHelper_SaveData.Run = modRef.SaveHelper_SaveData.Run or {}
		modRef.SaveHelper_SaveData.Run.Level = modRef.SaveHelper_SaveData.Run.Level or {}
		modRef.SaveHelper_SaveData.Run.Level.Room = modRef.SaveHelper_SaveData.Run.Level.Room or {}
		
	end
	
	return modRef.SaveHelper_SaveData
	
end

function SaveHelper.RunSave(modRef, saveTable)
	
	if type(saveTable) == "table" then
		
		modRef.SaveHelper_SaveData = modRef.SaveHelper_SaveData or {}
		
		modRef.SaveHelper_SaveData.Run = saveTable
		
		modRef.SaveHelper_SaveData.Run.Level = modRef.SaveHelper_SaveData.Run.Level or {}
		modRef.SaveHelper_SaveData.Run.Level.Room = modRef.SaveHelper_SaveData.Run.Level.Room or {}
		
	end
	
	return modRef.SaveHelper_SaveData.Run
	
end

function SaveHelper.LevelSave(modRef, saveTable)
	
	if type(saveTable) == "table" then
	
		modRef.SaveHelper_SaveData = modRef.SaveHelper_SaveData or {}
		modRef.SaveHelper_SaveData.Run = modRef.SaveHelper_SaveData.Run or {}
	
		modRef.SaveHelper_SaveData.Run.Level = saveTable
		
		modRef.SaveHelper_SaveData.Run.Level.Room = modRef.SaveHelper_SaveData.Run.Level.Room or {}
		
	end
	
	return modRef.SaveHelper_SaveData.Run.Level
	
end

function SaveHelper.RoomSave(modRef, saveTable)
	
	if type(saveTable) == "table" then
	
		modRef.SaveHelper_SaveData = modRef.SaveHelper_SaveData or {}
		modRef.SaveHelper_SaveData.Run = modRef.SaveHelper_SaveData.Run or {}
		modRef.SaveHelper_SaveData.Run.Level = modRef.SaveHelper_SaveData.Run.Level or {}
		
		modRef.SaveHelper_SaveData.Run.Level.Room = saveTable
		
	end
	
	return modRef.SaveHelper_SaveData.Run.Level.Room
	
end


----------------------------
--RESESET ACTIVE SAVE DATA--
----------------------------
function SaveHelper.ResetGameSave(modRef)

	local defaultSave = TableHelper.CopyTable(SaveHelper.DefaultGameSave(modRef))
	return SaveHelper.GameSave(modRef, defaultSave)

end

function SaveHelper.ResetRunSave(modRef)

	local defaultSave = TableHelper.CopyTable(SaveHelper.DefaultRunSave(modRef))
	return SaveHelper.RunSave(modRef, defaultSave)
	
end

function SaveHelper.ResetLevelSave(modRef)

	local defaultSave = TableHelper.CopyTable(SaveHelper.DefaultLevelSave(modRef))
	return SaveHelper.LevelSave(modRef, defaultSave)
	
end

function SaveHelper.ResetRoomSave(modRef)

	local defaultSave = TableHelper.CopyTable(SaveHelper.DefaultRoomSave(modRef))
	return SaveHelper.RoomSave(modRef, defaultSave)
	
end


---------------------
--TRIGGER SAVE/LOAD--
---------------------

function SaveHelper.Save(modRef)
	
	local saveData = TableHelper.CopyTable(SaveHelper.DefaultGameSave(modRef))
	saveData = TableHelper.FillTable(saveData, SaveHelper.GameSave(modRef))
	
	--SH_PRE_MOD_SAVE
	local cancelSave = false
	
	CallbackHelper.CallCallbacks
	(
		CallbackHelper.Callbacks.SH_PRE_MOD_SAVE, --callback id
		function(returned) --function to handle it
		
			if returned == false then
				cancelSave = true
				return true
			end
		
		end,
		{modRef, saveData}, --args to send
		modRef --extra variable
	)
	
	if cancelSave then
		return
	end
	
	modRef:SaveData(json.encode(saveData))
	
	--SH_POST_MOD_SAVE
	CallbackHelper.CallCallbacks
	(
		CallbackHelper.Callbacks.SH_POST_MOD_SAVE, --callback id
		nil, --function to handle it
		{modRef, saveData}, --args to send
		modRef --extra variable
	)
	
	return saveData
	
end

function SaveHelper.Load(modRef)

	local saveData = TableHelper.CopyTable(SaveHelper.DefaultGameSave(modRef))
	
	if modRef:HasData() then
		local loadData = json.decode(modRef:LoadData())
		saveData = TableHelper.FillTable(saveData, loadData)
	end
	
	--SH_PRE_MOD_LOAD
	local cancelLoad = false
	
	CallbackHelper.CallCallbacks
	(
		CallbackHelper.Callbacks.SH_PRE_MOD_LOAD, --callback id
		function(returned) --function to handle it
		
			if returned == false then
				cancelLoad = true
				return true
			end
		
		end,
		{modRef, saveData}, --args to send
		modRef --extra variable
	)
	
	if cancelLoad then
		return
	end
	
	SaveHelper.GameSave(modRef, TableHelper.CopyTable(saveData))
	
	--SH_POST_MOD_LOAD
	CallbackHelper.CallCallbacks
	(
		CallbackHelper.Callbacks.SH_POST_MOD_LOAD, --callback id
		nil, --function to handle it
		{modRef, saveData}, --args to send
		modRef --extra variable
	)
	
end


-------------
--CALLBACKS--
-------------

local skipNextLevelClear = false
local skipNextRoomClear = false
CallbackHelper.AddCallback(SaveHelperMod, CallbackHelper.Callbacks.CH_GAME_START, function(_, player, isSaveGame)

	skipNextLevelClear = true
	skipNextRoomClear = true
	
	for _, modRef in ipairs(SaveHelper.ModsToSave) do

		SaveHelper.Load(modRef)
		
		if not isSaveGame then
			SaveHelper.ResetRunSave(modRef)
		end

		SaveHelper.Save(modRef)
	
	end

end)

SaveHelperMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()

	if not skipNextLevelClear then
	
		for _, modRef in ipairs(SaveHelper.ModsToSave) do
	
			SaveHelper.ResetLevelSave(modRef)
			
			SaveHelper.Save(modRef)
			
		end
		
	end
	
	skipNextLevelClear = false
	
end)

SaveHelperMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()

	if not skipNextRoomClear then
	
		for _, modRef in ipairs(SaveHelper.ModsToSave) do
	
			SaveHelper.ResetRoomSave(modRef)
			
		end
		
	end
	
	skipNextRoomClear = false
	
end)

SaveHelperMod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function(_, shouldSave)
	
	for _, modRef in ipairs(SaveHelper.ModsToSave) do
		
		SaveHelper.Save(modRef)
		
	end
	
end)

return SaveHelper
