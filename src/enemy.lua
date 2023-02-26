EnemyModule = {}
EnemyModule.Enemy = {}
EnemyModule.MetaEnemy = {}
EnemyModule.MetaEnemy.__index = EnemyModule.Enemy

EnemyModule.Enemy.y = 0
EnemyModule.Enemy.x = 0

function EnemyModule.Enemy:CheckEnemy()
    if (self.y > 500) then
        self.y = 0
        self.x = math.random(0,1000)
    end
end
function EnemyModule.Enemy:new(name)
    local instance = setmetatable({}, EnemyModule.MetaEnemy)
    instance.name = name
    instance.y = math.random(0,1000)
    return instance
end

function EnemyModule.Enemy:MoveEnemy(steps, deltaTime)
    self.y = self.y + steps * deltaTime
end

return EnemyModule
