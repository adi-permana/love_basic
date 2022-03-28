function love.load()
  x = 30
  y = 50
end

function love.draw()
  love.graphics.rectangle("line", x, y, 100, 100)
end

function love.keypressed(key)
  if key == "space" then
    x = math.random(100, 500)
    y = math.random(100, 500)
  end
end