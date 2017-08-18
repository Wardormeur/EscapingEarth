local Map = gClass("Map")

function Map:init(map)
  self.map = map
  grassLayer = self:addLayer("grass")
  -- create a grass background layer
  local grass_tile_id = getTileID(map.tilesets[1], 22, 3)
  self:populateLayer(grassLayer, grass_tile_id)

  -- create a layer for the path
  local pathLayer = self:addLayer("path")
  self:populateLayer(pathLayer, 0)


  for x=0, pathLayer.width - 1 do
    setTile(pathLayer, x, 5, getTileID(map.tilesets[1], 19, 2))
    setTile(pathLayer, x, 6, getTileID(map.tilesets[1], 19, 3))
    setTile(pathLayer, x, 7, getTileID(map.tilesets[1], 19, 4))
  end
end
-- create a layer of the map, with the same height/width as the map
function Map:addLayer(name)
  local layer = {
    type = "tilelayer",
    name = name,
    x = 0,
    y = 0,
    width = 64,
    height = 64,
    visible = true,
    opacity = 1,
    offsetx = 0,
    offsety = 0,
    properties = {},
    encoding = "lua",
    data = {}
  }
  table.insert(self.map.layers, layer)
  return layer
end

-- populate the layer with a default tile ID
function Map:populateLayer(layer, tile_id)
  for i=1, layer.width * layer.height do
    table.insert(layer.data, tile_id)
  end
end

-- helper function to get the ID of a tile from the tileset using x,y coordinates
function getTileID(tileset, x, y)
  local width = tileset.imagewidth / tileset.tilewidth
  return x + y * width + 1 -- +1 because Tile ID 0 represents an empty tile
end


-- helper function to set a tile in the layer based on x,y coordinates
function setTile(layer, x, y, tile_id)
  layer.data[x + y * layer.width + 1] = tile_id -- +1 because Tile ID 0 represents an empty tile
end

return Map
