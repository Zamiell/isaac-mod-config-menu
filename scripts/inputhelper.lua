local InputHelper = {}
InputHelper.Version = 0

--[[

INPUT HELPER v1
by piber

Make sure this is located in MOD/scripts/inputhelper.lua otherwise it wont load properly!

Do not edit this script file as it could conflict with the release version of this file used by other mods. If you find a bug or need to something changed, let me know.

]]

--create the mod
local InputHelperMod = RegisterMod("Input Helper", 1)


---------
--enums--
---------
InputHelper.Controller = {
	DPAD_LEFT = 0,
	DPAD_RIGHT = 1,
	DPAD_UP = 2,
	DPAD_DOWN = 3,
	BUTTON_A = 4,
	BUTTON_B = 5,
	BUTTON_X = 6,
	BUTTON_Y = 7,
	BUMPER_LEFT = 8,
	TRIGGER_LEFT = 9,
	STICK_LEFT = 10,
	BUMPER_RIGHT = 11,
	TRIGGER_RIGHT = 12,
	STICK_RIGHT = 13,
	BUTTON_BACK = 14,
	BUTTON_START = 15
}


----------------
--id to string--
----------------
InputHelper.KeyboardToString = {}
do
	for key,num in pairs(Keyboard) do
		local keyString = key
		
		local keyStart, keyEnd = string.find(keyString, "KEY_")
		keyString = string.sub(keyString, keyEnd+1, string.len(keyString))
		
		keyString = string.gsub(keyString, "_", " ")
		
		InputHelper.KeyboardToString[num] = keyString
	end
end

InputHelper.ControllerToString = {}
do
	for button,num in pairs(InputHelper.Controller) do
		local buttonString = button
		
		if string.match(buttonString, "BUTTON_") then
			local buttonStart, buttonEnd = string.find(buttonString, "BUTTON_")
			buttonString = string.sub(buttonString, buttonEnd+1, string.len(buttonString))
		end
		
		if string.match(buttonString, "BUMPER_") then
			local bumperStart, bumperEnd = string.find(buttonString, "BUMPER_")
			buttonString = string.sub(buttonString, bumperEnd+1, string.len(buttonString)) .. "_BUMPER"
		end
		
		if string.match(buttonString, "TRIGGER_") then
			local triggerStart, triggerEnd = string.find(buttonString, "TRIGGER_")
			buttonString = string.sub(buttonString, triggerEnd+1, string.len(buttonString)) .. "_TRIGGER"
		end
		
		if string.match(buttonString, "STICK_") then
			local stickStart, stickEnd = string.find(buttonString, "STICK_")
			buttonString = string.sub(buttonString, stickEnd+1, string.len(buttonString)) .. "_STICK"
		end
		
		buttonString = string.gsub(buttonString, "_", " ")
		
		InputHelper.ControllerToString[num] = buttonString
	end
end


-------------------------
--safe keyboard pressed--
-------------------------
--functions to use that work around a bug related to controller inputs
function InputHelper.KeyboardTriggered(key, controllerIndex)
	return Input.IsButtonTriggered(key, controllerIndex) and not Input.IsButtonTriggered(key % 32, controllerIndex)
end
function InputHelper.KeyboardPressed(key, controllerIndex)
	return Input.IsButtonPressed(key, controllerIndex) and not Input.IsButtonPressed(key % 32, controllerIndex)
end


--------------------------
--multiple button checks--
--------------------------
function InputHelper.MultipleActionTriggered(actions, controllerIndex)

	for i,action in pairs(actions) do
	
		for index=0, 4 do
		
			if controllerIndex ~= nil then
				index = controllerIndex
			end
			
			if Input.IsActionTriggered(action, index) then
				return action
			end
			
			if controllerIndex ~= nil then
				break
			end
			
		end
		
	end
	
	return nil
	
end

function InputHelper.MultipleActionPressed(actions, controllerIndex)

	for i,action in pairs(actions) do
	
		for index=0, 4 do
		
			if controllerIndex ~= nil then
				index = controllerIndex
			end
			
			if Input.IsActionPressed(action, index) then
				return action
			end
			
			if controllerIndex ~= nil then
				break
			end
			
		end
		
	end
	
	return nil
	
