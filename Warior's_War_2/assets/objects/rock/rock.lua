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

function object.load()
    rock.image = love.graphics.newImage(""..path.."bule.png")
    rock.cursor = {image = love.graphics.newImage(""..path.."shine.png")}
end

function rock.create(x, y, z, map, foes)
    local self = setmetatable({}, rock)
    self.position = {x=x, y=y, z=z }
    self.velocity = {x=0, y=0, z=0 }
    self.foes = foes
    self.map = map
    self.cursor = {position={x=x, y=y, z=z-1} }
    self.cursor.draw = rock.drawcursor
    self.cursor.image = rock.cursor.image
    camera.addElement(self)
    camera.addElement(self.cursor)
    objectManager.subscribeObject(self)
    return self
end

function rock.update(self, dt)
    self.velocity.y = self.velocity.y + 10*9.81*dt^2
    self.position.x = self.position.x+self.velocity.x
    self.position.y = self.position.y+self.velocity.y
    self.position.z = self.position.z+self.velocity.z

    local angle = self.map:sphericalCollision(self.position.x, self.position.y, 15, 20)
    if angle ~= -10 then
--        self.velocity.x = self.velocity.x+(0-self.velocity.x)*0.9
        self.position.x = self.position.x-math.cos(angle)*0.1
        self.position.y = self.position.y-math.sin(angle)*0.1
        self.velocity.x, self.velocity.y = customPhysic.rebound(self.velocity.x, self.velocity.y, angle, 0, 0)
        map:damageMaterial(self.position.x, self.position.y, 30, 10, 0.5)
    end
end

function rock.slowUpdate(self, dt)
    if self.foes then
        self.target = nil
        local targetDistance = self.range^2
        for i, foe in pairs(self.foes) do
            local distance = (
                    (self.position.x-foe.position.x)^2+
                    (self.position.y-foe.position.y)^2+
                    (self.position.z-foe.position.z)^2)
            local x, y, sight = self.map:raycastCollision(
                self.position.x, self.position.y, foe.position.x, foe.position.y, 2)
            if distance < targetDistance and sight then
                targetDistance = distance
                self.target = foe
                self.cursor.position.x = self.target.position.x
                self.cursor.position.y = self.target.position.y
            end
        end
    end
end

function rock.draw(self, x, y, r, s)
    love.graphics.draw(self.image ,x , y, r, s, s, self.image:getHeight()/2, self.image:getWidth()/2)
end

function rock.drawcursor(self, x, y, r, s)
    love.graphics.draw(self.image ,x , y, r, s, s, self.image:getHeight()/2, self.image:getWidth()/2)
end