-- Create basic tile level
function love.load()
  -- Below represent our tile level, where a [1] represents a tile and a [0] is a blank
  tilemap = {1, 0, 0, 1, 1, 0, 1, 1, 1, 0}

  -- Below is tilemap with 2d table that goes vertical
  -- Use different number other than 1 and 0 for color
  vertTilemap = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 2, 2, 2, 2, 2, 2, 2, 2, 1},
    {1, 2, 3, 4, 5, 5, 4, 3, 2, 1},
    {1, 2, 2, 2, 2, 2, 2, 2, 2, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  }
  
  -- Color rgb numbers table
  colors = {
    {1, 1, 1},
    {1, 0, 0},
    {1, 1, 0},
    {0, 0, 1},
    {0, 1, 1}
  }
end

function love.draw()
  love.graphics.print("Basic tile map", 20, 280)
  -- loop through the tilemap table and create a tile for value that equates to 1
  for i,v in ipairs(tilemap) do
    if v == 1 then
      -- Create tile
      -- [i * 50] represents the spacing between tile
      love.graphics.rectangle("line", i * 25, 300, 25, 25)
    end
  end

love.graphics.print("Vertical tile map with colored tiles", 5, 10)
  -- loop through the vertTilemap to create a vertical tile level
  -- Iterate through the rows of vertTilemap
  for i, row in ipairs(vertTilemap) do
    -- Iterate through the columns of vertTilemap
    for j, tile in ipairs(row) do
      -- Check if tile not 0
      if tile ~= 0 then
      -- Set the color of the tile by using the value of the tile in vertTilemap table [ex. 3] as input of the corresponding rgb table value in colors table [ex. colors[3] = {0, 0, 1}]
      love.graphics.setColor(colors[tile])
      -- Then draw the tile
      love.graphics.rectangle("fill", j * 25, i * 25, 25, 25)
      end
    end
  end
end