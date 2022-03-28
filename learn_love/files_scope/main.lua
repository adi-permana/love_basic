-- var test globaly
test = 10

-- goes to example.lua
require("example")

-- print to console 4th the last after executing codes in example.lua
print(test)
-- output 10

-- return a value even though its local to example.lua
print_local = require "example"
print(print_local)