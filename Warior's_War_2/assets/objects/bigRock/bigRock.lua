--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 28/12/17
-- Time: 1:25 PM
-- To change this template use File | Settings | File Templates.
--

bigRock = {}
bigRock.__index = bigRock
local path = "assets/objects/bigRock/"
bigRock.range = 500
bigRock.cooldown = 1

function object.load()
    bigRock.image = love.graphics.newImage(""..path.."shine.png")
end

function bigRock.create(x, y, z, map, team, foes, movement)
    local self = setmetatable({}, bigRock)
    self.position = {x=x, y=y, z=z }
    self.velocity = {x=0, y=0, z=0 }
    self.movement = movement
    self.foes = foes
    self.team = team
    self.map = map
    self.cooldown = time.time+bigRock.cooldown
    self.target = {}
    setmetatable(self.target, { __mode = 'kv' })

    camera.addElement(self)
    objectManager.subscribeObject(self)
    return self
end

function bigRock.update(self, dt)
    self.velocity.y = self.velocity.y + 9.81*time.desiredRate*physicConstants.pixelPerMeter
    self.position.x = self.position.x+self.velocity.x*time.desiredRate
    self.position.y = self.position.y+self.velocity.y*time.desiredRate
    self.position.z = self.position.z+self.velocity.z*time.desiredRate

    local angle, contact = self.map:sphericalCollision(self.position.x, self.position.y, 10, 15)
    if contact then
        local try = 0
        while contact and try < 3 do
            self.position.x = self.position.x-math.cos(angle)*0.1
            self.position.y = self.position.y-math.sin(angle)*0.1
            angle, contact = self.map:sphericalCollision(self.position.x, self.position.y, 10, 15)
            try = try+1
        end
        self.velocity.x, self.velocity.y = customPhysic.rebound(self.velocity.x, self.velocity.y, angle, 0.2, 0)
--        self.velocity.x = self.velocity.x+(self.movement-self.velocity.x)*0.9
--        map:damageMaterial(self.position.x, self.position.y, 30, 10, 0.5)
    end
    if self.cooldown < time.time then
        local new = rock.create(self.position.x, self.position.y, self.position.z, self.map, self.foes)
        new.movement = self.movement
        self.cooldown = time.time+rock.cooldown
        table.insert(self.team, new)
    end
    if self.position.y > 1000 then
        self.status = "dead"
    end
end

function bigRock.destroy(self)
    print("ded")
end

function bigRock.draw(self, x, y, r, s)
--    if self.status ~= "dead" then
        love.graphics.draw(self.image ,x , y, r, s*0.5, s*0.5, self.image:getHeight()/2, self.image:getWidth()/2)
--    end
end
