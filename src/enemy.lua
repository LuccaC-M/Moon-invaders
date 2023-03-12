EnemyModule = {}

-----------------
-- Enemy Class --
-----------------

EnemyModule.Enemy = {}
EnemyModule.Enemy.__index = EnemyModule.Enemy

-- Variables

-- Enemy Position
EnemyModule.Enemy.y = 0
EnemyModule.Enemy.x = 0

-- Other Variables
EnemyModule.Enemy.speed = 200
EnemyModule.Enemy.alive = true
EnemyModule.Enemy.direction = 1
-- Functions

-- Initializer
function EnemyModule.Enemy:new(posX, posY)
    local instance = setmetatable({},EnemyModule.Enemy)
    instance.x = posX
    instance.y = posY
    return instance
end

-- This functions makes the enemy work & do stuff
function EnemyModule.Enemy:Attack(deltaTime, Player)
    local hasHitWall
    if (self.alive) then
        self:MoveEnemy(deltaTime)
        hasHitWall = self:CheckScreenWall()
    end
--  if the enemy collides with the Floor the Player looses
    if (DetectCollision(-10, ScreenWidth+10, ScreenHeight-40, 1, self.x, 50, self.y, 50)) then
        PlayerHasLost = true
    end
    for _,v in pairs(Player.bullets) do
    --  if the shot collides with the Enemy then kill the Enemy
        if (DetectCollision(v.x, 15, v.y, 25, self.x, 50, self.y, 50)) then
            self.alive = false
            v.y = -100
            self.x = 10000
            self.y = 10000
        end
    end
    return hasHitWall
end
-- Check if the Enemy has touched the wall  
function EnemyModule.Enemy:CheckScreenWall()
    if (self.x >= ScreenWidth-50 or self.x <= 0) then
        return true
    end
end

-- Move the enemy
function EnemyModule.Enemy:MoveEnemy(deltaTime)
    if (self.alive) then
        self.x = self.x + (self.speed * self.direction) * deltaTime
    end
end

-------------------------
-- Enemy Manager Class --
-------------------------
-- This Idea Is inspired by Kofybrek's YouTube Video: https://youtube.com/watch?v=WfYNelQiQvc

EnemyModule.EnemyManager = {}
EnemyModule.EnemyManager.__index = EnemyModule.EnemyManager

-- Variables
EnemyModule.EnemyManager.Enemies = {}
EnemyModule.EnemyManager.EnemiesInY = 5
EnemyModule.EnemyManager.EnemiesInX = 11

-- Functions
-- Initializer
function EnemyModule.EnemyManager:new()
    return setmetatable({}, EnemyModule.EnemyManager)
end

--[[ Initialize Enemies as a 2d array
function EnemyModule.EnemyManager:InitEnemiesArray()
    for i = 1, do
        
    end
end]]
-- Generate a new enemy & add to Enemies array
function EnemyModule.EnemyManager:GenerateNewEnemy(posX, posY)
    table.insert(self.Enemies, EnemyModule.Enemy:new(posX, posY))
end

function EnemyModule.EnemyManager:EnemiesGoDown()
    for _,v in pairs(self.Enemies) do
        v.y = v.y + 50
        v.direction = v.direction * -1
        v.x = v.x + v.direction
    end
end

function EnemyModule.EnemyManager:StartNewLevel()
    for i = 0, self.EnemiesInX-1 do
        local posY = ScreenHeight / 100
        for j=0, self.EnemiesInY-1 do
            posY = posY + 100
            self:GenerateNewEnemy(i + (100*i), posY)
        end
    end
end
-- Remove dead Enemies & perform Attack function in alive enemies in the Enemies array
function EnemyModule.EnemyManager:Invade(deltaTime, Player)
    if #self.Enemies == 0 then
        self:StartNewLevel()
--      force the function to end
        return 0
    end

    for i,v in pairs(self.Enemies) do
        if not v.alive then
            table.remove(EnemyManger.Enemies,i)
        else
            local shouldGoDown = v:Attack(deltaTime, Player)
            if shouldGoDown then
                self:EnemiesGoDown()
            end
        end
    end
end

return EnemyModule
