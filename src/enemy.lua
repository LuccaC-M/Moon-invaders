require("point")

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

function EnemyModule.Enemy:Shoot()
--  0.02% probability of enemy shooting per frame
    if math.random(1, 5000) == 1 then
        return PointModule.Point:new(self.x + 20, self.y)
    else
        return nil
    end
end
-- This functions makes the enemy move, shoot & detect collisions
function EnemyModule.Enemy:Attack(deltaTime, Player, EnemySpeed)
    local hasHitWall
    if (self.alive) then
        self:MoveEnemy(deltaTime, EnemySpeed)
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
    return hasHitWall, self:Shoot()
end
-- Check if the Enemy has touched the wall  
function EnemyModule.Enemy:CheckScreenWall()
    if (self.x >= ScreenWidth-50 or self.x <= 0) then
        return true
    end
end

-- Move the enemy
function EnemyModule.Enemy:MoveEnemy(deltaTime, EnemySpeed)
    if (self.alive) then
        self.x = self.x + (EnemySpeed * self.direction) * deltaTime
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
EnemyModule.EnemyManager.EnemySpeed = 75
EnemyModule.EnemyManager.bullets = {}
EnemyModule.EnemyManager.BulletSpeed = 5
-- Functions
-- Initializer
function EnemyModule.EnemyManager:new()
    return setmetatable({}, EnemyModule.EnemyManager)
end

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
    self.EnemySpeed = 75
    for i = 0, self.EnemiesInX-1 do
        local posY = ScreenHeight / 100
        for _=0, self.EnemiesInY-1 do
            posY = posY + 100
            self:GenerateNewEnemy(i + (100*i), posY)
        end
    end
end

function EnemyModule.EnemyManager:MoveBullets(deltaTime)
    for i,v in pairs(self.bullets) do
        if v.y > ScreenHeight then
            table.remove(self.bullets, i)
        else
            v.y = v.y + self.BulletSpeed * deltaTime
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
        local shouldGoDown
        if not v.alive then
            table.remove(EnemyManger.Enemies,i)
            self.EnemySpeed = math.min(self.EnemySpeed + 5, 250)
        else
            shouldGoDown, self.bullets[i] = v:Attack(deltaTime, Player, self.EnemySpeed)
            if shouldGoDown then
                self:EnemiesGoDown()
            end
        end
    end

    self:MoveBullets(deltaTime)
end

return EnemyModule
