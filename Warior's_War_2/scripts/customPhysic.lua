--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 30/12/17
-- Time: 12:17 AM
-- To change this template use File | Settings | File Templates.
--

customPhysic = {}
function customPhysic.rebound(vx, vy, normal, rebound, friction)
    if not rebound then rebound=0 end
    if not friction then friction=0 end

    local velocity = (vx^2+vy^2)^0.5
    local direction = math.atan2(vy, vx)

--    print("DIRECTION= "..direction.."")
--    local angle = -(normal-direction)
    local angle = customMath.angleProxy(normal, direction)
    local normalVelocity = -velocity*math.cos(angle)*rebound
    local tangeantVelocity = velocity*math.sin(angle)*(1-friction)
--    direction = math.pi+normal-angle

    local normalx = normalVelocity*math.cos(normal)
    local normaly = normalVelocity*math.sin(normal)
    local tangeantx = tangeantVelocity*math.cos(normal+math.pi/2)
    local tangeanty = tangeantVelocity*math.sin(normal+math.pi/2)

    vx = normalx+tangeantx
    vy = normaly+tangeanty
    return vx, vy
end
