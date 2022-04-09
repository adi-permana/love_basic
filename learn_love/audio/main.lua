-- Add audio and load
function love.load()
  -- Load song
  -- Rule of thumb use "stream" for song, use "static" for sound effects.
  song =love.audio.newSource("sound/song.ogg", "stream")

  -- Loop song
  song:setLooping(true)
  -- Play song
  song:play()

  -- Load sound effect
  -- For sfx use static
  sfx = love.audio.newSource("sound/sfx.ogg", "static")
end

-- Function for pressing key
function love.keypressed(key)
  -- When spacebar is pressed sfx sound will play
  if key == "space" then
    sfx:play()
  end
end

