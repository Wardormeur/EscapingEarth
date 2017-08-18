local state = {}
local astray = require("../astray/astray")
local suit = require("../SUIT")
local sti = require("../sti/sti/")
local Dungeon = require("../class/map")
local dress = {}
local tiles = {}
local world = {}
function state:new()
  love.graphics.setBackgroundColor( 0, 0, 0)
  return lovelyMoon.new(self)
end

function state:load()
  -- Should be move to :new()
  local height, width = 40, 40
  -- force all rooms to be squares, with 4 rooms
  local generator = astray.Astray:new( height/2-1, width/2-1, 30, 70, 50, astray.RoomGenerator:new(4, 2, 2, 2, 2) )
  local dungeon = generator:Generate()
  tiles = generator:CellToTiles( dungeon )
  local startingRoom = (dungeon.rooms)[1]
  local cell = startingRoom.bounds
  tiles[cell.X * 2 +1 ][cell.Y *2 +1 ] = 'Y'
  for y = 0, #tiles[1] do
    local line = ''
    local roomFound = false
    for x = 1, #tiles do
        line = line .. tiles[y][x]
    end
    print(line)
  end
  for y = #tiles[1], 1, -1 do
    local roomFound = false
    for x = 0, #tiles do
      if (tiles[y][x] == ' ' or tiles[y][x] == '|' or tiles[y][x] == '-') then roomFound = true end
    end
    if (not roomFound) then
      for x = 0, #tiles do
        table.remove(tiles[y], x)
      end
    end
  end



  -- To be moved to TilesToUi
  world = love.physics.newWorld()
  -- https://github.com/prust/sti-pg-example/blob/master/main.lua
  local mapdef = {
    orientation = "orthogonal",
    width = 64,
    height = 64,
    tilewidth = 32,
    tileheight = 32,
    tilesets = {},
    layers = {}
  }
  local tileset = {
    name = "terrain_atlas",
    firstgid = 1,
    tilewidth = 32,
    tileheight = 32,
    spacing = 0,
    margin = 0,
    image = "terrain_atlas.png",
    imagewidth = 1024,
    imageheight = 1024,
    tileoffset = {x = 0, y = 0},
    tilecount = 1024,
    tiles = {}
  }
  table.insert(mapdef.tilesets, tileset)
  local dungeon = Dungeon:new(mapdef)
  tileMap = sti(dungeon.map)
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

end

function state:draw()
  dress:draw()
  tileMap:draw()
  local minimapWidth, minimapHeight = 180, 180
  local lineWidth = 5 -- find a decent ratio between "too small" and "too big"
  local startX, startY = windowWidth - minimapWidth, windowHeight - minimapHeight
  love.graphics.setColor(255, 255, 255)
  local minimap = love.graphics.rectangle("fill", startX, startY, windowWidth - startX, windowHeight - startY)
  for y = #tiles[1], 1, -1 do
    for x = 0, #tiles do
      local rectX, rectY = startX+(x*lineWidth), startY+(y*lineWidth)
      if (tiles[y][x] == ' ' or tiles[y][x] == '|' or tiles[y][x] == '-') then
        love.graphics.setColor(0, 0, 0)
      else
        love.graphics.setColor(255, 255, 255)
      end
      if (rectX < windowWidth and rectY < windowHeight) then
        love.graphics.rectangle("fill", rectX, rectY, lineWidth, lineWidth )
      end
    end

  end
  -- love.graphics.setColor(128, 128, 128)
  -- love.graphics.points(startX + (cell.X * lineWidth), startX + (cell.Y * lineWidth))
end

function state:keypressed(key, unicode)
end

function state:keyreleased(key, unicode)

end

function state:mousepressed(x, y, button)

end

function state:mousereleased(x, y, button)

end

return state
