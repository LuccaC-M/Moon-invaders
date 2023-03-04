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

-- Check if the Enemy should be moved
function EnemyModule.Enemy:CheckEnemy()
    if (self.y > 500) then
        self.y = 0
        self.x = math.random(0,1000)
    end
end

-- Move the enemy
function EnemyModule.Enemy:MoveEnemy(deltaTime)
    self.y = self.y + self.speed * deltaTime
end

return EnemyModule
