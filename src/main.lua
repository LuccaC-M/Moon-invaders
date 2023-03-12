EnemyModule = require("enemy")
PlayerModule = require("player")

function love.load()
--  Initialize the Player & Enemy
    Player = PlayerModule.Player:new()
    Enemies = {EnemyModule.Enemy:new(), EnemyModule.Enemy:new()}
    Timer = 1
--  Global Variables
    PlayerHasLost = false
end

function love.update(dt)
    Timer = Timer + dt
    Player:MovePlayer(dt)
    Player:Shoot(dt)
    for i,v in pairs(Enemies) do
        if not v.alive then
            table.remove(Enemies,i)
        else
            v:Attack(dt, Player)
        end
    end
end

function love.draw()
--  Player
    love.graphics.rectangle("fill", Player.x, Player.y, Player.width, Player.height)
--  bullets
    for _,v in pairs(Player.bullets) do
        love.graphics.rectangle("fill", v.x, v.y, 15, 25)
    end
--  Enemies
    for _,v in pairs(Enemies) do
        love.graphics.rectangle("line", v.x, v.y, 50, 50)
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
