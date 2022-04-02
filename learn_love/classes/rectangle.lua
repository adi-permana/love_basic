
-- pass object as first arg
-- make Rectangle into new class; becomes our blueprint
-- unlike props, classes usually written with an uppercase character (PascalCase)
-- We make Rectangle an extension of Shape
Rectangle = Shape:extend()

-- Lua turns this into: Rectangle.new(self)
function Rectangle:new(x, y, width, height)
  -- With this we can give each rect their own place and size.
  -- With Rectangle.super we can get access to our base class's functions, and we use it to call Shape:new()
  -- We have to pass [self] as first arg, as we can't let lua handle it, because we're not calling the function as the instance
  Rectangle.super.new(self, x, y)
  self.width = width
  self.height = height
end


function Rectangle:update(dt)
  self.x = self.x + self.speed * dt
end

function Rectangle:draw()
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end
