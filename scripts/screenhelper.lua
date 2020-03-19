local ScreenHelper = {}
ScreenHelper.Version = 1

--[[

SCREEN HELPER v1
by piber
GetScreenSize is based on code by _Kilburn

Make sure this is located in MOD/scripts/screenhelper.lua otherwise it wont load properly!

Do not edit this script file as it could conflict with the release version of this file used by other mods. If you find a bug or need to something changed, let me know.

-------

REQUIREMENTS:
- CacheHelper

-------

Screen Helper's goals:
- Make custom hud offset easier to support.
- Be a collection of screen-related functions to make it easier to pick positions of the screen to render stuff on to.

Screen Helper has functions for getting each corner of the screen, which have automatic support for a custom local hud offset value, which can be changed at any time. With Mod Config Menu, it will change automatically based on the player's input in its menu, eliminating further work on your mod's side to handle hud offset.

-------

Notable functions:

ScreenHelper.SetOffset(num) -- Changes the local hud offset value to the number desired. Minimum = 0, maximum = 10. Mod Config Menu makes use of this to change it to whatever the player wants.
ScreenHelper.GetOffset() -- Returns the current hud offset value.

ScreenHelper.GetScreenSize() -- Returns a vector equal to the size of the screen, starting from the top left corner and ending at the bottom right corner. Effectively gets the bottom right corner of the screen but it is recommended you use another function for that.
ScreenHelper.GetScreenCenter() -- Returns the center position of the screen. Effectively half of the screen size vector.

These functions use an offset as the first arg, leave it empty if you want to make use of the internal hud offset value.
ScreenHelper.GetScreenBottomRight(offset) -- Returns a vector positioned at the bottom right corner of the screen, using the offset to push it from the corner a bit.
ScreenHelper.GetScreenBottomLeft(offset) -- Returns a vector positioned at the bottom left corner of the screen, using the offset to push it from the corner a bit.
ScreenHelper.GetScreenTopRight(offset) -- Returns a vector positioned at the top right corner of the screen, using the offset to push it from the corner a bit.
ScreenHelper.GetScreenTopLeft(offset) -- Returns a vector positioned at the top left corner of the screen, using the offset to push it from the corner a bit.

]]

--require some lua libraries
local CacheHelper = require("scripts.cachehelper")

--cached values
local game = CacheHelper.Game
local room = CacheHelper.Room

local vecZero = CacheHelper.VecZero


---------------------
--hud offset helper--
---------------------
local ScreenOffset = 0

function ScreenHelper.SetOffset(num)

	num = math.min(math.max(math.floor(num),0),10)

	ScreenOffset = num
	
	return num

end

function ScreenHelper.GetOffset()

	return ScreenOffset

end


------------------------------------
--screen size and corner functions--
------------------------------------
function ScreenHelper.GetScreenSize() --based off of code from kilburn

    local pos = room:WorldToScreenPosition(vecZero) - room:GetRenderScrollOffset() - game.ScreenShakeOffset
    
    local rx = pos.X + 60 * 26 / 40
    local ry = pos.Y + 140 * (26 / 40)
    
    return Vector(rx*2 + 13*26, ry*2 + 7*26)
	
end

function ScreenHelper.GetScreenCenter()

	return ScreenHelper.GetScreenSize() / 2
	
end

function ScreenHelper.GetScreenBottomRight(offset)

	offset = offset or ScreenHelper.GetOffset()
	
	local pos = ScreenHelper.GetScreenSize()
	local hudOffset = Vector(-offset * 2.2, -offset * 1.6)
	pos = pos + hudOffset

	return pos
	
end

function ScreenHelper.GetScreenBottomLeft(offset)

	offset = offset or ScreenHelper.GetOffset()
	
	local pos = Vector(0, ScreenHelper.GetScreenBottomRight(0).Y)
	local hudOffset = Vector(offset * 2.2, -offset * 1.6)
	pos = pos + hudOffset
	
	return pos
	
end

function ScreenHelper.GetScreenTopRight(offset)

	offset = offset or ScreenHelper.GetOffset()
	
	local pos = Vector(ScreenHelper.GetScreenBottomRight(0).X, 0)
	local hudOffset = Vector(-offset * 2.2, offset * 1.2)
	pos = pos + hudOffset

	return pos
	
end

function ScreenHelper.GetScreenTopLeft(offset)

	offset = offset or ScreenHelper.GetOffset()
	
	local pos = vecZero
	local hudOffset = Vector(offset * 2, offset * 1.2)
	pos = pos + hudOffset
	
	return pos
	
end


return ScreenHelper
