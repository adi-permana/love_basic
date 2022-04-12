-- Wall entity
Wall = Entity:extend()

function Wall:new(x, y)
  Wall.super.new(self, x, y, "img/wall.png")
  -- Give wall strength of 100
  self.strength = 100
end