-- A platforming game where player can fall and jump.
function love.load()
  Object = require "classic"
  require "entity"
  -- Load the entities
  require "player"
  require "wall"
  require "box"

  -- Entity start position
  player = Player(100, 100)
  box = Box(400, 150)

  -- Entities table
  objects = {}
  table.insert(objects, player)
  table.insert(objects, box)

  -- Create seperate table for the wall
  -- So every wall doesnt need to check collision with each other everytime
  walls = {}

  -- Wall map
  map = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  }

  -- Turn the value 1 in map table into wall
  for i,v in ipairs(map) do
    for j,w in ipairs(v) do
      if w == 1 then
        -- All wall to the walls table
        table.insert(walls, Wall((j-1)*50, (i-1)*50))
      end
    end
  end
end

function love.update(dt)
  -- Update the objects entities
  for i,v in ipairs(objects) do
    v:update(dt)
  end

  -- Update the walls entity only
  for i,v in ipairs(walls) do
    v:update(dt)
  end

  -- Loop through for collision
  local loop = true
  -- Loop count
  local limit = 0

  -- Loop through collision, if loop more than 100 times break loop
  while loop do
    loop = false

    -- Loop count
    limit = limit + 1
    if limit > 100 then
      break
    end

    -- Resolve collision between object
    for i=1,#objects-1 do
      for j=i+1,#objects do
        local collision = objects[i]:resolveCollision(objects[j])
        if collision then
          loop = true
        end
      end
    end



    -- Check collision with every wall for each object
    for i,wall in ipairs(walls) do
      for j,object in ipairs(objects) do
        local collision = object:resolveCollision(wall)
        if collision then
          loop = true
        end
      end
    end
  end
end

function love.draw()
  -- Draw each entities
  for i,v in ipairs(objects) do
    v:draw()
  end

  -- Draw the walls
  for i,v in ipairs(walls) do
    v:draw()
  end
end
    

