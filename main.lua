lovelyMoon = require("lovelyMoon/main")
gClass = require("30log/30log-global")
inspect = require("inspect/inspect")
windowWidth = love.graphics.getWidth()
windowHeight = love.graphics.getHeight()

states = {}
function love.load()
  states.menu = lovelyMoon.addState("states.menu", "menu")
  states.game = lovelyMoon.addState("states.game", "game")
  states.over = lovelyMoon.addState("states.over", "gameover")
  lovelyMoon.enableState("menu")
end

function love.update(dt)
  lovelyMoon.event.update(dt)
end

function love.draw()
  lovelyMoon.event.draw()
end

function love.keypressed(key, unicode)
  lovelyMoon.event.keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
  lovelyMoon.event.keyreleased(key, unicode)
end

function love.mousepressed(x, y, button)
  lovelyMoon.event.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
  lovelyMoon.event.mousereleased(x, y, button)
end
