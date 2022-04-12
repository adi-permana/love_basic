-- Class for creating different entity
Entity = Object:extend()

function Entity:new(x, y, image_path)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage(image_path)
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  -- Save last position coordinate
  self.last = {}
  self.last.x = self.x
  self.last.y = self.y

  -- Add strength; entity with lower strength get pushed away
  self.strength = 0
end

function Entity:update()
  -- Set current position to the previous position
  self.last.x = self.x
  self.last.y = self.y
end

function Entity:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

-- Check for collection; Read chapter 13 on sheepolution for more info
function Entity:checkCollision(e)
  -- [e] will be the other entity where collision will be checked
  -- When self.x is further left than e.x
  return self.x + self.width > e.x
  -- When e.x is further right than self.x
  and self.x < e.x + e.width
  -- When self.y is further to the bottom than e.y
  and self.y + self.height > e.y
  -- When e.y is further to the top than self.y
  and self.y < e.y + e.height
end

-- Check if we are vertically colliding with the wall, and based on that push player away vertically.
function Entity:wasVerticallyAligned(e)
  -- Uses last.y because we want to know last vertical location
  return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end

-- Check if we are horizontally colliding with the wall, and based on that push player away horizontally.
function Entity:wasHorizontallyAlligned(e)
  -- Uses last.x because we want to know last horizontal location
  return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end


-- When collision detected resolve this
function Entity:resolveCollison(e)
  -- Check strength so doesnt matter if we call this function on the wall or player; The wall will stay put as it has higher strength
  if self.strength > e.strength then
    e:resolveCollison(self)
    -- Return so that it doesn't continue the function
    return
  end

  if self:checkCollision(e) then
    -- Check player's vertical allignment with wall
    if self:wasVerticallyAligned(e) then
      -- check center of player with center of wall
      if self.x + self.width/2 < e.x + e.width/2 then
        -- right side of PLAYER [self.x + self,width] - [e.x] left side of WALL
        local pushback = self.x + self.width - e.x
        -- alligned with left side of wall; push player left
        self.x = self.x - pushback
      else 
        -- right side of WALL [e.x + e.width] - [self.x] left side of PLAYER 
        local pushback = e.x + e.width - self.x
        -- Alligned with right side of wall; push player right
        self.x = self.x + pushback
      end
    -- Check player's horizontal allignment with wall
    elseif self:wasHorizontallyAlligned(e) then
      -- Check center of player with center wall
      if self.y + self.height/2 < e.y + e.height/2 then
        -- bottom side of PLAYER [self.y + self.height] - [e.y] top side of WALL
        local pushback = self.y + self.height - e.y
        -- alligned with top side of wall; push player up
        self.y = self.y - pushback
      else
        -- Bottom side of WALL [e.y + e.height] - [self.y] top side of PLAYER
        local pushback = e.y + e.height - self.y
        -- alligned with bottom side of wall; push player down
        self.y = self.y + pushback
      end
    end
  end
end