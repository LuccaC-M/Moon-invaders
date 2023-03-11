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
    if (Enemies[1].alive) then
        Enemies[1]:CheckEnemy()
        Enemies[1]:MoveEnemy(dt)
    end
--  if the enemy collides with the Floor the Player looses
    if (DetectCollision(-10, 1100, 455, 150, Enemies[1].x, 50, Enemies[1].y, 50)) then
        PlayerHasLost = true
    end
--  if the shot collides with the Enemy then kill the Enemy
    if (DetectCollision(Player.shotX, 15, Player.shotY, 25, Enemies[1].x, 50, Enemies[1].y, 50)) then
        Enemies[1].alive = false
        Enemies[1].x = 10000
        Enemies[1].y = 10000
        Player.shotY = 10000
        Player.shooting = false
    end
end

function love.draw()
--  Player
    love.graphics.rectangle("fill", Player.x, Player.y, 50, 50)
--  Shot
    love.graphics.rectangle("fill", Player.shotX, Player.shotY, 15, 25)
--  Enemy
    if (Enemies[1].alive) then
        love.graphics.rectangle("line", Enemies[1].x, Enemies[1].y, 50, 50)
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
