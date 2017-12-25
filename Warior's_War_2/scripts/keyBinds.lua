--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 24/12/17
-- Time: 3:17 PM
-- To change this template use File | Settings | File Templates.
--
keyBinds = {}
function keyBinds.checkKeybind(key, keyBind)
    for i, bind in pairs(keyBind) do
        if bind == key then
            return true
        end
    end
    return false
end