end

function InputHelper.MultipleButtonTriggered(buttons, controllerIndex)

	for i,button in pairs(buttons) do
	
		for index=0, 4 do
		
			if controllerIndex ~= nil then
				index = controllerIndex
			end
			
			if Input.IsButtonTriggered(button, index) then
				return button
			end
			
			if controllerIndex ~= nil then
				break
			end
			
		end
		
	end
	
	return nil
	
end

function InputHelper.MultipleButtonPressed(buttons, controllerIndex)

	for i,button in pairs(buttons) do
	
		for index=0, 4 do
		
			if controllerIndex ~= nil then
				index = controllerIndex
			end
			
			if Input.IsButtonPressed(button, index) then
				return button
			end
			
			if controllerIndex ~= nil then
				break
			end
			
		end
		
	end
	
	return nil
	
end

function InputHelper.MultipleKeyboardTriggered(keys, controllerIndex)

	for i,key in pairs(keys) do
	
		for index=0, 4 do
		
			if controllerIndex ~= nil then
				index = controllerIndex
			end
			
			if InputHelper.KeyboardTriggered(key, index) then
				return key
			end
			
			if controllerIndex ~= nil then
				break
			end
			
		end
		
	end
	
	return nil
	
end

function InputHelper.MultipleKeyboardPressed(keys, controllerIndex)

	for i,key in pairs(keys) do
	
		for index=0, 4 do
		
			if controllerIndex ~= nil then
				index = controllerIndex
			end
			
			if InputHelper.KeyboardPressed(key, index) then
				return key
			end
			
			if controllerIndex ~= nil then
				break
			end
			
		end
		
	end
	
	return nil
	
end


---------------
--force input--
---------------
local forcingActionTriggered = {}
function InputHelper.ForceActionTriggered(controllerIndex, buttonAction, value)

	forcingActionTriggered[controllerIndex] = forcingActionTriggered[controllerIndex] or {}
	forcingActionTriggered[controllerIndex][buttonAction] = value
	
end

local forcingActionPressed = {}
local forcingActionPressedTimer = {}
function InputHelper.ForceActionPressed(controllerIndex, buttonAction, value, timer)

	forcingActionPressed[controllerIndex] = forcingActionPressed[controllerIndex] or {}
	forcingActionPressed[controllerIndex][buttonAction] = value
	
	timer = timer or 1
	forcingActionPressedTimer[controllerIndex] = forcingActionPressedTimer[controllerIndex] or {}
	forcingActionPressedTimer[controllerIndex][buttonAction] = timer
	
end

InputHelperMod:AddCallback(ModCallbacks.MC_INPUT_ACTION, function(_, entity, inputHook, buttonAction)

	if entity and entity:ToPlayer() then
	
		local player = entity:ToPlayer()
		local controllerIndex = player.ControllerIndex
	
		if inputHook == InputHook.IS_ACTION_TRIGGERED then
		
			if forcingActionTriggered[controllerIndex] and forcingActionTriggered[controllerIndex][buttonAction] ~= nil then
			
				local toReturn = forcingActionTriggered[controllerIndex][buttonAction]
				forcingActionTriggered[controllerIndex][buttonAction] = nil
				
				return toReturn
				
			end
			
		elseif inputHook == InputHook.IS_ACTION_PRESSED then
		
			if forcingActionPressed[controllerIndex] and forcingActionPressed[controllerIndex][buttonAction] ~= nil then
			
				local toReturn = forcingActionPressed[controllerIndex][buttonAction]
				
				forcingActionPressedTimer[controllerIndex][buttonAction] = forcingActionPressedTimer[controllerIndex][buttonAction] - 1
				if forcingActionPressedTimer[controllerIndex][buttonAction] <= 0 then
					forcingActionPressed[controllerIndex][buttonAction] = nil
				end
				
				return toReturn
				
			end
			
		end
		
	end
	
end)


return InputHelper
