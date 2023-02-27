PlayerModule = {}
PlayerModule.Player = {}
PlayerModule.MetaPlayer = {}
PlayerModule.MetaPlayer.__index = PlayerModule.Player

PlayerModule.Player.y = 400
PlayerModule.Player.x = love.graphics.getWidth() / 2
PlayerModule.Player.shotX = 50
PlayerModule.Player.shotY = 50
PlayerModule.Player.shooting = false

function PlayerModule.Player:new(name)
    local instance = setmetatable({}, PlayerModule.MetaPlayer)
    instance.name = name
    return instance
end

-- Position the shoot inside the player to be "invisible"
function PlayerModule.Player:PosShoot()
    if (not self.shooting) then
        self.shotX = self.x + 20
        self.shotY = self.y
    end
end

function PlayerModule.Player:MovePlayer(steps,deltaTime)
    if love.keyboard.isDown('d') then
        self.x = self.x + steps * deltaTime;
    end
    if love.keyboard.isDown('a') then
        self.x = self.x - steps * deltaTime;
    end
end

function PlayerModule.Player:Shoot(deltaTime)
--  if space if is pressed then start shooting  
    if love.keyboard.isDown('space') then
        self.shooting = true
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
