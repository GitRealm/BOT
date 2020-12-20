--
-- deploy.lua
-- Automated deployment of turtles
--
---------------------------------------------------------------
--
--
--
---------------------------------------------------------------
--
-- Functions
--

local function calculate(chunks)
	local numTurtles = chunks/4
	return numTurtles
end

local function savePos()
	local x,y,z = gps.locate()
	print(x,y,z)
end

local function navigate(x,y,z,direction)

end

local function orient()
	local x,y,z = gps.locate()
	print(x,y,z)
	if turtle.detect() then turtle.dig() end
	turtle.forward()
	local x2,y2,z2 = gps.locate()
	print(x2,y2,z2)
	direction = "Undetermined"

	if x2-x ~= 0 then
		if x2-x <0 then direction = "posX"
		else direction = "negX"
		end

	elseif y2-y ~= 0 then
		if y2-y <0 then direction = "posY"
		else direction = "negY"
		end

	elseif z2-z ~= 0 then
		if z2-z <0 then direction = "posZ"
		else direction = "negZ"
		end
	end

	print(direction)

end
---------------------------------------------------------------
--
-- Program Execution
--

savePos()
orient()
