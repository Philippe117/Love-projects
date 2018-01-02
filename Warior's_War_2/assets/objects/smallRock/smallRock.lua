--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 28/12/17
-- Time: 1:25 PM
-- To change this template use File | Settings | File Templates.
--

smallRock = {}
smallRock.lifeTime = 5
smallRock.__index = smallRock
local path = "assets/objects/smallRock/"

function object.load()
    smallRock.image = love.graphics.newImage(""..path.."trace.png")
end

function smallRock.create(x, y, z, map, foes)
    local self = setmetatable({}, smallRock)
    self.position = {x=x, y=y, z=z }
    self.velocity = {x=0, y=0, z=0 }
    self.foes = foes
    self.map = map
    self.timeout = time.time+self.lifeTime
    camera.addElement(self)
    objectManager.subscribeObject(self)
    return self
end

function smallRock.update(self, dt)
    if self.timeout > time.time then
        self.velocity.y = self.velocity.y + 9.81*time.desiredRate*physicConstants.pixelPerMeter
        self.position.x = self.position.x+self.velocity.x*time.desiredRate
        self.position.y = self.position.y+self.velocity.y*time.desiredRate
        self.position.z = self.position.z+self.velocity.z*time.desiredRate
        local cx, cy, free = self.map:raycastCollision(self.position.x, self.position.y,
            self.position.x-self.velocity.x*time.desiredRate,
            self.position.y-self.velocity.y*time.desiredRate, 2)
        if not free then
            self.position.x = cx
            self.position.y = cy
            self.status = "dead"
        end
        if self.foes then
            for i, foe in pairs(self.foes) do
                local dx = foe.position.x-self.position.x
                local dy = foe.position.y-self.position.y
                local distance = ((dx)^2+ (dy)^2)
                if distance < 200 then
                    foe.status = "dead"
                    self.status = "dead"
                    break
                end
            end
        end
    else
        self.status = "dead"
    end
end

function smallRock.destroy(self)
--    map:damageMaterial(self.position.x, self.position.y, 20, 20, 2)
end

function smallRock.draw(self, x, y, r, s)
    local A = math.atan2(self.velocity.y, self.velocity.x)
    love.graphics.draw(self.image ,x , y, r+A, s*1, s*1, self.image:getWidth(), self.image:getHeight()/2)
end