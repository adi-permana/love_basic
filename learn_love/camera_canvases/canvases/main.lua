-- Have multiple canvas so you have multiplayer gameplay
function love.load()
  -- Create player 1 obj
  player1 = {
    -- position
    x = 100,
    y = 100,

    size = 25,

    -- Player's score
    points = 0,

    -- Load player face
    image = love.graphics.newImage("img/face.png")
  }
  -- Create player 2 obj
  player2 = {
    -- position
    x = 300,
    y = 100,

    size = 25,

    -- Player's score
    points = 0,

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

  -- Add camerashakes
  shakeDuration = 0
  -- Offset for dt so as to shake similarly in different screen refresh rate
  shakeWait = 0
  shakeOffset = {x = 0, y = 0}

  -- Create second canvas for 2nd player
  screenCanvas = love.graphics.newCanvas(400, 600)
end

-- Check collision for the ability to collect coin
function checkCollision(p1, p2)
  -- Find distance
  local distance = math.sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)

  -- Return whether the distance is lower than the sum of the sizes/Meaning collision is detected if distance is lower than the sum of size p1 and p2.
  return distance < p1.size + p2.size
end

function love.update(dt)
  -- Player 1 movement left and right
  if love.keyboard.isDown("left") then
    player1.x = player1.x - 200 * dt
  elseif love.keyboard.isDown("right") then
    player1.x = player1.x + 200 * dt
  end
  -- Seperate up and down player movement, so player can move diagonally
  if love.keyboard.isDown("up") then
    player1.y = player1.y - 200 * dt
  elseif love.keyboard.isDown("down") then
    player1.y = player1.y + 200 * dt
  end

    -- Player 2 movement left and right
  if love.keyboard.isDown("a") then
    player2.x = player2.x - 200 * dt
  elseif love.keyboard.isDown("d") then
    player2.x = player2.x + 200 * dt
  end
  -- Seperate up and down player movement, so player can move diagonally
  if love.keyboard.isDown("w") then
    player2.y = player2.y - 200 * dt
  elseif love.keyboard.isDown("s") then
    player2.y = player2.y + 200 * dt
  end

  -- Remove coin if collision detected
  -- Start removing coins from table from the end
  for i=#coins,1,-1 do
    if checkCollision(player1, coins[i]) then
      table.remove(coins, i)
      player1.points = player1.points + 1
      player1.size = player1.size + 1
      shakeDuration = 0.3
    elseif checkCollision(player2, coins[i]) then
      table.remove(coins, i)
      player2.points = player2.points + 1
      player2.size = player2.size + 1
      shakeDuration = 0.3
    end
  end

  -- Camera shakes
  if shakeDuration > 0 then
    shakeDuration = shakeDuration - dt
    -- Offset for delta time so shakes are the same on different screen
    if shakeWait > 0 then
      shakeWait = shakeWait - dt
    else
      shakeOffset.x = love.math.random(-5, 5)
      shakeOffset.y = love.math.random(-5, 5)
      shakeWait = 0.05
    end
  end
end

function love.draw()
  -- Draw the 1st canvas
  love.graphics.setCanvas(screenCanvas)
    love.graphics.clear()
    drawGame(player1)
  love.graphics.setCanvas()
  love.graphics.draw(screenCanvas)

  -- Draw the 2nd canvas
  love.graphics.setCanvas(screenCanvas)
    love.graphics.clear()
    drawGame(player2)
  love.graphics.setCanvas()
  love.graphics.draw(screenCanvas, 400)

  -- Line seperate the two canvas/screen
  love.graphics.line(400, 0, 400, 600)

  -- Points on screen
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Player 1: ".. player1.points, 10, 10, 0, 1.5, 1.5)
  love.graphics.print("Player 2: ".. player2.points, 10, 30, 0, 1.5, 1.5)

end

-- Drawing the game twice for player 1 and player 2
function drawGame(focus)
  -- Make copy of the state and push it to stack.
  -- Tab in what is pushed
  love.graphics.push()
    -- Makes player so its always in the center of the screen with the camera following its movement, by using a coordinate system
    love.graphics.translate(-focus.x + 200, -focus.y + 300)

    -- Shakes the camera when collected a coin
    if shakeDuration > 0 then
      -- translate random number between -5 to 5
      -- This translate will done base on the above love.graphics.translate, so as not to reset the above translate
      love.graphics.translate(shakeOffset.x, shakeOffset.y)
    end

    -- Draw player 1
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 0))
    love.graphics.circle("line", player1.x, player1.y, player1.size)
    -- Add face to player
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(player1.image, player1.x, player1.y, 0, 1, 1, player1.image:getWidth()/2, player1.image:getHeight()/2)

    -- Draw player 2
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 0))
    love.graphics.circle("line", player2.x, player2.y, player2.size)
    -- Add face to player
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(player2.image, player2.x, player2.y, 0, 1, 1, player2.image:getWidth()/2, player2.image:getHeight()/2)

    -- Draw coins
    for i,v in ipairs(coins) do
      love.graphics.setColor(love.math.colorFromBytes(0, 128, 0))
      love.graphics.circle("line", v.x, v.y, v.size)
      love.graphics.draw(v.image, v.x, v.y, 0, 1, 1, v.image:getWidth()/2, v.image:getHeight()/2)
      love.graphics.setColor(1, 1, 1)
    end

  -- Pull copy of the love.graphics.push state and apply it
  love.graphics.pop()
end