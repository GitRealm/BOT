
-- deploy.lua
-- Automated deployment of turtles
--
-----------------------------------------------------------------
--
-- calcTurtles(numChunks)	Calculates number of turtles needed based on numChunks
-- deployTurtles()		Deploys turtles in the current chunk
--
-----------------------------------------------------------------
--
require("navigate")
--
-----------------------------------------------------------------
--
-- Functions
--

local function calcTurtles(numChunks)
	numTurtles = numChunks * 4
	return numTurtles
end

local function deployTurtles()
	local startingOrientation = getOrientation()
	for a=1, 4, 1 do
		local currentOrientation = getOrientation()
		if turtle.detectUp() then turtle.digUp() end
		turtle.up()
		orient(startingOrientation)
		turtle.placeDown()
		digTurtle = peripheral.wrap("bottom")
		digTurtle.turnOn()
		--sleep(3)
		turtle.select(turtle.getSelectedSlot()+1)
		orient(currentOrientation)
		if turtle.detect() then turtle.dig() end
		turtle.forward()
		if turtle.detectDown() then turtle.digDown() end
		turtle.down()
		for i=1, 8, 1 do
			if turtle.detect() then turtle.dig() end
			turtle.forward()
			if a==4 and i==7 then break end
		end
		turtle.turnRight()
	end
end

deployTurtles()
turtle.back()
turtle.turnLeft()
turtle.forward()
turtle.turnRight()
turtle.select(1)
