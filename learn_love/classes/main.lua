function love.load()
  Object = require "classic"
  -- load shape.lua
  require "shape"
  -- load rectangle.lua
  require "rectangle"
  -- load circle.lua
  require "circle"

  -- creates a new instance of Rectangle, it takes our blueprint and creates a new obj with all the class its features.
  -- every new instance is unique
  -- when we call rectangle() it executes rectangle.new
  r1 = Rectangle(100, 100, 200, 50)
  -- to prove r1 unique we create r2
  r2 = Circle(350, 80, 40)
  -- Both have prop test, but they have different values
end

function love.update(dt)
  -- lua turns this into r1.update(r1, dt)
  r1:update(dt)
  r2:update(dt)
end

function love.draw()
  r1:draw()
  r2:draw()
end
