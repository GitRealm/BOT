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

local function getPos()
	local x,y,z = gps.locate()
	x = math.floor(x)
	y = math.floor(y)
	z = math.floor(z)
	return x,y,z
end

local function getOrientation()
	print("Trying to get orientation!")
	local x1,y1,z1 = getPos()
	print("		Reference coordinates = " .. x1 .. " " ..  y1 .. " " ..  z1)

	if turtle.detect() then turtle.dig() end
	turtle.forward()
	local x2,y2,z2 = getPos()
	print("		Updated coordinates = " .. x2 .. " " .. y2 .. " " .. z2)
	direction = "Undetermined"

	if x2-x1 ~= 0 then
		if x2-x1 < 0 then direction = "negativeX"
		else direction = "positiveX"
		end

	elseif y2-y1 ~= 0 then
		if y2-y1 < 0 then direction = "negativeZ"
		else direction = "positiveY"
		end

	elseif z2-z1 ~= 0 then
		if z2-z1 < 0 then direction = "negativeZ"
		else direction = "positiveZ"
		end
	end

	if direction ~= "Undetermined" then
		print("		Direction determined!")
		print("Currently facing " .. direction)
	else
		print("Could not get orientation!")
	end
	return direction
end

local function orient(direction)
	while getOrientation() ~= direction do
		turtle.turnLeft()
	end
end

local function navigate(startX,startY,startZ)
	local currX, currY, currZ = getPos()
	
	print("Current coordinates: " .. currX .. " " .. currY .. " " .. currZ)
	print("Navigating to: " .. startX .. " " .. startY .. " " .. startZ)
	
	if currX ~= startX then
		distance = currX - startX
		if distance > 0 then orient("positiveX") else orient("negativeX") end
		while distance ~= 0 do
			if turtle.detect() then turtle.dig() end
			turtle.forward()
			distance = distance - 1
		end
	end

	if currY ~= startY then
		distance = currY - startY
		if distance > 0 then orient("positiveY") else orient("negativeY") end
		while distance ~= 0 do
			if turtle.detect() then turtle.dig() end
			turtle.forward()
			distance = distance - 1
		end
	end

	if currZ ~= startZ then
		distance = currZ - startZ
		if distance > 0 then orient("positiveZ") else orient("negativeZ") end
		while distance ~= 0 do
			if turtle.detect() then turtle.dig() end
			turtle.forward()
			distance = distance - 1
		end
	end
end
---------------------------------------------------------------
--
-- Program Execution
--

local startX,startY,startZ = getPos()
getOrientation()
orient("positiveZ")
navigate(startX,startY,startZ)

