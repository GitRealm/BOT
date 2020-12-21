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
	--print("Trying to get orientation!")
	local x1,y1,z1 = getPos()
	--print("		Reference coordinates = " .. x1 .. " " ..  y1 .. " " ..  z1)

	if turtle.detect() then turtle.dig() end
	turtle.forward()
	local x2,y2,z2 = getPos()
	--print("		Updated coordinates = " .. x2 .. " " .. y2 .. " " .. z2)
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
		--print("		Direction determined!")
		--print("Currently facing " .. direction)
	else
		--print("Could not get orientation!")
	end
	return direction
end

local function orient(direction)
	currOrientation = getOrientation()
	if direction == currOrientation then return end
	if direction == "positiveX" then
		if currOrientation == "negativeX" then
			turtle.turnLeft()
			turtle.turnLeft()
		elseif currOrientation == "positiveZ" then
			turtle.turnLeft()
		elseif currOrientation == "negativeZ" then
			turtle.turnRight()
		end
	elseif direction == "negativeX" then
		if currOrientation == "positiveX" then
			turtle.turnLeft()
			turtle.turnLeft()
		elseif currOrientation == "negativeZ" then
			turtle.turnRight()
		elseif currOrientation == "positiveZ" then
			turtle.turnLeft()
		end
	elseif direction == "positiveZ" then
		if currOrientation == "negativeZ" then
			turtle.turnLeft()
			turtle.turnLeft()
		elseif currOrientation == "positiveX" then
			turtle.turnLeft()
		elseif currOrientation == "negativeX" then
			turtle.turnRight()
		end
	elseif direction == "negativeZ" then
		if currOrientation == "positiveZ" then
			turtle.turnLeft()
			turtle.turnLeft()
		elseif currOrientation == "negativeX" then
			turtle.turnLeft()
		elseif currOrientation == "positiveX" then
			turtle.turnRight()
		end
	end
end

local function navigate(startX,startY,startZ)
	local currX, currY, currZ = getPos()
	
	print("Current coordinates: " .. currX .. " " .. currY .. " " .. currZ)
	print("Navigating to: " .. startX .. " " .. startY .. " " .. startZ)
	
	if currX ~= startX then
		print("Aligning X coordinate")
		distance = currX - startX
		if distance > 0 then 
			orient("negativeX") 
			print("		Heading towards negative X")
			while currX ~= startX - 1 do
				if not turtle.forward() then
					if turtle.detect() then turtle.dig() end
					turtle.forward()
				end
				currX = currX - 1
				print("		Current: " .. currZ .. " Goal: " .. startZ)
				sleep(2)
			end
		else 
			orient("positiveX") 
			print("		Heading towards positive X")
			while currX ~= startX - 1 do
				if not turtle.forward() then
					if turtle.detect() then turtle.dig() end
					turtle.forward()
				end
				currX = currX + 1
				print("		Current: " .. currZ .. " Goal: " .. startZ)
				sleep(2)
			end
		end
	end

	if currY ~= startY then
		print("Aligning Y coordinate")
		distance = currY - startY
		if distance > 0 then 
			print("		Heading towards positive Y")
			while currY ~= startY - 1 do
				if not turtle.up() then
					if turtle.detectUp() then turtle.digUp() end
					turtle.up()
				end
				currY = currY + 1
				print("		Current: " .. currZ .. " Goal: " .. startZ)
				sleep(2)
			end
		else 
			print("		Heading towards negative Y")
			while currY ~= startY - 1 do
				if not turtle.down() then
					if turtle.detectDown() then turtle.digDown() end
					turtle.down()
				end
				currY = currY - 1
				print("		Current: " .. currZ .. " Goal: " .. startZ)
				sleep(2)
			end
		end
	end

	if currZ ~= startZ then
		print("Aligning Z coordinate")
		distance = currZ - startZ
		if distance > 0 then 
			print("		Heading towards negative Z")
			orient("negativeZ") 
			while currZ ~= startZ - 1 do
				if not turtle.forward() then
					if turtle.detect() then turtle.dig() end
					turtle.forward()
				end
				currZ = currZ - 1
				print("		Current: " .. currZ .. " Goal: " .. startZ)
				sleep(2)
			end
		else 
			orient("positiveZ") 
			print("		Heading towards positive Z")
			while currZ ~= startZ+1 do
				currZ = currZ - 1
				print("		Current: " .. currZ .. " Goal: " .. startZ)
				if not turtle.forward() then
					if turtle.detect() then turtle.dig() end
					turtle.forward()
				end
				sleep(2)
			end
		end
	end

end
---------------------------------------------------------------
--
-- Program Execution
--

local startX,startY,startZ = getPos()
orient("positiveZ")
navigate(startX,startY,startZ)

