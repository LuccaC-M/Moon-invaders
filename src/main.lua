EnemyModule = require("enemy")
PlayerModule = require("player")

function love.load()
--  Initialize Fullscreen
    success = love.window.setFullscreen(true)
--  Exit the game if not successful
    if not success then
        print("Fullscreen not successful!\n Exiting...")
        love.event.quit(1)
    end
--  Get screen dimentions & window properties
    ScreenWidth, ScreenHeight, ScreenFlags = love.window.getMode()
--  Initialize the Player & Enemy
    Player = PlayerModule.Player:new(ScreenWidth / 2,ScreenHeight - 100)
    EnemyManger = EnemyModule.EnemyManager:new() -- Yep, french people, Enemies are eating
    EnemyManger:GenerateNewEnemy()
    Timer = 1
--  Global Variables
    PlayerHasLost = false
end

function love.update(dt)
    Timer = Timer + dt
    Player:MovePlayer(dt)
    Player:Shoot(dt)
    EnemyManger:Invade(dt, Player)
end

function love.draw()
--  Player
    love.graphics.rectangle("fill", Player.x, Player.y, Player.width, Player.height)
--  bullets
    for _,v in pairs(Player.bullets) do
        love.graphics.rectangle("fill", v.x, v.y, 15, 25)
    end
--  Enemies
    for _,v in pairs(EnemyManger.Enemies) do
        love.graphics.rectangle("line", v.x, v.y, 50, 50)
    end
--  Floor
    love.graphics.line(-10, ScreenHeight-40, ScreenWidth+10, ScreenHeight-40)
    if (PlayerHasLost) then
        love.graphics.print("You Lose")
    end
end

function DetectCollision(ax, awidth, ay, aheight, bx, bwidth, by, bheight)
  return ax < bx+bwidth and bx < ax+awidth and ay < by+bheight and by < ay+aheight
end
