-- Player entity
Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "img/player.png")

  -- Make player stronger than the box
  self.strength = 10

  -- Make it so player can only jump when it hits the ground
  self.canJump = false
end

function Player:update(dt)
  -- Call the base base class function
  -- Important to do this before changing position
  Player.super.update(self, dt)

  -- Move left and right
  if love.keyboard.isDown("left") then
    self.x = self.x - 200 * dt
  elseif love.keyboard.isDown("right") then
    self.x = self.x + 200 * dt
  end

  -- Check if the previous y-pos is not equal to current y-pos, as when standing on the ground should not move vertically, and if so it means you're not standing on the ground
  if self.last.y ~= self.y then
    -- So it can't move vertically/jump when in air
    self.canJump = false
  end
end

function Player:jump()
  if self.canJump then
    -- Lessen the gravity so player jump, the lower the gravity value the higher the player jump
    self.gravity = -300
    self.canJump = false
  end
end

-- Override collide(e) so we can set canJump to false when hit bottom
function Player:collide(e, direction)
  Player.super.collide(self, e, direction)
  if direction == "bottom" then
    self.canJump = true
  end
end

-- Overide entity's checkResolve
function Player:checkResolve(e, direction)
  -- Check if e is type box; NOTE also works with base classes in that both [e:is(Box)] and [e:is(Entity)] would return [true]; 
  -- ! Also capitalized the class name
  if e:is(Box) then
    -- check if the direction is bottom i.e. collision between bottom of player and top of box
    if direction == "bottom"  then
      return true
    else
      -- ! Means player can walk through box
      return false
    end
  end
  -- Collision with any other entity resolved the collision
  return true
end

