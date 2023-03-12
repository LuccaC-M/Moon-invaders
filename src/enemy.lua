EnemyModule = {}
EnemyModule.Enemy = {}
EnemyModule.Enemy.__index = EnemyModule.Enemy

-- Variables

-- Enemy Position
EnemyModule.Enemy.y = 0
EnemyModule.Enemy.x = 0

-- Other Variables
EnemyModule.Enemy.speed = 200
EnemyModule.Enemy.alive = true

-- Functions

-- Initializer
function EnemyModule.Enemy:new()
    local instance = setmetatable({},EnemyModule.Enemy)
    instance.y = math.random(0,1000)
    return instance
end

-- This functions makes the enemy work & do stuff
function EnemyModule.Enemy:Attack(deltaTime, Player)
    if (self.alive) then
        self:CheckEnemy()
        self:MoveEnemy(deltaTime)
    end
--  if the enemy collides with the Floor the Player looses
    if (DetectCollision(-10, 1100, 455, 150, self.x, 50, self.y, 50)) then
        PlayerHasLost = true
    end
    for _,v in pairs(Player.bullets) do
    --  if the shot collides with the Enemy then kill the Enemy
        if (DetectCollision(v.x, 15, v.y, 25, self.x, 50, self.y, 50)) then
            self.alive = false
            self.x = 10000
            self.y = 10000
        end
    end
end
-- Check if the Enemy should be moved
function EnemyModule.Enemy:CheckEnemy()
    if (self.y > 500) then
        self.y = 0
        self.x = math.random(0,1000)
    end
end

-- Move the enemy
function EnemyModule.Enemy:MoveEnemy(deltaTime)
    if (self.alive) then
        self.y = self.y + self.speed * deltaTime
    end
end

return EnemyModule
