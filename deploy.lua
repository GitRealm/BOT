
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
	for a=1, 4, 1 do
		turtle.place()
		for i=1, 8, 1 do
			if turtle.detect then turtle.dig() end
			turtle.forward()
		end
		turtle.turnRight()
	end
end
