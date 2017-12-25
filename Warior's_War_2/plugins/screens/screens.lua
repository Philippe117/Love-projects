--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 22/12/17
-- Time: 7:59 PM
-- To change this template use File | Settings | File Templates.
--

screens = {}
local path = "plugins/screens/"

myLogo = {}
myLogo.position = {x=0, y=0, z=0}

function plugin.load()
    screens.logo = love.graphics.newImage(""..path.."logo.png")
    camera.addElement(myLogo)
end

function myLogo.draw(x,y,r,s)
    love.graphics.draw( screens.logo ,x,y)
end

function plugin.draw()
    camera.draw()
--    love.graphics.draw( screens.logo ,200,200)
    love.graphics.draw( screens.logo ,100,100)
end
