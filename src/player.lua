PlayerModule = {}
PlayerModule.Player = {}
PlayerModule.MetaPlayer = {}
PlayerModule.MetaPlayer.__index = PlayerModule.Player

PlayerModule.Player.y = 400
PlayerModule.Player.x = love.graphics.getWidth() / 2

function PlayerModule.Player:new(name)
    local instance = setmetatable({}, PlayerModule.MetaPlayer)
    instance.name = name
    return instance
end

function PlayerModule.Player:MovePlayer(steps, deltaTime)
    if love.keyboard.isDown('d') then
        self.x = self.x + steps * deltaTime;
    end
    if love.keyboard.isDown('a') then
        self.x = self.x - steps * deltaTime;
    end
end

function PlayerModule.Player:Shoot()
    if love.keyboard.isDown('space') then
        print("Shoot")
    end
end
return PlayerModule
