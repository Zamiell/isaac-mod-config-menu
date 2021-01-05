------------------------------------------------------------------------------
--                   IMPORTANT:  DO NOT EDIT THIS FILE!!!                   --
------------------------------------------------------------------------------
-- This file relies on other versions of itself being the same.             --
-- If you need something in this file changed, please let the creator know! --
------------------------------------------------------------------------------

-- CODE STARTS BELOW --


-------------
-- version --
-------------
local fileVersion = 0

--prevent older/same version versions of this script from loading
if CustomCallbackHelper and CustomCallbackHelper.Version >= fileVersion then

	return CustomCallbackHelper

end

local recreateCondensedCallbacks = false
if not CustomCallbackHelper then

	CustomCallbackHelper = {}
	CustomCallbackHelper.Version = fileVersion
	
elseif CustomCallbackHelper.Version < fileVersion then

	local oldVersion = CustomCallbackHelper.Version
	
	-- handle old versions

	CustomCallbackHelper.Version = fileVersion

end


-----------
-- setup --
-----------
CustomCallbackHelper.Mod = CustomCallbackHelper.Mod or RegisterMod("Callback Merger", 1)


--------------------------
-- custom callback enum --
--------------------------
--use these callbacks with CustomCallbackHelper.AddCallback(modRef, callbackID, callbackFunction, extraVar1, extraVar2, etc)
CustomCallbacks = CustomCallbacks or {}

--PRE/POST ADD CUSTOM CALLBACK
--custom callback functions that run when a callback gets added through callback helper's custom callback function (crazy huh?)
--specify a callback id to make your code trigger for only that specific callback
--in PRE you can return false to prevent the callback from being added
--function(modRef, callbackID, callbackFunction, extraVarTable)
CustomCallbacks.CCH_PRE_ADD_CUSTOM_CALLBACK = 1
CustomCallbacks.CCH_POST_ADD_CUSTOM_CALLBACK = 2

--GAME START
--meant to be used in favor of MC_POST_GAME_STARTED, because that callback isnt the first callback to be triggered
--triggers on the first instance of MC_POST_PLAYER_INIT, the first callback to be called when a game starts
--makes sure to not trigger on further instances of MC_POST_PLAYER_INIT
--checks the run counter for if the game is a continued game, if it is a continued game then isSaveGame will be true
--function(player, isSaveGame)
CustomCallbacks.CCH_GAME_STARTED = 3

--MODS LOADED
--triggered on the first call to MC_INPUT_ACTION, which can trigger in the main menu
--use this to have code that runs after all mod init code has ran, to handle mod intercompatibility
--function()
CustomCallbacks.CCH_MODS_LOADED = 4


-----------------------------
-- call callbacks function --
-----------------------------
--functionToHandleCallbacks is a function that takes what the mod's callback function has returned
--return true within the functionToHandleCallbacks callback to cancel all future functions
--this function returns true if the callbacks were cancelled, otherwise it returns nothing
function CustomCallbackHelper.CallCallbacks(callbackId, functionToHandleCallbacks, args, extraArgs)

	if type(args) ~= "table" then
		args = {args}
	end

	if type(extraArgs) ~= "table" then
		extraArgs = {extraArgs}
	end

	if CustomCallbackHelper.Callbacks[callbackId] then

		for _, callbackData in ipairs(CustomCallbackHelper.Callbacks[callbackId]) do
		
			local extraVarsMatch = false
			if not callbackData.extraVariables or #callbackData.extraVariables == 0 then
			
				extraVarsMatch = true
				
			elseif #extraArgs > 0 then
			
				for extraVarIndex, extraVar in ipairs(callbackData.extraVariables) do
				
					if extraVar == extraArgs[extraVarIndex] then
						extraVarsMatch = true
					else
						extraVarsMatch = false
						break
					end
				
				end
			
			end
		
			if extraVarsMatch then
			
				local returned = callbackData.functionToCall(callbackData.modReference, table.unpack(args))
				
				local handlerReturned = nil
				if type(functionToHandleCallbacks) == "function" then
					handlerReturned = functionToHandleCallbacks(returned)
				end
				
				if handlerReturned then
					return true
				end
				
			end
			
		end
		
	end
	
