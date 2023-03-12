require("point")

PlayerModule = {}
PlayerModule.Player = {}
PlayerModule.Player.__index = PlayerModule.Player

-- Player Variables --

-- Player Position
PlayerModule.Player.y = 0
PlayerModule.Player.x = 0

-- bullets
PlayerModule.Player.bullets = {}
PlayerModule.Player.canShoot = true
PlayerModule.Player.bulletSpeed = 400

-- Other Variables
PlayerModule.Player.speed = 400
PlayerModule.Player.width = 50
PlayerModule.Player.height = 50

-- Functions

-- Player initializer
function PlayerModule.Player:new(posX, posY)
    local instance = setmetatable({},PlayerModule.Player)
    instance.x = posX
    instance.y = posY
    return instance
end

-- Move the Player depending on input & position
function PlayerModule.Player:MovePlayer(deltaTime)
--  Incase that the player is offscreen teleport him to the other side
    if (self.x <= -10) then
        self.x = ScreenWidth+10
    elseif (self.x >= ScreenWidth+10) then
        self.x = -10
    end
--  Move if d or a has been pressed in the keyboard
    if love.keyboard.isDown('d') then
        self.x = self.x + self.speed * deltaTime;
    end
    if love.keyboard.isDown('a') then
        self.x = self.x - self.speed * deltaTime;
    end
end

-- Create a new bullet & add to bullets array
function PlayerModule.Player:CreateNewBullet()
    table.insert(self.bullets, PointModule.Point:new(self.x + 20, self.y))
end

function PlayerModule.Player:Shoot(deltaTime)
--  if space if is pressed then start create a new bullet  
    if (love.keyboard.isDown('space') and Timer >= 1) then
        Timer = 0
        self:CreateNewBullet()
    end
--  if the bullets are off screen remove them else move the bullets up
    for i,v in pairs(self.bullets) do
        if v.y <= -10 then
            table.remove(self.bullets, i)
        else
            v.y = v.y - self.bulletSpeed * deltaTime
        end
    end
end
-- 20
return PlayerModule
