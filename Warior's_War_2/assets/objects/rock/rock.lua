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
rock.range = 500
rock.cooldown = 1
rock.projectionSpeed = 2000
rock.projectionImprecision = 0.1

function object.load()
    rock.image = love.graphics.newImage(""..path.."bule.png")
end

function rock.create(x, y, z, map, foes)
    local self = setmetatable({}, rock)
    self.position = {x=x, y=y, z=z }
    self.velocity = {x=0, y=0, z=0 }
    self.movement = 0
    self.foes = foes
    self.map = map
    self.cooldown = time.time+rock.cooldown
    self.target = {}
    setmetatable(self.target, { __mode = 'kv' })

    camera.addElement(self)
    objectManager.subscribeObject(self)
    return self
end

function rock.update(self, dt)
    self.velocity.y = self.velocity.y + 9.81*time.desiredRate*physicConstants.pixelPerMeter
    self.position.x = self.position.x+self.velocity.x*time.desiredRate
    self.position.y = self.position.y+self.velocity.y*time.desiredRate
    self.position.z = self.position.z+self.velocity.z*time.desiredRate

    local angle, contact = self.map:sphericalCollision(self.position.x, self.position.y, 10, 15)
    if contact then
        local try = 0
        while contact and try < 3 do
            self.position.x = self.position.x-math.cos(angle)*0.15
            self.position.y = self.position.y-math.sin(angle)*0.15
            angle, contact = self.map:sphericalCollision(self.position.x, self.position.y, 10, 15)
            try = try+1
        end
        self.velocity.x, self.velocity.y = customPhysic.rebound(self.velocity.x, self.velocity.y, angle, 0.2, 0)
        if not self.target[1] then
            self.velocity.x = self.velocity.x+(self.movement-self.velocity.x)*0.9
        else
            self.velocity.x = self.velocity.x+(0-self.velocity.x)*0.9
        end
--        map:damageMaterial(self.position.x, self.position.y, 30, 10, 0.5)
    end
    if self.target[1] and self.cooldown < time.time then
        local dx = self.target[1].position.x-self.position.x
        local dy = self.target[1].position.y-self.position.y
        local dz = self.target[1].position.z-self.position.z
        local distance = ((dx)^2+ (dy)^2+(dz)^2)^0.5
        if distance < self.range then
            if dx > 0 then
                self.movement = 15
            else
                self.movement = -15
            end

            local projectile = smallRock.create(self.position.x, self.position.y, self.position.z, self.map, self.foes)
            projectile.velocity.x,
            projectile.velocity.y,
            projectile.velocity.z = aiTools.calculateFireSolution(
                    self, self.target[1], {x=0, y=9.81*physicConstants.pixelPerMeter, z=0}, distance/self.projectionSpeed*physicConstants.pixelPerMeter)
            projectile.velocity.x = projectile.velocity.x*(1+(math.random()-.5)*self.projectionImprecision)
            projectile.velocity.y = projectile.velocity.y*(1+(math.random()-.5)*self.projectionImprecision)
            projectile.velocity.z = projectile.velocity.z*(1+(math.random()-.5)*self.projectionImprecision)
        else
            self.target[1] = nil
        end
        self.cooldown = time.time+rock.cooldown
    end
    if self.position.y > 1000 then
        self.status = "dead"
    end
end

function rock.slowUpdate(self, dt)
    if self.foes then
        self.target[1] = nil
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
                        self.target[1] = foe
                    end
                end
            end
        end
    end
end

function rock.destroy(self)
    print("ded")
end

function rock.draw(self, x, y, r, s)
--    if self.status ~= "dead" then
        love.graphics.draw(self.image ,x , y, r, s*0.5, s*0.5, self.image:getHeight()/2, self.image:getWidth()/2)
--    end
end
