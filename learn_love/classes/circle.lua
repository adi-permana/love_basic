-- Circle base class
-- Make circle an extension of Shape
-- We can add our own props without editin the Shape class prop
Circle = Shape:extend()

function Circle:new(x, y, radius)
  -- Pass x, y to [new()] function of [Shape]
  Circle.super.new(self, x, y)
  self.radius = radius
end

function Circle:draw()
  love.graphics.circle("line", self.x, self.y, self.radius)
end