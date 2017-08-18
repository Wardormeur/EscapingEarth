local state = {}
suit = require('../SUIT')
local dress = {}
function state:new()
  return lovelyMoon.new(self)
end

function state:load()
  dress = suit.new()
end

function state:close()
  dress:exitFrame()
end

function state:enable()

end

function state:disable()
  dress:exitFrame()
end

function state:update(dt)
  local buttonHeight = 30
  local buttonWidth = 300
  startButton = dress:Button("Play!", (windowWidth - buttonWidth) / 2, (windowHeight - buttonHeight) / 2, buttonWidth, buttonHeight)
  if startButton.hit then
    lovelyMoon.switchState('menu', 'game')
  end
end

function state:draw()
  dress:draw()
end

function state:keypressed(key, unicode)
  if key == 'p' then
    lovelyMoon.switchState('menu', 'game')
  end

end

function state:keyreleased(key, unicode)

end

function state:mousepressed(x, y, button)

end

function state:mousereleased(x, y, button)

end

return state
