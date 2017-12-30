--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 28/12/17
-- Time: 1:25 PM
-- To change this template use File | Settings | File Templates.
--

rocks = {}
local path = "assets/objects/rock/"

function object.load()
    rocks.image = love.graphics.newImage(""..path.."bule.png")
end

function rocks.create(x, y, z)
    local rock = {}
    rock.position = {x=x, y=y, z=z }
    rock.velocity = {x=0, y=0, z=0}
    rock.update = rocks.update
    rock.image = rocks.image
    rock.draw = rocks.draw
    camera.addElement(rock)
    objectManager.subscribeObject(rock)
    return rock
end

function rocks.update(rock, dt)
    rock.velocity.y = rock.velocity.y + 10*9.81*dt^2
--    local ox, oy, oz = rock.position.x, rock.position.y, rock.position.z
    rock.position.x = rock.position.x+rock.velocity.x
    rock.position.y = rock.position.y+rock.velocity.y
    rock.position.z = rock.position.z+rock.velocity.z

    local angle = map:sphericalColision(rock.position.x, rock.position.y, 15, 20)
    if angle ~= -10 then
--        print(angle)
--        rock.position.x, rock.position.y, rock.position.z = ox, oy, oz
        rock.position.x = rock.position.x-math.cos(angle)*0.1
        rock.position.y = rock.position.y-math.sin(angle)*0.1
--        rock.velocity.x, rock.velocity.y = 0, 0
        rock.velocity.x, rock.velocity.y = customPhysic.rebound(rock.velocity.x, rock.velocity.y, angle, 0.1, 0)
        map:damageMaterial(rock.position.x, rock.position.y, 100, 40, 1)
    end
end

function rocks.draw(self, x, y, r, s)
    love.graphics.draw(self.image ,x , y, r, s, s, self.image:getHeight()/2, self.image:getWidth()/2)
end