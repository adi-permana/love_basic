-- multiple tiles type from a single image
function love.load()
  -- load image
  image = love.graphics.newImage("img/tileset.png")

  -- Full width and height of the image
  local image_width = image:getWidth()
  local image_height = image:getHeight()

  -- Height and width of a single tile
  -- width = 32
  -- height = 32

  -- But if we don't know the width and height of the tile use number of rows and columns in a tileset
  -- This example we're using 2 rows 3 columns tileset
  -- Subtract 2 to make up for the empty pixels we included to prevent bleeding
  width = (image_width / 3) - 2
  height = (image_height / 2) - 2

  -- Create the quads
  quads = {}

  -- Row
  for i=0,1 do
    -- Column
    for j=0,2 do
      table.insert(quads, love.graphics.newQuad(
        1 + j * (width + 2),
        1 + i * (height + 2),
        width, height,
        image_width, image_height))
    end
  end

  tilemap = {
    -- On position row 1 column 1 we draw quad 1, on position row 1, column 2, we draw quad 6, and so on
    {1, 6, 6, 6, 2, 1, 6, 6, 6, 2},
    {3, 0, 0, 0, 4, 5, 0, 0, 0, 3},
    {3, 0, 0, 0, 0, 0, 0, 0, 0, 3},
    {4, 2, 0, 0, 0, 0, 0, 0, 1, 5},
    {1, 5, 0, 0, 0, 0, 0, 0, 4, 2},
    {3, 0, 0, 0, 0, 0, 0, 0, 0, 3},
    {3, 0, 0, 0, 1, 2, 0, 0, 0, 3},
    {4, 6, 6, 6, 5, 4, 6, 6, 6, 5}
  }

  -- Create player
  player = {
    -- Load player image
    image = love.graphics.newImage("img/player.png"),
    -- Player initial location/position
    tile_x = 2,
    tile_y = 2
  }
end

-- Function to check if the spot we want to go is empty
function isEmpty(x, y)
  -- y-position is the row, x-position is the column
  return tilemap[y][x] == 0
end

-- Check for key pressed instead of down
function love.keypressed(key)
  -- Create local x and y var
  local x = player.tile_x
  local y = player.tile_y

  -- then add or subtract according to key that was pressed, then assigned the value to player tile_x and tile_y
  if key == "left" then
    x = x - 1
  elseif key == "right" then
    x = x + 1
  elseif key == "up" then
    y = y - 1
  elseif key == "down" then
    y = y + 1
  end

  -- If spot is empty then move player
  if isEmpty(x, y) then
    player.tile_x = x
    player.tile_y = y
  end
end

function love.draw()
  -- Draw tiles level according to tile map
  for i,row in ipairs(tilemap) do
    for j,tile in ipairs(row) do
      if tile ~=0 then
      -- Draw tiles
      love.graphics.draw(image, quads[tile], j * width, i * height)
      end
    end
  end

  -- Draw player
  -- When drawn the positioning will be multiplied by tiles height and width
  love.graphics.draw(player.image, player.tile_x * width, player.tile_y * height)
end
