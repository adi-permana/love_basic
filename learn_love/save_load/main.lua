function love.load()
  -- Create player obj
  player = {
    -- position
    x = 100,
    y = 100,

    size = 25,

    -- Load player face
    image = love.graphics.newImage("img/face.png")
  }

  -- Coin table
  coins = {}

  for i=1,25 do
    table.insert(coins, {
      -- Give it a random position
      -- love.math lib gives better random seed.
      x = love.math.random(50, 650),
      y = love.math.random(50, 450),

      size = 10,
      
      -- Load coin image
      image = love.graphics.newImage("img/dollar.png")
    })
  end

  points = 0
end

-- Check collision for the ability to collect coin
function checkCollision(p1, p2)
  -- Find distance
  local distance = math.sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)

  -- Return whether the distance is lower than the sum of the sizes/Meaning collision is detected if distance is lower than the sum of size p1 and p2.
  return distance < p1.size + p2.size
end

function love.update(dt)
  -- Player movement left and right
  if love.keyboard.isDown("left") then
    player.x = player.x - 200 * dt
  elseif love.keyboard.isDown("right") then
    player.x = player.x + 200 * dt
  end

  -- Seperate up and down player movement, so player can move diagonally
  if love.keyboard.isDown("up") then
    player.y = player.y - 200 * dt
  elseif love.keyboard.isDown("down") then
    player.y = player.y + 200 * dt
  end

  -- Remove coin if collision detected
  -- Start removing coins from table from the end
  for i=#coins,1,-1 do
    if checkCollision(player, coins[i]) then
      table.remove(coins, i)
      points = points + 1
      player.size = player.size + 1
    end
  end

end

function love.draw()
  -- Draw player
  love.graphics.setColor(love.math.colorFromBytes(255, 255, 0))
  love.graphics.circle("line", player.x, player.y, player.size)
  -- Add face to player
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(player.image, player.x, player.y, 0, 1, 1, player.image:getWidth()/2, player.image:getHeight()/2)

  -- Draw coins
  for i,v in ipairs(coins) do
    love.graphics.setColor(love.math.colorFromBytes(0, 128, 0))
    love.graphics.circle("line", v.x, v.y, v.size)
    love.graphics.draw(v.image, v.x, v.y, 0, 1, 1, v.image:getWidth()/2, v.image:getHeight()/2)
  end

  love.graphics.print("Points: ".. points, 10, 10)
end