end


---------------------------
-- add callback function --
---------------------------
CustomCallbackHelper.RegisteredMods = CustomCallbackHelper.RegisteredMods or {}
CustomCallbackHelper.Callbacks = CustomCallbackHelper.Callbacks or {}
function CustomCallbackHelper.AddCallback(mod, callbackId, fn, ...)

	if type(mod) ~= "table" then
		error("CustomCallbackHelper.AddCallback Error: No valid mod reference provided", 3)
	end
	if type(callbackId) ~= "number" then
		error("CustomCallbackHelper.AddCallback Error: No valid callback ID provided", 3)
	end
	if type(fn) ~= "function" then
		error("CustomCallbackHelper.AddCallback Error: No valid callback function provided", 3)
	end
	
	local args = {...}
	
	--CCH_PRE_ADD_CUSTOM_CALLBACK
	local cancelCallback = nil
	
	CustomCallbackHelper.CallCallbacks
	(
		CustomCallbacks.CCH_PRE_ADD_CUSTOM_CALLBACK, --callback id
		function(returned) --function to handle it
		
			if returned == false then
				cancelCallback = true
				return true
			end
		
		end,
		{mod, callbackId, fn, args}, --args to send
		callbackId --extra variable
	)
	
	if cancelCallback then
		return
	end
	
	CustomCallbackHelper.Callbacks[callbackId] = CustomCallbackHelper.Callbacks[callbackId] or {}
	CustomCallbackHelper.Callbacks[callbackId][#CustomCallbackHelper.Callbacks[callbackId]+1] = {modReference = mod, functionToCall = fn, extraVariables = args}
	
	--CCH_POST_ADD_CUSTOM_CALLBACK
	CustomCallbackHelper.CallCallbacks
	(
		CustomCallbacks.CCH_POST_ADD_CUSTOM_CALLBACK, --callback id
		nil, --function to handle it
		{mod, callbackId, fn, args}, --args to send
		callbackId --extra variable
	)
	
end


------------------------------
-- remove callback function --
------------------------------
function CustomCallbackHelper.RemoveCallback(mod, callbackId, fn)

	if type(mod) ~= "table" then
		error("CustomCallbackHelper.RemoveCallback Error: No valid mod reference provided", 3)
	end
	if type(callbackId) ~= "number" then
		error("CustomCallbackHelper.RemoveCallback Error: No valid callback ID provided", 3)
	end
	if type(fn) ~= "function" then
		error("CustomCallbackHelper.RemoveCallback Error: No valid callback function provided", 3)
	end

	--extend the mod
	CustomCallbackHelper.ExtendMod(mod)

	--remove the callback from the callbacks table
	if CustomCallbackHelper.Callbacks[callbackId] then
	
		for i=#CustomCallbackHelper.Callbacks[callbackId], 1, -1 do
		
			local callbackData = CustomCallbackHelper.Callbacks[callbackId][i]
			
			if callbackData[1] == mod and callbackData[2] == fn then
			
				table.remove(CustomCallbackHelper.Callbacks[callbackId], i)
			
			end
			
		end
		
	end

end


-----------------------------------
-- remove all callbacks function --
-----------------------------------
function CustomCallbackHelper.RemoveAllCallbacks(mod)

	if type(mod) ~= "table" then
		error("CustomCallbackHelper.RemoveAllCallbacks Error: No valid mod reference provided", 2)
	end

	--extend the mod
	CustomCallbackHelper.ExtendMod(mod)

	--remove the callback from the callbacks table
	for _,callbacks in pairs(CustomCallbackHelper.Callbacks) do
	
		for i=#callbacks, 1, -1 do
		
			local callbackData = callbacks[i]
			
			if callbackData[1] == mod then
			
				table.remove(callbacks, i)
			
			end
			
		end
		
	end

end


----------------
-- extend mod --
----------------
function CustomCallbackHelper.ExtendMod(mod)

	--check if the mod is already in the table
	local modAlreadyRegistered = false
	for i=1, #CustomCallbackHelper.RegisteredMods do
		
		if CustomCallbackHelper.RegisteredMods[i] == mod then
			modAlreadyRegistered = true
			break
		end
		
	end
	
	--add mod to registered mods table
	if not modAlreadyRegistered then
		CustomCallbackHelper.RegisteredMods[#CustomCallbackHelper.RegisteredMods+1] = mod
	end
	
	if not mod.CustomCallbackHelperExtended or mod.CustomCallbackHelperExtended < fileVersion then
		
		mod.CustomCallbackHelperExtended = fileVersion
		
		--AddCustomCallback
		mod.AddCustomCallback = function(self, callbackId, fn, ...)
			
			CustomCallbackHelper.AddCallback(self, callbackId, fn, ...)
			
		end
		
		--RemoveCustomCallback
		mod.RemoveCustomCallback = function(self, callbackId, fn)
		
			CustomCallbackHelper.RemoveCallback(self, callbackId, fn)
			
		end
	
	end
	
end

--override RegisterMod to add AddCustomCallback function
CustomCallbackHelper.OldRegisterMod = CustomCallbackHelper.OldRegisterMod or Isaac.RegisterMod
function CustomCallbackHelper.RegisterMod(mod, modname, apiversion)

	--check if a mod that shares this mod's name is already in the table, and remove all of its callbacks if it is
	--helps handle luamod better
	for i=#CustomCallbackHelper.RegisteredMods, 1, -1 do
		
		if CustomCallbackHelper.RegisteredMods[i].Name == mod.Name then
		
			CustomCallbackHelper.RemoveAllCallbacks(CustomCallbackHelper.RegisteredMods[i])
			
			table.remove(CustomCallbackHelper.RegisteredMods, i)
			
		end
		
	end
	
	--call the old register mod function
	--pcall to catch any errors
	local modRegistered, returned = pcall(CustomCallbackHelper.OldRegisterMod, mod, modname, apiversion)
	
	--erroring
	if not modRegistered then
	
		returned = string.gsub(returned, "customcallbackhelper.OldRegisterMod", "RegisterMod")
		error(returned, 2)
		
	end
	
	if type(mod) == "table" then
	
		--extend the mod
		CustomCallbackHelper.ExtendMod(mod)

	end
	
end
Isaac.RegisterMod = CustomCallbackHelper.RegisterMod


------------------
-- game started --
------------------
local firstPlayerInited = false
CustomCallbackHelper.Mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function(_, player) --player init is the first callback to trigger, before game started, new level, new room, etc

	if not firstPlayerInited then
	
		firstPlayerInited = true
		
		local game = Game()
		
		local isSaveGame = false
		if game.TimeCounter > 0 then
			isSaveGame = true
		end
		
		--CCH_GAME_STARTED
		CustomCallbackHelper.CallCallbacks
		(
			CustomCallbacks.CCH_GAME_STARTED, --callback id
			nil, --function to handle it
			{player, isSaveGame} --args to send
		)
		
	end
	
end)
CustomCallbackHelper.Mod:AddCallback(ModCallbacks.MC_POST_GAME_END, function(_, gameOver)
	firstPlayerInited = false
end)
CustomCallbackHelper.Mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function(_, shouldSave)
	firstPlayerInited = false
end)


-----------------
-- mods loaded --
-----------------
local firstCallbackTriggered = false
CustomCallbackHelper.Mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, function() --input action can trigger on the main menu, before a run starts

	if not firstCallbackTriggered then
	
		firstCallbackTriggered = true
		
		--CCH_MODS_LOADED
		CustomCallbackHelper.CallCallbacks(CustomCallbacks.CCH_MODS_LOADED)
		
	end
	
end)


return CustomCallbackHelper
