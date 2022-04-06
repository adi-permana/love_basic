-- Make animated image
function love.load()
  frames = {}

  -- Load the images and put them in the frames table
  -- table.insert(frames, love.graphics.newImage("img/jump1.png"))
  -- table.insert(frames, love.graphics.newImage("img/jump2.png"))
  -- table.insert(frames, love.graphics.newImage("img/jump3.png"))
  -- table.insert(frames, love.graphics.newImage("img/jump4.png"))
  -- table.insert(frames, love.graphics.newImage("img/jump5.png"))
  -- Or more effieciently
  for i = 1, 5 do
    table.insert(frames, love.graphics.newImage("img/jump" .. i .. ".png"))
  end

  -- Since we want to change the frame one at a time, we use currentFrame to keep track the frame
  currentFrame = 1
end

function love.update(dt)
  -- currentFrame will increase according to dt
  currentFrame = currentFrame + 15 * dt

  -- Reset currentFrame when its above the number of frames available
  if currentFrame >= 6 then
    currentFrame = 1
  end
end

function love.draw()
  -- Since currentFrame will have decimal, use math.floor to round it down
  love.graphics.draw(frames[math.floor(currentFrame)])
end


