--
-- deploy.lua
-- Automated deployment of turtles
--
---------------------------------------------------------------
--
-- calculate(chunks)		divides $chunks by 4, returns numTurtles
-- getPos()			returns current x,y,z coordinates
-- getOrientation()		returns current orientation
-- orient(direction)		orients turtle to $direction
-- navigate(destX,destY,destZ)  moves turtle to $destX, $destY, $destZ
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

	turtle.back()
	local x2,y2,z2 = getPos()
	--print("		Updated coordinates = " .. x2 .. " " .. y2 .. " " .. z2)
	direction = "Undetermined"

	if x1-x2 ~= 0 then
		if x1-x2 < 0 then direction = "negativeX"
		else direction = "positiveX"
		end

	elseif y2-y1 ~= 0 then
		if y2-y1 < 0 then direction = "negativeZ"
		else direction = "positiveY"
		end

	elseif z1-z2 ~= 0 then
		if z1-z2 < 0 then direction = "negativeZ"
		else direction = "positiveZ"
		end
	end

	if direction ~= "Undetermined" then
		--print("		Direction determined!")
		--print("Currently facing " .. direction)
	else
		--print("Could not get orientation!")
	end
	turtle.forward()
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
			turtle.turnLeft()
		elseif currOrientation == "positiveZ" then
			turtle.turnRight()
		end
	elseif direction == "positiveZ" then
		if currOrientation == "negativeZ" then
			turtle.turnLeft()
			turtle.turnLeft()
		elseif currOrientation == "positiveX" then
			turtle.turnRight()
		elseif currOrientation == "negativeX" then
			turtle.turnRight()
		end
	elseif direction == "negativeZ" then
		if currOrientation == "positiveZ" then
			turtle.turnLeft()
			turtle.turnLeft()
		elseif currOrientation == "negativeX" then
			turtle.turnRight()
		elseif currOrientation == "positiveX" then
			turtle.turnLeft()
		end
	end
end

local function navigate(destX,destY,destZ)
	local currX, currY, currZ = getPos()
	
	print("Current coordinates: " .. currX .. " " .. currY .. " " .. currZ)
	print("Navigating to: " .. destX.. " " .. destY.. " " .. destZ)

	while currX ~= destX or currY ~= destY or currZ ~= destZ do
		if currX ~= destX then
			print("Aligning X coordinate")
			distance = currX - destX 
			if distance > 0 then 
				orient("negativeX") 
				print("		Heading towards negative X")
				while currX ~= destX do
					if not turtle.forward() then
						if turtle.detect() then turtle.dig() end
						turtle.forward()
					end
					currX = currX - 1
					print("		Current: " .. currX .. " Dest: " .. destX)
					sleep(2)
				end
			else 
				orient("positiveX") 
				print("		Heading towards positive X")
				while currX ~= destX do
					if not turtle.forward() then
						if turtle.detect() then turtle.dig() end
						turtle.forward()
					end
					currX = currX + 1
					print("		Current: " .. currX .. " Dest: " .. destX)
					sleep(2)
				end
			end
		end

		if currY ~= destY then
			print("Aligning Y coordinate")
			distance = currY - destY 
			if distance > 0 then 
				print("		Heading towards positive Y")
				while currY ~= destY do
					if not turtle.up() then
						if turtle.detectUp() then turtle.digUp() end
						turtle.up()
					end
					currY = currY + 1
					print("		Current: " .. currY .. " Dest: " .. destY)
					sleep(2)
				end
			else 
				print("		Heading towards negative Y")
				while currY ~= destY do
					if not turtle.down() then
						if turtle.detectDown() then turtle.digDown() end
						turtle.down()
					end
					currY = currY - 1
					print("		Current: " .. currY .. " Dest: " .. destY)
					sleep(2)
				end
			end
		end

		if currZ ~= destZ then
			print("Aligning Z coordinate")
			distance = currZ - destZ 
			if distance > 0 then 
				print("		Heading towards negative Z")
				orient("negativeZ") 
				while currZ ~= destZ do
					if not turtle.forward() then
						if turtle.detect() then turtle.dig() end
						turtle.forward()
					end
					currZ = currZ - 1
					print("		Current: " .. currZ .. " Dest: " .. destZ)
					sleep(2)
				end
			else 
				orient("positiveZ") 
				print("		Heading towards positive Z")
				while currZ ~= destZ do
					currZ = currZ + 1
					print("		Current: " .. currZ .. " Goal: " .. destZ)
					if not turtle.forward() then
						if turtle.detect() then turtle.dig() end
						turtle.forward()
					end
					sleep(2)
				end
			end
		end
	end

end
---------------------------------------------------------------
--
-- Program Execution
--

local startX,startY,startZ = getPos()
navigate(0,237,5)
navigate(startX,startY,startZ)

