-- Player classes
Player = Object:extend()

function Player:new()
  -- Player avatar
  self.image = love.graphics.newImage("panda.png")
  
  self.x = 300
  self.y = 20
  self.speed = 500
  self.width = self.image:getWidth()
end

function Player:update(dt)
  -- Player movement to the left or right
  if love.keyboard.isDown("d") then
    self.x = self.x - self.speed * dt
    print(self.x)
  elseif love.keyboard.isDown("a") then
    self.x = self.x + self.speed * dt
    print(self.x)
  end

  -- Checks for player so that it stays within the game window
  -- Get width of game window
  local window_width = love.graphics.getWidth()

  -- if player/x is too far to the left
  if self.x < 0 then
    self.x = 0
  -- If player/x is too far to the right
  elseif self.x + self.width > window_width then
    self.x = window_width - self.width
  end
end

function Player:draw()
  -- Player placement on the screen
  love.graphics.draw(self.image, self.x, self.y)
end

