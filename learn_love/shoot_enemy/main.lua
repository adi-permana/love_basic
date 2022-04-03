function love.load()
  Object = require "classic"
  require "player"
  require "enemy"

  -- Load player
  player = Player()
  -- Load enemy
  enemy = Enemy()
end

function love.update(dt)
  player:update(dt)
  enemy:update(dt)
end

function love.draw()
  player:draw()
  enemy:draw()
end