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
    map = mapManager.loadMap("Le desert de Mirou")
end

function plugin.mousepressed(mouseX, mouseY, button)
    local wx, wy, wz = camera.screenToWorld(mouseX, mouseY, 0)
    map:damageMaterial(wx, wy, 200, 120, 1)
end

function plugin.draw()
    camera.draw()
    local mx, my = love.mouse.getPosition()
    local wx, wy = camera.screenToWorld(mx, my)
    local a = map:getHardness(wx, wy)
    love.graphics.print(""..a.."", mx, my-10)
end
