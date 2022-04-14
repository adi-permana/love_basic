function love.load()
  -- First load classic, since we use it to create the classes
  Object = require "classic"
  -- Then the entity which is the base class for the other classes
  require "entity"
  -- Then the entity classes
  require "player"
  require "wall"
  require "box"

  -- Player first location
  player = Player(100, 100)
  -- Wall first location
  wall = Wall(200, 100)
  wall2 = Wall(500, 100)
  -- Box first location
  box1 = Box(400, 150)
  box2 = Box(420, 150)
  box3 = Box(440, 150)
 
  -- Objects table
  objects = {}
  table.insert(objects, player)
  table.insert(objects, wall)
  table.insert(objects, box1)
  table.insert(objects, box2)
  table.insert(objects, box3)
  table.insert(objects, wall2)
end

function love.update(dt)
  for i,v in ipairs(objects) do
    -- Update the object
    v:update(dt)
  end

  -- Keeps checking collision as long as there has been collision resolved
  local loop = true
  -- Limit loop so that it doesn't do it infinitely
  local limit = 0

  while loop do
    -- First set it to false, if no collision it will stay false

    -- Break loop if it reaches 100 cycles
    limit = limit + 1
    if limit > 100 then
      -- When it still going above 100 loop; break loop
      break
    end

  -- Go through the list of objs except the last one
    for i=1,#objects-1 do
      -- Then loop through the list, starting from the obj next to the object in the first loop [i + 1]
      for j=i+1,#objects do
        -- Resolve collision between item by going through next to each other; i.e. player:wall, player:box, wall,box;
        -- While the last one doesn't
        local collision = objects[i]:resolveCollison(objects[j])
        -- Check collision if true run the loop again
        if collision then
          loop = true
        end
      end
    end
  end 
end

function love.draw()
  -- Draw each objects
  for i,v in ipairs(objects) do
    v:draw()
  end
end