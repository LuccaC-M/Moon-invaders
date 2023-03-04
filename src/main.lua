EnemyModule = require("enemy")
PlayerModule = require("player")

function love.load()
--  Initialize the Player & Enemy
    Player = PlayerModule.Player:new()
    EnemyOne = EnemyModule.Enemy:new()
--  Global Variables
    PlayerHasLost = false
end

function love.update(dt)
    Player:MovePlayer(dt)
    Player:PosShoot()
    Player:Shoot(dt)
    if (EnemyOne.alive) then
        EnemyOne:CheckEnemy()
        EnemyOne:MoveEnemy(dt)
    end
    if (DetectCollision(-10, 1100, 455, 150, EnemyOne.x, 50, EnemyOne.y, 50)) then
        PlayerHasLost = true
    end
--  if the shot collides with the Enemy then kill the Enemy
    if (DetectCollision(Player.shotX, 15, Player.shotY, 25, EnemyOne.x, 50, EnemyOne.y, 50)) then
        EnemyOne.alive = false
        EnemyOne.x = 10000
        EnemyOne.y = 10000
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
    if (EnemyOne.alive) then
        love.graphics.rectangle("line", EnemyOne.x, EnemyOne.y, 50, 50)
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
