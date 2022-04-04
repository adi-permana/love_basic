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

function love.update(dt)
  -- Get mouse position
  mouse_x, mouse_y = love.mouse.getPosition()
end

function love.draw()
  love.graphics.circle("line", circle.x, circle.y, circle.radius)

  love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
  love.graphics.line(circle.x, circle.y, mouse_x, circle.y)
  love.graphics.line(mouse_x, mouse_y, mouse_x, circle.y)
end