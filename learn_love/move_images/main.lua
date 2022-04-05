-- Move image toward mouse
function love.load()
  arrow ={}
  arrow.x = 200
  arrow.y = 200
  arrow.speed = 300
  -- arg option for rotation is 0; therefore with angle = 0, cosine is 1 and sine is 0, which moves the arrow to the right
  arrow.angle = 0
  -- So when using an image, make sure it looks to the right by default
  arrow.image = love.graphics.newImage("img/arrow_right.png")
  -- Put origin in the center instead of the default top left corner
  arrow.origin_x = arrow.image:getWidth() / 2
  arrow.origin_y = arrow.image:getHeight() / 2
end

function getDistance(x1, y1, x2, y2)
  -- Calculate distance between circle and mouse
  local horizontal_distance = x1 - x2
  local vertical_distance = y1 - y2

  -- Square the 2 distances
  local a = horizontal_distance ^2
  local b = vertical_distance ^2
  -- Total of both distances
  local c = a + b

  -- Square root of total to get distance
  local distance = math.sqrt(c)
  return distance
end

function love.update(dt)
  -- Get mouse position
  mouse_x, mouse_y = love.mouse.getPosition()

  -- Get cos and sin of arrow's angle so it always points to the mouse
  arrow.angle = math.atan2(mouse_y - arrow.y, mouse_x - arrow.x)
  cos = math.cos(arrow.angle)
  sin = math.sin(arrow.angle)

  local distance = getDistance(mouse_x, mouse_y, arrow.x, arrow.y)

  if distance < 200 then
    -- Move arrow toward mouse
    arrow.x = arrow.x + arrow.speed * cos * dt
    arrow.y = arrow.y + arrow.speed * sin * dt
  end
end

function love.draw()
  love.graphics.draw(arrow.image, arrow.x, arrow.y, arrow.angle, 1, 1, arrow.origin_x, arrow.origin_y)

  -- visualize the mouse in game as small dot circle
  love.graphics.circle("fill", mouse_x, mouse_y, 5)
end
