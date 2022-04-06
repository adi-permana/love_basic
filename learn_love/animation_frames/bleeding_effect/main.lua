-- When rotating/scaling image using quad, a bleeding effect can appear; this is because the image is not perfectly aligned with the quad, where part of the image outside of the quad needed is included/drawn
function love.load()
  -- load image
  image = love.graphics.newImage("img/jump_3.png")

  -- frames table
  frames = {}
  lineFrames = {}
  -- whole image height and width
  local width = image:getWidth()
  local height = image:getHeight()
  -- single frame height and width
  local frame_width = 117
  local frame_height = 233

  -- Cut image only until the fifth frame
  maxFrames = 5

  -- Get frames from image
  for i=0,1 do
    for j=0,2 do
      -- Since the first pixel has purple line across it we start at pixel 1 instead of the default i.e. [1 + j and 1 + i]; this only applies for the first frame, since the subsequent frame has purple line.
      -- To remove the line from the subsequent frames we bleed the image by adding 2 pixel in frame_width and frame_height, before multiplying by j and i/frame position [frame_width + 2 and frame_height + 2].
      table.insert(frames, love.graphics.newQuad( 1 + j * (frame_width + 2), 1 + i * (frame_height + 2), frame_width, frame_height, width, height))

      -- Example of when the line is drawn for each frame
      table.insert(lineFrames, love.graphics.newQuad(j * frame_width, i * frame_height, frame_width, frame_height, width, height))

      -- break loop when max frame hit
      if frames == maxFrames then
        break
      end
    end
    if frames == maxFrames then
      break
    end
  end

  currentFrame = 1
end

function love.update(dt)
  -- currentFrame will increase according to dt; i.e. animate image
  if love.keyboard.isDown("space") then
    currentFrame = currentFrame + 10 * dt
    print(math.floor(currentFrame))
  end

  -- Reset currentFrame when its above the number of frames available
  if currentFrame >= 6 then
    currentFrame = 1
  end
end

function love.draw()
  -- Draw animation without line border
  love.graphics.draw(image, frames[math.floor(currentFrame)], 100, 100)

  -- Draw without the line border removed
  love.graphics.draw(image, lineFrames[math.floor(currentFrame)], 300, 100)
  
  love.graphics.print("Press Spacebar to see next frame, or hold spacebar for a continous animation", 10, 10)
end