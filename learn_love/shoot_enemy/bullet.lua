-- Bullet class
Bullet = Object:extend()

-- Pass in x,y of the player
function Bullet:new(x, y)
  self.image = love.graphics.newImage("bullet.png")
 -- Pass in the x and y/position of the player as bullet starting position
  self.x = x
  self.y = y
  self.speed = 700
  -- For collision checking
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Bullet:update(dt)
  self.y = self.y + self.speed * dt

  -- When you miss the enemy game will restart from the start.
  if self.y > love.graphics.getHeight() then
    -- Restart game
    love.load()
  end

end

function Bullet:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

function Bullet:checkCollision(obj)
  local self_left = self.x
  local self_right = self.x + self.width
  local self_top = self.y
  local self_bottom = self.y + self.height

  local obj_left = obj.x
  local obj_right = obj.x + obj.width
  local obj_top = obj.y
  local obj_bottom = obj.y + obj.height

  -- Collision logic
  if self_right > obj_left
  -- Check if collision has passed
  and self_left < obj_right
  and self_bottom > obj_top
  and self_top < obj_bottom then
    -- Prop hit to remove bullet from list
    self.hit = true

    -- Increase enemy speed when collided with bullet
    if obj.speed > 0 then
      obj.speed = obj.speed + 50
    else
      obj.speed = obj.speed - 50
    end

  end

end

