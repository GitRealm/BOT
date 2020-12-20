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
	x = math.floor(x)
	y = math.floor(y)
	z = math.floor(z)
	print(x,y,z)
	return x,y,z
end

local function navigate(x,y,z,direction)

end

local function orient()
	print("Orienting self!")
	print("		Fetching reference coordinates")
	print("-------------------------------------")
	local x1,y1,z1 = savePos()

	if turtle.detect() then turtle.dig() end
	turtle.forward()
	print("		Fetching updated coordinates")
	print("-------------------------------------")
	local x2,y2,z2 = savePos()
	direction = "Undetermined"

	if x2-x1 ~= 0 then
		if x2 > 0 or x1 > 0 then
			if x2-x1 <0 then direction = "posX"
			else direction = "negX"
			end
		else
			if x2-x1 <0 then direction = "negX"
			else direction = "posX"
			end
		end

	
	elseif y2-y1 ~= 0 then
		if y2 > 0 or y1 > 0 then
			if y2-y1 <0 then direction = "posY"
			else direction = "negY"
			end
		else
			if y2-y1 <0 then direction = "negY"
			else direction = "posY"
			end
		end

	elseif z2-z1 ~= 0 then
		if z2 > 0 or z1 > 0 then
			if z2-z1 <0 then direction = "posZ"
			else direction = "negZ"
			end
		else
			if z2-z1 <0 then direction = "negZ"
			else direction = "posZ"
			end
		end
	end

	if direction ~= "Undetermined" then
		print("		Direction determined!")
		print("Facing " .. direction)
	else
		print("Could not orient!")
	end
end
---------------------------------------------------------------
--
-- Program Execution
--

savePos()
orient()
