-- Enemy classes
Enemy = Object:extend()

function Enemy:new()
  self.image = love.graphics.newImage("snake.png")
  self.x = 325
  self.y = 450
  self.speed = 100
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Enemy:update(dt)
  self.x = self.x + self.speed * dt

  -- Get game windows width
  local window_width = love.graphics.getWidth()

  -- Bounces left or right wall when hit the window wall
  if self.x < 0 then
    self.x = 0
    -- turn into positive number so it move to the right
    self.speed = -self.speed
  elseif self.x + self.width > window_width then
    self.x = window_width - self.width
    -- turn into negative number so it move to the left
    self.speed = -self.speed
  end

end

function Enemy:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

