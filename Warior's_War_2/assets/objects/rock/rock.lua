--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 28/12/17
-- Time: 1:25 PM
-- To change this template use File | Settings | File Templates.
--

rock = {}
rock.__index = rock
local path = "assets/objects/rock/"
rock.range = 4000

function object.load()
    rock.image = love.graphics.newImage(""..path.."bule.png")
end

function rock.create(x, y, z, map, foes)
    local self = setmetatable({}, rock)
    self.position = {x=x, y=y, z=z }
    self.velocity = {x=0, y=0, z=0 }
    self.foes = foes
    self.map = map
    camera.addElement(self)
    objectManager.subscribeObject(self)
    return self
end

function rock.update(self, dt)
    self.velocity.y = self.velocity.y + 9.81*time.desiredRate*physicConstants.pixelPerMeter
    self.position.x = self.position.x+self.velocity.x*time.desiredRate
    self.position.y = self.position.y+self.velocity.y*time.desiredRate
    self.position.z = self.position.z+self.velocity.z*time.desiredRate

    local angle = self.map:sphericalCollision(self.position.x, self.position.y, 15, 20)
    if angle ~= -10 then
--        self.velocity.x = self.velocity.x+(0-self.velocity.x)*0.9
        self.position.x = self.position.x-math.cos(angle)*0.1
        self.position.y = self.position.y-math.sin(angle)*0.1
        self.velocity.x, self.velocity.y = customPhysic.rebound(self.velocity.x, self.velocity.y, angle, 0.5, 0)
--        map:damageMaterial(self.position.x, self.position.y, 30, 10, 0.5)
    end
    if self.target then
        local dx = self.target.position.x-self.position.x
        local dy = self.target.position.y-self.position.y
        local dz = self.target.position.z-self.position.z
        local distance = ((dx)^2+ (dy)^2+(dz)^2)^0.5
        if distance < self.range then
            local projectile = smallRock.create(self.position.x, self.position.y, self.position.z, self.map, self.foes)
            projectile.velocity.x,
            projectile.velocity.y,
            projectile.velocity.z = aiTools.calculateFireSolution(
                    self, self.target, {x=0, y=9.81*time.desiredRate*physicConstants.pixelPerMeter, z=0}, distance/5000*physicConstants.pixelPerMeter)
        else
            self.target = nil
        end
    end
    if self.position.y > 2000 then
        self.status = "dead"
    end
end

function rock.slowUpdate(self, dt)
    if self.foes then
        self.target = nil
        local targetDistance = self.range^2
        for i, foe in pairs(self.foes) do
            local dx = self.position.x-foe.position.x
            local dy = self.position.y-foe.position.y
            if math.abs(dx) < self.range and math.abs(dy) < self.range then
                local distance = ( (dx)^2+ (dy)^2)
                if distance < targetDistance then
                    local x, y, sight = self.map:raycastCollision(
                        self.position.x, self.position.y, foe.position.x, foe.position.y, 4)
                    if sight then
                        targetDistance = distance
                        self.target = foe
                    end
                end
            end
        end
    end
end

function rock.draw(self, x, y, r, s)
    love.graphics.draw(self.image ,x , y, r, s, s, self.image:getHeight()/2, self.image:getWidth()/2)
end
