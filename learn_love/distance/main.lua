-- Calculate distance between cursor and circle with pythagorean theory.
function love.load()
  -- Create obj circle
  circle = {}

  -- Circle props
  circle.x = 100
  circle.y = 100
  circle.radius = 25
  circle.speed = 200
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

  angle = math.atan2(mouse_y - circle.y, mouse_x - circle.x)

  cos = math.cos(angle)
  sin = math.sin(angle)

  -- Move circle toward mouse
  circle.x = circle.x + circle.speed * cos * dt
  circle.y = circle.y + circle.speed * sin * dt

end

function love.draw()
  -- visualize the triangle of pythagoreas theory
  love.graphics.circle("line", circle.x, circle.y, circle.radius)

  love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
  love.graphics.line(circle.x, circle.y, mouse_x, circle.y)
  love.graphics.line(mouse_x, mouse_y, mouse_x, circle.y)

  -- visualiazise distance radius
  local distance = getDistance(circle.x, circle.y, mouse_x, mouse_y)
  love.graphics.circle("line", circle.x, circle.y, distance)
end