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
team1 = nil
team2 = nil

function plugin.load()
    map = mapManager.loadMap("Le desert de Mirou")
    team1 = team.create("les bo")
    team2 = team.create("persians")
    team1.foes = team2.members
    team2.foes = team1.members
end

function plugin.mousepressed(mouseX, mouseY, button)
    local wx, wy, wz = camera.screenToWorld(mouseX, mouseY, 0)
    if button == 1 then
        print("new good")
        team1:addMember(bigRock.create(wx, wy, wz, map, 30))
    elseif button == 2 then
        print("new bad")
        team2:addMember(bigRock.create(wx, wy, wz, map, -30))
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
