local ScreenHelper = {}
ScreenHelper.Version = 1


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
local game = Game()
local room = game:GetRoom()
function ScreenHelper.GetScreenSize() --based off of code from kilburn

    local pos = room:WorldToScreenPosition(Vector(0,0)) - room:GetRenderScrollOffset() - game.ScreenShakeOffset
    
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

local vectorZero = Vector(0,0)
function ScreenHelper.GetScreenTopLeft(offset)

	offset = offset or ScreenHelper.GetOffset()
	
	local pos = vectorZero
	local hudOffset = Vector(offset * 2, offset * 1.2)
	pos = pos + hudOffset
	
	return pos
	
end


return ScreenHelper
