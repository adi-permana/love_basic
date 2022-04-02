-- create a new rectangle every 2 seconds
function love.load()
  -- load the tick library
  tick = require "tick"

  -- Create boolean
  createRectangle = false

  -- 1st arg is a function
  -- 2nd arg is the time to call the function
    tick.delay(function () createRectangle = true end, 2)

end

function love.update(dt)
  tick.update(dt)
end

function love.draw()
  -- Will create a reactangle if boolean true
  if createRectangle then
    love.graphics.rectangle("fill", 100, 100, 200, 300)
  end
end
