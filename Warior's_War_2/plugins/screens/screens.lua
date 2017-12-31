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
myRocks = {}
myOtherRocks = {}
function plugin.load()
    map = mapManager.loadMap("Le desert de Mirou")
end

function plugin.mousepressed(mouseX, mouseY, button)
    local wx, wy, wz = camera.screenToWorld(mouseX, mouseY, 0)
    if button == 1 then
        print("new good")
        table.insert(myRocks, rock.create(wx, wy, wz, map, myOtherRocks))
    elseif button == 2 then
        print("new bad")
        table.insert(myOtherRocks, rock.create(wx, wy, wz, map, myRocks))
    elseif button == 3 then
        print("new ugly")
        map:damageMaterial(wx, wy, 50, 320, 3)
    end
end

function plugin.draw()
    camera.draw()
    local mx, my = love.mouse.getPosition()
    local wx, wy = camera.screenToWorld(mx, my)
    local a = map:getHardness(wx, wy)
    love.graphics.print(""..a.."", mx, my-10)
end
