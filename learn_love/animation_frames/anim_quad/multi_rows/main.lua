-- Use multi-row frames from a single image
function love.load()
  -- load image
  image = love.graphics.newImage("img/jump_2.png")
  -- Get whole image width and height
  local width = image:getWidth()
  local height = image:getHeight()

  -- frames table
  frames = {}

  -- Each frame width & height
  local frame_width = 117
  local frame_height = 233

  -- Cut image only until the fifth frame
  maxFrames = 5

  -- Get frames from image
  -- Instead this time like traversting a table we use the height as well to get the position of the frame from the image
  -- Column position of the frame i.e. height
  for i=0,1 do
    -- Row position of the frame i.e. width
    for j=0,2 do
      table.insert(frames, love.graphics.newQuad(j * frame_width, i * frame_height, frame_width, frame_height, width, height))
    
      -- When we have reached the maxFrames, break the loop
      if frames == maxFrames then
        break
      end
    end
    -- This i loop will still run even if the break above is reached
    print("i still runs")
    -- Since its the last one we just let it run; if we want it to stop break the same way as  the j loop.
  end


  currentFrame = 1
end

function love.update(dt)
  -- currentFrame will increase according to dt; i.e. animate image
  currentFrame = currentFrame + 10 * dt

  -- Reset currentFrame when its above the number of frames available
  if currentFrame >= 6 then
    currentFrame = 1
  end
end

function love.draw()
  love.graphics.draw(image, frames[math.floor(currentFrame)], 350, 200)
end

