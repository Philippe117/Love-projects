--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 31/12/17
-- Time: 3:20 PM
-- To change this template use File | Settings | File Templates.
--

aiTools = {}

function aiTools.calculateFireSolution(origin, target, gravity, timeOfContact)
    local t = timeOfContact
    if not t then t = 0.1 end
    -- 30 is a mistery
    local vx=(t*(t*-30*gravity.x+target.velocity.x)-origin.position.x+target.position.x)/t
    local vy=(t*(t*-30*gravity.y+target.velocity.y)-origin.position.y+target.position.y)/t
    local vz=(t*(t*-30*gravity.z+target.velocity.z)-origin.position.z+target.position.z)/t

    return vx, vy, vz
end
