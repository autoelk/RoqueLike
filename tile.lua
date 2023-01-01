Tile = {
  x,
  y,
  size = 64,
  type,
  col = false,
  img,
}

room = {
  {
    {1, 1, 1, 0, 0, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 0, 0, 1, 1, 1},
  },
  {
    {1, 1, 1, 0, 0, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {0, 0, 0, 2, 2, 0, 0, 0},
    {0, 0, 0, 2, 2, 0, 0, 0},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 0, 0, 1, 1, 1},
  },
  {
    {1, 1, 1, 0, 0, 1, 1, 1},
    {1, 0, 1, 0, 0, 0, 0, 1},
    {1, 0, 1, 0, 0, 0, 0, 1},
    {0, 0, 1, 0, 2, 2, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0},
    {1, 0, 1, 1, 1, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 0, 0, 1, 1, 1},
  },
  {
    {1, 1, 1, 0, 0, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 2, 0, 0, 1},
    {0, 0, 2, 0, 0, 0, 0, 0},
    {0, 0, 2, 0, 0, 2, 0, 0},
    {1, 0, 0, 2, 2, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 0, 0, 1, 1, 1},
  },
  {
    {1, 1, 1, 0, 0, 1, 1, 1},
    {1, 0, 0, 0, 0, 2, 0, 1},
    {1, 2, 0, 0, 1, 0, 0, 1},
    {0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0},
    {1, 0, 0, 1, 0, 0, 2, 1},
    {1, 0, 2, 0, 0, 0, 0, 1},
    {1, 1, 1, 0, 0, 1, 1, 1},
  },
}

function Tile:Create(tile)
  local tile = tile or {}
  setmetatable(tile, self)
  self.__index = self
  if tile.type == 0 then
    tile.type = "floor"
    tile.col = false
  elseif tile.type == 1 then
    tile.type = "wall"
    tile.img = imgs.wall
    tile.col = true
  elseif tile.type == 2 then
    tile.type = "barrel"
    tile.img = imgs.barrel
    tile.col = true
  elseif tile.type == 4 then
    tile.type = "skull"
    tile.img = imgs.skull
    tile.dmg = 10
    tile.hp = 50
    tile.col = true
  elseif tile.type == 5 then
    tile.type = "soul"
    tile.img = imgs.soul
    tile.col = false
  end
  return tile
end
