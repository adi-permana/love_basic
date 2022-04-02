function love.load()
  -- Create 2 rectangle
  r1 = {
    x = 10,
    y = 100,
    width = 100,
    height = 100
  }

  r2 = {
    x = 250,
    y = 120,
    width = 150,
    height = 120
  }
end

-- This is called AABB collision
function checkCollision(a, b)
  -- With local use underscore instead of camelCasing
  local a_left = a.x
  local a_right = a.x + a.width
  local a_top = a.y
  local a_bottom = a.y + a.height

  local b_left = b.x
  local b_right = b.x + b.width
  local b_top = b.y
  local b_bottom = b.y + b.height

  -- If Red's right side is further to the right than blue's left side/Passes through the blue's left side.
  return a_right > b_left
  -- And red's left side is further to the left then blue's right side
      and a_left < b_right
  -- And red's bottom side is further to the bottom than blue's top side/Passes through the blue's top side.
      and a_bottom > b_top
  -- and red's top side is further to the top than blue's bottom side then..
      and a_top < b_bottom
    -- There is collision

end

function love.update(dt)
  r1.x = r1.x + 100 * dt
end

function love.draw()
  -- Create a local var called mode
  local mode

  if checkCollision(r1, r2) then
    -- If there is collision, draw the rectangles filled
    mode = "fill"
  else
    -- If no collision keep the rectangles line
    mode = "line"
  end

  -- Draw the 2 rectangles
  love.graphics.rectangle(mode, r1.x, r1.y, r1.width, r1.height)
  love.graphics.rectangle(mode, r2.x, r2.y, r1.width, r2.height)
end