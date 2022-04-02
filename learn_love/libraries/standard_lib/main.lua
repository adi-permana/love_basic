-- Places rectangle in random places everytime "space" is pressed
function love.load()
  -- placement of rectangle
  x = 30
  y = 50
end

function love.draw()
  love.graphics.rectangle("line", x, y, 100, 100)
end

function love.keypressed(key)
  -- When space is pressed new rectangle created
  if key == "space" then
    -- x and y becomes random number between 100-500
    x = math.random(100, 500)
    y = math.random(100, 500)
  end
end
