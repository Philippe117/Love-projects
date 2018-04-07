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
    local vx=(t*(t*-gravity.x/2+target.velocity.x)-origin.position.x+target.position.x)/t
    local vy=(t*(t*-gravity.y/2+target.velocity.y)-origin.position.y+target.position.y)/t
    local vz=(t*(t*-gravity.z/2+target.velocity.z)-origin.position.z+target.position.z)/t

    return vx, vy, vz
end
