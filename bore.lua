--
-- bore.lua
-- Spiral excavation for a single turtle (8Lx8Wx5H)
--
---------------------------------------------------------------
--
-- turnRight()				Orient the turtle right
-- turnLeft()				Orient the turtle left
-- switchPlane()			Turn around and move down one level
-- dig(amount)				Dig forward $amount blocks
-- digPlane(width, currentLevel)	Dig plane $width x $width blocks (L2R Spiral)
-- digPlaneReverse(width, currentLevel) Dig plane $width x $width blocks (R2L Spiral)
-- digBore(width, depth) 		Dig hole $width x $width x $depth
--
---------------------------------------------------------------
--
-- Functions
--

local function turnRight()
	print("		Turning right")
	turtle.turnRight()
	if turtle.detect() then turtle.dig() end
end

local function turnLeft()
	print("		Turning left")
	turtle.turnLeft()
	if turtle.detect() then turtle.dig() end
end

local function switchPlane()
	print("Swiching levels")
	turtle.turnRight()
	turtle.turnRight()
	if turtle.detectDown() then turtle.digDown() end
	turtle.down()
end

local function dig(amount)
	print("		Digging " .. amount .. " blocks")
	for i=1, amount, 1 do
		if turtle.detect() then turtle.dig() end
		turtle.forward()
	end
end

local function digPlane(width,currentLevel)
	print()
	print("Beginning excavation of level " .. currentLevel)
	if currentLevel == 1 then
		if turtle.detect() then turtle.dig() end
		turtle.forward()
	end
	width = width - 1
	dig(width)
	turnRight()
	while width>0 do
		for a=1, 2, 1 do
			dig(width)
			if (width==1 and a==2) then break end
			turnRight()
		end
		width = width - 1
	end
	print("Completed excavation of level " .. currentLevel)
	print()
end

local function digPlaneReverse(width,currentLevel)
	local digAmount = 1
	print()
	print("Beginning reverse excavation of level " .. currentLevel)
	while digAmount<width do
		for a=1, 2, 1 do
			dig(digAmount)
			if (digAmount==width and a==2) then break end
			turnLeft()
		end
		digAmount = digAmount + 1
	end
	dig(width-1)
	print("Completed reverse excavation of level " .. currentLevel)
	print()
end

local function digBore(width, depth)
	print("Boring dimensions = " .. width .. "Lx" .. width .. "Wx" .. depth .. "H")
	for i=1, depth, 1 do
		if i%2 == 1 then digPlane(width,i)
		else digPlaneReverse(width,i) end
		if i == depth then return end
		switchPlane()
	end
end
--
---------------------------------------------------------------
--
-- Program Execution
--
print()
print("=====================================")
print("Executing Bore program .. ")
print("=====================================")
print()
digBore(8,2)
--
---------------------------------------------------------------
