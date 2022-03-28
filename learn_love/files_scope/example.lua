-- test = 20
--! local scope only accessible inside this file
-- Local test var i.e. not 10
local test = 20
-- If tried to access outside of file will return nil

local testTwo = 5

function some_function(test)
  if true then
    local test = 40
    print(test)
    -- output 40 as test locally is 40
    -- prints to console 1st
  end
  print(test)
  -- prints whatever inputed as func arg
  -- prints to console 2nd
end

some_function(30)
-- since 30 is the arg 30 will be printeed out

print(test)
-- prints 20
-- prints to console 3rd

return testTwo