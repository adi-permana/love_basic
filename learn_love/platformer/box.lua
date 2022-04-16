-- Box entity
Box = Entity:extend()

function Box:new(x, y)
  Box.super.new(self, x, y, "img/box.png")
end 
