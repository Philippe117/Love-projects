--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 30/12/17
-- Time: 12:22 AM
-- To change this template use File | Settings | File Templates.
--

customMath = {}
function customMath.angleProxy(angle1, angle2)
    angle1 = angle2-angle1;
    angle1 = math.fmod(angle1+math.pi, 2*math.pi)-math.pi;
    return angle1;
end
