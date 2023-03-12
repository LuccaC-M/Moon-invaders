PointModule = {}
PointModule.Point = {}
PointModule.Point.__index = PointModule.Point

-- Point Variables --

-- Point Position
PointModule.Point.y = 0
PointModule.Point.x = 0

-- Point initializer
function PointModule.Point:new(posX, posY)
    local instance = setmetatable({},PointModule.Point)
    instance.y = posY
    instance.x = posX
    return instance
end
