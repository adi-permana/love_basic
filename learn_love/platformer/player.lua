-- Player entity
Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "img/player.png")

  -- Make player stronger than the box
  self.strength = 10
end

function Player:update(dt)
  -- Call the base base class function
  -- Important to do this before changing position
  Player.super.update(self, dt)

  -- Move left and right
  if love.keyboard.isDown("left") then
    self.x = self.x - 200 * dt
  elseif love.keyboard.isDown("right") then
    self.x = self.x + 200 * dt
  end

  -- Move up and down
  if love.keyboard.isDown("up") then
    self.y = self.y - 200 * dt
  end
end