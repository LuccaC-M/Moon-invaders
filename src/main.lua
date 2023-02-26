EnemyModule = require("enemy")
PlayerModule = require("player")

function love.load()
    Player = PlayerModule.Player:new()
    EnemyOne = EnemyModule.Enemy:new()
end

function love.update(dt)
    Player:MovePlayer(400,dt)
    EnemyOne:CheckEnemy()
    EnemyOne:MoveEnemy(200,dt)
end

function love.draw()
    love.graphics.rectangle("line", Player.x, Player.y, 50, 50)
    love.graphics.rectangle("fill", EnemyOne.x, EnemyOne.y, 50, 50)
end
