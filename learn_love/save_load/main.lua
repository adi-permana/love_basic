function love.load()
  -- Load lume for reading saved data table; as when saved data table it will output pointer only
  lume = require "lume"

  -- Create player obj
  player = {
    -- position
    x = 100,
    y = 100,

    size = 25,

    -- Player's score
    points = 0,

    -- Load player face
    image = love.graphics.newImage("img/face.png")
  }

  -- Coin table
  coins = {}

  -- Read save data if available, and use load it
  if love.filesystem.getInfo("savedata.txt") then
    file = love.filesystem.read("savedata.txt")
    -- Print save data into console
    print("DATA LOADED: "..file)
    -- Convert the save file into table readable by engine
    data = lume.deserialize(file)

    -- Apply the saved position, size and points of player
    player.x = data.player.x
    player.y = data.player.y
    player.size = data.player.size
    player.points = data.player.points
    
    -- Apply saved position of coins and number of availability
    for i,v in ipairs(data.coins) do
      coins[i] = {
        x = v.x,
        y = v.y,
        size = 10,
        image = love.graphics.newImage("img/dollar.png")
      }
    end
  -- If there is no save file
  else
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
  end
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
      player.points = player.points + 1
      player.size = player.size + 1
    end
  end

end

-- In general don't save data more than you don't need as it could increase size
function saveGame()
  -- Saved data table
  data = {}
  
  -- Saves player's data
  data.player = {
    x = player.x,
    y = player.y,
    size = player.size,
    points = player.points
  }

  -- Save amount of coins left over
  data.coins = {}
  for i,v in ipairs(coins) do
    -- Insert data/position of left over coins
    data.coins[i] = {x = v.x, y = v.y}
  end

  serialized = lume.serialize(data)
  print("DATA TO BE SAVE: "..serialized)
  -- Save the data to the love appdata folder as save file
  love.filesystem.write("savedata.txt", serialized)
end

function love.keypressed(key)
  if key == "f1" then
    saveGame()
  -- Reset game to no save file and start over
  elseif key == "f2" then
    -- Delete save file
    love.filesystem.remove("savedata.txt")
      -- restart game
      love.event.quit("restart")
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

  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Coins Collected: ".. player.points, 10, 10, 0, 1.5, 1.5)
  love.graphics.print("Press f1 to save. Press f2 to restart and delete save file.", 290, 570, 0, 1.5, 1.5)
end
