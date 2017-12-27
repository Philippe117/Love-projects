--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 22/12/17
-- Time: 7:59 PM
-- To change this template use File | Settings | File Templates.
--

screens = {}
local path = "plugins/screens/"
map = {}

function plugin.load()
    map = mapManager.loadMap("logo")
    camera.addElement(map)
end

function plugin.mousepressed(mouseX, mouseY, button)
    print("clic")
    local wx, wy, wz = camera.screenToWorld(mouseX, mouseY, 0)
    mapManager.removeMaterial(map, wx, wy, 15)
end

function plugin.draw()
    camera.draw()
--    love.graphics.draw( screens.logo ,200,200)
--    love.graphics.draw( screens.logo ,100,100)
end
