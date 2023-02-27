EnemyModule = require("enemy")
PlayerModule = require("player")

function love.load()
--  Initialize the Player & Enemy
    Player = PlayerModule.Player:new()
    EnemyOne = EnemyModule.Enemy:new()
end

function love.update(dt)
    Player:MovePlayer(dt)
    Player:PosShoot()
    Player:Shoot(dt)
    EnemyOne:CheckEnemy()
    EnemyOne:MoveEnemy(dt)
end

function love.draw()
--  Player
    love.graphics.rectangle("fill", Player.x, Player.y, 50, 50)
--  Shot
    love.graphics.rectangle("fill", Player.shotX, Player.shotY, 15, 25)
--  Enemy
    love.graphics.rectangle("line", EnemyOne.x, EnemyOne.y, 50, 50)
end
