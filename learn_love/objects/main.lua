function love.load()
  -- Use table as list of created rectangle
  listOfRects = {}
end

function createRect()
   -- Rectangle table
  rect = {}

  -- Rectangle size
  rect["width"] = 70
  -- can also be written rect.width = 100
  -- "width" is the key/prop
  rect.height = 90

  -- Rectangle position
  rect.x = 100
  rect.y = 100

  -- Speed property
  rect.speed = 100

  -- Put newly created rect into the listOfRect
  table.insert(listOfRects, rect)
end

function love.keypressed(key)
  -- When the "space" key is pressed a new rectangle will be created
  if key == "space" then
    createRect()
  end
end

function love.update(dt)
  -- Increase value of x-axis position
  for i,r in ipairs(listOfRects) do
    r.x = r.x + r.speed * dt
  end
end

function love.draw()
  for i,r in ipairs(listOfRects) do
    love.graphics.rectangle("line", r.x, r.y, r.width, r.height)
  end
end
