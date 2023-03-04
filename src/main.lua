EnemyModule = require("enemy")
PlayerModule = require("player")

function love.load()
--  Initialize the Player & Enemy
    Player = PlayerModule.Player:new()
    EnemyOne = EnemyModule.Enemy:new()
--  Global variables
    ShotKill = false
end

function love.update(dt)
    Player:MovePlayer(dt)
    Player:PosShoot()
    Player:Shoot(dt)
    EnemyOne:CheckEnemy()
    EnemyOne:MoveEnemy(dt)
    ShotKill = DetectCollision(Player.shotX, 15, Player.shotY, 25, EnemyOne.x, 50, EnemyOne.y, 50)
end

function love.draw()
--  Player
    love.graphics.rectangle("fill", Player.x, Player.y, 50, 50)
--  Shot
    love.graphics.rectangle("fill", Player.shotX, Player.shotY, 15, 25)
--  Enemy
    if (not ShotKill) then
        love.graphics.rectangle("line", EnemyOne.x, EnemyOne.y, 50, 50)
    end
end

function DetectCollision(ax, awidth, ay, aheight, bx, bwidth, by, bheight)
  return ax < bx+bwidth and bx < ax+awidth and ay < by+bheight and by < ay+aheight
end
