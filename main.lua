require "conf"
require "Tile"

function love.load(arg)
  lg = love.graphics
  lk = love.keyboard
  lm = love.math
  player = {
    x = Tile.size,
    y = Tile.size,
    img = lg.newImage("sword.png"),
    speed = 100,
    hp = 100,
    dmg = 50,
  }
  imgs = {
    floor = lg.newImage("floor.png"),
    wall = lg.newImage("wall.png"),
    barrel = lg.newImage("barrel.png"),
    skull = lg.newImage("skull.png"),
    soul = lg.newImage("soul.png"),
  }
  loadRoom()
end

function love.update(dt)
  if lk.isDown("escape") or ((lk.isDown("lctrl") or lk.isDown("rctrl")) and lk.isDown("w")) then
    love.event.quit()
  end
  local lastx, lasty = player.x, player.y
  -- movement
  if lk.isDown("up") or lk.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  if lk.isDown("right") or lk.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  if lk.isDown("down") or lk.isDown("s") then
    player.y = player.y + player.speed * dt
  end
  if lk.isDown("left") or lk.isDown("a") then
    player.x = player.x - player.speed * dt
  end

  if player.x < 0 then
    player.x = 64 * 7
    loadRoom()
  elseif player.x > 64 * 7 then
    player.x = 0
    loadRoom()
  elseif player.y < 0 then
    player.y = 64 * 7
    loadRoom()
  elseif player.y > 64 * 7 then
    player.y = 0
    loadRoom()
  end

  --check for collisions
  for r = 1, 8 do
    for c = 1, 8 do
      if CheckCollision(player.x, player.y, cur[r][c].x, cur[r][c].y) then
        if cur[r][c].col then
          player.x, player.y = lastx, lasty
        end
        if cur[r][c].type == "skull" then
          player.hp = player.hp - cur[r][c].dmg * dt
          cur[r][c].hp = cur[r][c].hp - player.dmg * dt
          if cur[r][c].hp <= 0 then -- convert to soul
            cur[r][c] = nil
            cur[r][c] = Tile:Create{type = 5, x = Tile.size * c - Tile.size, y = Tile.size * r - Tile.size}
          end
        end
        if cur[r][c].type == "soul" and lk.isDown("e") then
          player.hp = player.hp + 5
          cur[r][c] = nil
          cur[r][c] = Tile:Create{type = 0, x = Tile.size * c - Tile.size, y = Tile.size * r - Tile.size}
        end
      end
    end
  end
end

function love.draw()
  for r = 1, 8 do
    for c = 1, 8 do
      -- lg.draw(imgs.floor, Tile.size * c - Tile.size, Tile.size * r - Tile.size)
      -- lg.printf(cur[r][c].type, cur[r][c].x, cur[r][c].y + Tile.size / 2 - 8, Tile.size, "centelr")
    end
  end
  for r = 1, 8 do
    for c = 1, 8 do
      if cur[r][c].type ~= "floor" then
        lg.draw(cur[r][c].img, cur[r][c].x, cur[r][c].y)
        -- lg.rectangle("line", cur[r][c].x, cur[r][c].y, Tile.size, Tile.size)
        lg.printf(cur[r][c].type, cur[r][c].x, cur[r][c].y + Tile.size / 2 - 8, Tile.size, "center")
      end
      if cur[r][c].type == "skull" then
        lg.printf(math.floor(cur[r][c].hp), cur[r][c].x, cur[r][c].y + Tile.size / 2 + 4, Tile.size, "center")
      end
      if cur[r][c].type == "soul" then
        lg.printf("[e]", cur[r][c].x, cur[r][c].y + Tile.size / 2 + 4, Tile.size, "center")
      end
    end
  end
  --draw player
  if player.hp > 0 then
    lg.draw(player.img, player.x, player.y)
    -- lg.rectangle("line", player.x, player.y, Tile.size, Tile.size)
    lg.printf("sword\n" .. math.floor(player.hp), player.x, player.y + Tile.size / 2 - 8, Tile.size, "center")
  end
end

function CheckCollision(x1, y1, x2, y2)
  return x1 < x2 + Tile.size - 1 and
  x2 < x1 + Tile.size - 1 and
  y1 < y2 + Tile.size - 1 and
  y2 < y1 + Tile.size - 1
end

function loadRoom()
  cur = {num = lm.random(#room)}
  for r = 1, 8 do
    cur[r] = {}
    for c = 1, 8 do
      cur[r][c] = Tile:Create{type = room[cur.num][r][c], x = Tile.size * c - Tile.size, y = Tile.size * r - Tile.size}
    end
  end
  --place skulls
  local placed = 0
  while (placed < 4) do
    local skullr, skullc = lm.random(2, 7), lm.random(2, 7)
    if cur[skullr][skullc].type == "floor" then
      cur[skullr][skullc] = Tile:Create{type = 4, x = Tile.size * skullc - Tile.size, y = Tile.size * skullr - Tile.size}
      placed = placed + 1
    end
  end
end
