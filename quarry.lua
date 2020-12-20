---------------------------------------------------------------
--
-- Quarry.lua
-- Created as a proof of concept for BOT
--
---------------------------------------------------------------
--
--      inputWidth                  >> User input data to determine quarry length and width
--      inputDepth                  >> User input data to determine quarry depth
--
--      digRow(rowLength,increment) >> Digs forward rowLength times & turns left or right based on increment
--      digPlane(width,level)       >> digRow() width times, passing increment from loop counter
--      quarry(width,depth)         >> digPlane() depth times
--      switchPlane()               >> Changes depth and orient for next digPlane()
--      turnLeft()                  >> Move to left adjacent row and orient for next digRow()
--      turnRight()                 >> Move to right adjacent row and orient for next digRow()
--
---------------------------------------------------------------
--
print("Executing Quarry program")
io.write("How wide: ")
inputWidth = io.read()
io.write("How deep: ")
inputDepth = io.read()

print()
print("----------------------------")
print("Digging a " .. inputWidth .. "x" .. inputWidth .. "x" .. inputDepth .. " quarry.")
print("----------------------------")
print()

local function digRow(rowLength,increment)
    for x=1, rowLength,1 do
        if turtle.detect() then turtle.dig() end
        turtle.forward()
    end
    if increment == rowLength then return end
    if increment%2 == 0 then turnRight() else turnLeft() end
end

local function digPlane(width,level)
    if level == 1 then
        digRow(width,0)
    elseif level%2 == 0 then
        digRow(width-1,0)
    else
        digRow(width-1,0)
    end
    for i=1,width-1,1 do
        digRow(width-1,i)
    end
end

function switchPlane()
    turtle.turnRight()
    turtle.turnRight()
    if turtle.detectDown() then turtle.digDown() end
    turtle.down()
end

function turnLeft()
    turtle.turnLeft()
    if turtle.detect() then turtle.dig() end
    turtle.forward()
    turtle.turnLeft()
end

function turnRight()
    turtle.turnRight()
    if turtle.detect() then turtle.dig() end
    turtle.forward()
    turtle.turnRight()
end

local function quarry(width,depth)
    for plane=1,depth,1 do
        print("Digging level " .. plane)
        digPlane(width,plane)
        print("Level " .. plane .. " is now finished.")
        if plane == tonumber(depth) then
            print()
            print("----------------------------")
            print()
            print("Done")
            return end
        print("Switching to level " .. plane+1)
        switchPlane()
        print()
    end
end

quarry(inputWidth,inputDepth)
