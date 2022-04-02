function love.load()
  -- Load the image and store it in myImage var. (use camelCasing)
  -- Image can also be put into subdrectory but need the "whole/path/my.img"
  myImage = love.graphics.newImage("sheep.png")
  -- Above actually return an obj, we can use to edit and get img data, such as height and width
  width = myImage:getWidth()
  height = myImage:getHeight()
  love.graphics.setBackgroundColor(1, 1, 1)
end

function love.draw()
  -- love.graphics.draw args:
  --  love.graphics.draw(image_var, x, y, rotation/angle, x-scale, y-scale)
  love.graphics.draw(myImage, 300, 100, 0, 2, 2)
  -- using min number on x-scale mirrors the image.
  love.graphics.draw(myImage, 300, 100, 0, -2, 2)
  -- If want to scale/rotate based on the center/origin of the image use x-origin and y-origin, as without this it will rotate based on the top-left of the image
  love.graphics.draw(myImage, 300, 100, 10, 2, 2, 39, 50)
  -- If want to skew the image use kx, ky
  love.graphics.draw(myImage, 400, 450, 0, 1, 1, 39, 50, 1, 2)
  -- put image in the center of the image
  love.graphics.setColor(0.78, 0.15, 0.5)
  -- Change only the color of the specific image below
  love.graphics.draw(myImage, 300, 100, 0, 2, 2, width/2, height/2)
  love.graphics.setColor(1, 1, 1)
end

