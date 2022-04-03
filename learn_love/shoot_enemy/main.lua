function love.load()
  Object = require "classic"
  require "player"
  require "enemy"
  require "bullet"

  -- Load player
  player = Player()
  -- Load enemy
  enemy = Enemy()
  -- Bullets table as we want to be able to shoot multiple at once
  listOfBullets = {}
end



function love.update(dt)
  player:update(dt)
  enemy:update(dt)

  -- Bullet movement
  for i,v in ipairs(listOfBullets) do
    v:update(dt)

    -- Check bullet collision with enemy
    v:checkCollision(enemy)

    -- Remove bullet when hit prop activated
    if v.hit then
      -- Remove from bullet list
      table.remove(listOfBullets, i)
    end
  end

end

function love.draw()
  player:draw()
  enemy:draw()

  -- Bullet drawn on window
  for i,v in ipairs(listOfBullets) do
    v:draw()
  end
end

-- Player shoots bullet
function love.keypressed(key)
  player:keyPressed(key)
end
