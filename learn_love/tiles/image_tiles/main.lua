-- Use an image to create tiles level
function love.load()
  -- Load image of the tile
  image = love.graphics.newImage("img/tile.png")
  
  -- Image full width and height for quad
  width = image:getWidth()
  height = image:getHeight()

  tilemap = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 2, 2, 2, 2, 2, 2, 2, 2, 1},
    {1, 2, 3, 4, 5, 5, 4, 3, 2, 1},
    {1, 2, 2, 2, 2, 2, 2, 2, 2, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  }

  -- rgb color table
  colors = {
    {1, 1, 1},
    {1, 0, 0},
    {1, 1, 0},
    {0, 0, 1},
    {0, 1, 1}
  }
end

function love.draw()
  -- Draw tile level according to tilemap
  for i,row in ipairs(tilemap) do
    for j,tile in ipairs(row) do
      if tile ~=0 then
        -- Set color to the tile
        love.graphics.setColor(colors[tile])
        -- Draw the tile
        love.graphics.draw(image, j * width, i * height)
      end
    end
  end
end
