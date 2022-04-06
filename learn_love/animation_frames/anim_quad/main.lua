-- Use quad to efficiently draw large animation without needing lots of images; Use fraction of said image and animate what's necessary
function love.load()
  -- load image
  image = love.graphics.newImage("img/jump.png")
  -- Get whole image width and height
  local width = image:getWidth()
  local height = image:getHeight()


  -- frames table
  frames = {}
  -- Each frame width & height
  local frame_width = 117
  local frame_height = 233
  
  -- newQuad 1st arg takes x, y position of the quad, for the first frame we take the top left corner of the image 0,0, 2nd arg is width and height of the quad, and lastly 3rd arg is the full size image not just the frame
  -- We use for-loop to get all 5 frames from the single image; since we know the width of  a single frame, we can use the width to calculate the x position of the next frame
  for i=0,4 do
    table.insert(frames, love.graphics.newQuad(i * frame_width ,0, frame_width, frame_height, width, height))
  end

  currentFrame = 1
end

function love.update(dt)
  -- currentFrame will increase according to dt; i.e. animate image
  currentFrame = currentFrame + 15 * dt
  
  -- Reset currentFrame when its above the number of frames available
  if currentFrame >= 6 then
    currentFrame = 1
  end
end

function love.draw()
  -- Use currentFrame for the quad frame we want to draw
  love.graphics.draw(image, frames[math.floor(currentFrame)], 250, 250)
end
