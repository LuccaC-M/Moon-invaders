EnemyModule = require("enemy")
PlayerModule = require("player")

function love.load()
--  Initialize the Player & Enemy
    Player = PlayerModule.Player:new()
    Enemies = {EnemyModule.Enemy:new(), EnemyModule.Enemy:new()}
--    Enemies[1] = EnemyModule.Enemy:new()
--  Global Variables
    PlayerHasLost = false
end

function love.update(dt)
    Player:MovePlayer(dt)
    Player:PosShoot()
    Player:Shoot(dt)
    Enemies[1]:Attack(dt, Player)
    Enemies[2]:Attack(dt, Player)
end

function love.draw()
--  Player
    love.graphics.rectangle("fill", Player.x, Player.y, 50, 50)
--  Shot
    love.graphics.rectangle("fill", Player.shotX, Player.shotY, 15, 25)
--  Enemies
    if (Enemies[1].alive) then
        love.graphics.rectangle("line", Enemies[1].x, Enemies[1].y, 50, 50)
    end
    if (Enemies[2].alive) then
        love.graphics.rectangle("line", Enemies[2].x, Enemies[2].y, 50, 50)
    end
--  Floor
    love.graphics.rectangle("line", -10, 455, 1100, 150)
    if (PlayerHasLost) then
        love.graphics.print("You Lose")
    end
end

function DetectCollision(ax, awidth, ay, aheight, bx, bwidth, by, bheight)
  return ax < bx+bwidth and bx < ax+awidth and ay < by+bheight and by < ay+aheight
end
