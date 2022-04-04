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
  -- love.mouse.getPosition returns the x and y position of the cursor.
  mouse_x, mouse_y = love.mouse.getPosition()

  -- Get the angle i.e. vertical and horizontal vector (distance + direction), and returns an angle.
  -- Arg 1 y-position [mouse_y] you want to go minus object [circle_y] y-position.
  -- Arg 2 is the same with x position
  angle = math.atan2(mouse_y - circle.y, mouse_x - circle.x)

  -- Sin and cos for calculating circle so it move toward the mouse
  cos = math.cos(angle)
  sin = math.sin(angle)

  -- Make circle move toward the mouse
  circle.x = circle.x + circle.speed * cos * dt
  circle.y = circle.y + circle.speed * sin * dt
end

function love.draw()
  love.graphics.circle("line", circle.x, circle.y, circle.radius)

  -- prints the angle
  love.graphics.print("Angle: " .. angle, 10, 10)

  -- Some lines to visualize the velocity
  love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
  love.graphics.line(circle.x, circle.y, mouse_x, circle.y)

  -- The angle
  love.graphics.line(circle.x, circle.y, circle.x, mouse_y)
end