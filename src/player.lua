PlayerModule = {}
PlayerModule.Player = {}
PlayerModule.Player.__index = PlayerModule.Player

-- Player Variables --

-- Player Position
PlayerModule.Player.y = 400
PlayerModule.Player.x = love.graphics.getWidth() / 2

-- Shot Position 
PlayerModule.Player.shotX = 50
PlayerModule.Player.shotY = 10000

-- Other Variables
PlayerModule.Player.speed = 400
PlayerModule.Player.shooting = false

-- Functions

-- Player initializer
function PlayerModule.Player:new()
    local instance = setmetatable({},PlayerModule.Player)
    return instance
end

-- Position the shoot inside the player to be "invisible"
function PlayerModule.Player:PosShoot()
    if (not self.shooting) then
        self.shotX = self.x + 20
        self.shotY = 10000
    end
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

function PlayerModule.Player:Shoot(deltaTime)
--  if space if is pressed then start shooting  
    if (love.keyboard.isDown('space') and self.shotY >= 1000) then
        self.shooting = true
        self.shotY = self.y
    end
--  if the shot is outside the screen change to not shooting state
    if (self.shotY < -10) then
        self.shooting = false
    end
--  move the shot if it is in the shooting state
    if(self.shooting) then
        self.shotY = self.shotY - 200 * deltaTime
    end
end

return PlayerModule
