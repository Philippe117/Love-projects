--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 20/12/17
-- Time: 6:44 PM
-- To change this template use File | Settings | File Templates.
--

debugTocken = 0
print("starting program")

function love.load()
    print("loading...")
    love.filesystem.load("pluginManager.lua")()
    pluginManager.load()
end
function love.mousepressed( mouseX, mouseY, button )
    pluginManager.mousepressed( mouseX, mouseY, button )
end
function love.mousereleased( mouseX, mouseY, button )
    pluginManager.mousereleased( mouseX, mouseY, button )
end
function love.keypressed( key )
    pluginManager.keypressed( key )
end
function love.keyreleased( key )
    pluginManager.keyreleased( key )
end
function love.wheelmoved( x, y )
    pluginManager.wheelmoved(x, y)
end
function love.update(dt)
    collectgarbage()
    pluginManager.update(dt)
end
function love.draw()
    pluginManager.draw()

    love.graphics.print("debugTocken="..debugTocken.."", 0, 0)
end
