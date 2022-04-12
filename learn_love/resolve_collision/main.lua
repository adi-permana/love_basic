function love.load()
  -- First load classic, since we use it to create the classes
  Object = require "classic"
  -- Then the entity which is the base class for the other classes
  require "entity"
  -- Then the entity classes
  require "player"
  require "wall"

  -- Player first location
  player = Player(100, 100)
  -- Wall first location
  wall = Wall(200, 100)
end

function love.update(dt)
  player:update(dt)
  wall:update(dt)
  wall:resolveCollison(player)
end

function love.draw()
  player:draw()
  wall:draw()
end