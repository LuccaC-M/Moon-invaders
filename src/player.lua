require("point")

PlayerModule = {}
PlayerModule.Player = {}
PlayerModule.Player.__index = PlayerModule.Player

-- Player Variables --

-- Player Position
PlayerModule.Player.y = 400
PlayerModule.Player.x = love.graphics.getWidth() / 2

-- bullets array
PlayerModule.Player.bullets = {}

-- Other Variables
PlayerModule.Player.speed = 400
PlayerModule.Player.canShoot = true
PlayerModule.Player.width = 50
PlayerModule.Player.height = 50

-- Functions

-- Player initializer
function PlayerModule.Player:new()
    return setmetatable({},PlayerModule.Player)
end

-- Move the Player depending on input & position
function PlayerModule.Player:MovePlayer(deltaTime)
--  Incase that the player is offscreen teleport him to the other side
    if (self.x <= -60) then
        self.x = 800
    elseif (self.x >= 800) then
        self.x = -60
    end
--  Move if d or a has been pressed in the keyboard
    if love.keyboard.isDown('d') then
        self.x = self.x + self.speed * deltaTime;
    end
    if love.keyboard.isDown('a') then
        self.x = self.x - self.speed * deltaTime;
    end
end

function PlayerModule.Player:CreateNewBullet()
    table.insert(self.bullets, PointModule.Point:new(self.x + 20, self.y))
end

function PlayerModule.Player:Shoot(deltaTime)
--  if space if is pressed then start shooting  
    if (love.keyboard.isDown('space') and Timer >= 1) then
        Timer = 0
        self:CreateNewBullet()
    end
--  move the shot if it is in the shooting state
    for _,v in pairs(self.bullets) do
        v.y = v.y - 200 * deltaTime
    end
end
-- 20
return PlayerModule
