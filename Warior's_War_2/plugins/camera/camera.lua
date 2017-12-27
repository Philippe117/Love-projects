--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 22/12/17
-- Time: 8:46 PM
-- To change this template use File | Settings | File Templates.
--

camera = {}
camera.keyBinds = {up={"up", "w"}, down={"down", "s"}, left={"left", "a"}, right={"right", "d"}}
camera.maxVelocity = {x=5, y=-5, z=1, zoom=1}
camera.position = {x=0, y=0, z=1000, zoom=1}
camera.velocity = {x=0, y=0, z=0, zoom=0}
camera.acceleration = {x=0, y=0, z=0, zoom=0}

camera.elements = {}
camera.elements.__mode = 'v'
camera.mouseInScreen = {x, y}
camera.mouseInWorld = {x, y, z, s, r}

function plugin.update(dt)
    camera.mouseInScreen.x, camera.mouseInScreen.y = love.mouse.getPosition()
    camera.mouseInWorld.x, camera.mouseInWorld.y,  camera.mouseInWorld.z, camera.mouseInWorld.s = camera.screenToWorld(camera.mouseInScreen)

    camera.position.x = camera.position.x+camera.velocity.x
    camera.position.y = camera.position.y+camera.velocity.y
    camera.position.z = camera.position.z+camera.velocity.z
    camera.position.zoom = camera.position.zoom+camera.velocity.zoom
end

function plugin.keypressed(key)
    if keyBinds.checkKeybind(key, camera.keyBinds.up) then
        camera.velocity.y = camera.velocity.y+camera.maxVelocity.y
    end
    if keyBinds.checkKeybind(key, camera.keyBinds.down) then
        camera.velocity.y = camera.velocity.y-camera.maxVelocity.y
    end
    if keyBinds.checkKeybind(key, camera.keyBinds.left) then
        camera.velocity.x = camera.velocity.x-camera.maxVelocity.x
    end
    if keyBinds.checkKeybind(key, camera.keyBinds.right) then
        camera.velocity.x = camera.velocity.x+camera.maxVelocity.x
    end
end

function plugin.keyreleased(key)
    if keyBinds.checkKeybind(key, camera.keyBinds.up) then
        camera.velocity.y = camera.velocity.y-camera.maxVelocity.y
    end
    if keyBinds.checkKeybind(key, camera.keyBinds.down) then
        camera.velocity.y = camera.velocity.y+camera.maxVelocity.y
    end
    if keyBinds.checkKeybind(key, camera.keyBinds.left) then
        camera.velocity.x = camera.velocity.x+camera.maxVelocity.x
    end
    if keyBinds.checkKeybind(key, camera.keyBinds.right) then
        camera.velocity.x = camera.velocity.x-camera.maxVelocity.x
    end
end

function camera.addElement(element)
--    An element must contain the following attributes
--    - a draw function(x,y,r,s)
--    - a position attribute {x, y, z}
    table.insert(camera.elements, element)
end

function camera.worldToScreen(position)
    local s = math.abs(1000/(camera.position.z-position.z))
    local x = (position.x-camera.position.x)*s*camera.position.zoom+love.graphics.getWidth()/2
    local y = (position.y-camera.position.y)*s*camera.position.zoom+love.graphics.getHeight()/2
    local r = 0
    return x, y, r, s
end

function camera.screenToWorld(position, z)
    if not z then z = 0 end
    local s = math.abs(1000/(camera.position.z-z))
    local x = (position.x-love.graphics.getWidth()/2)/camera.position.zoom/s+camera.position.x
    local y = (position.y-love.graphics.getHeight()/2)/camera.position.zoom/s+camera.position.y
    local r = 0
    return x, y, z, r, 1/s
end

function camera.draw()
    for i, element in pairs(camera.elements) do
        if element.draw then
            local x, y, r, s = camera.worldToScreen(element.position)
--            print(x)
            element.draw(x, y, r, s)
        end
    end
    love.graphics.print("position=("..camera.position.x..", "..camera.position.y..")", 400, 00)
    love.graphics.print("velocity=("..camera.velocity.x..", "..camera.velocity.y..")", 400, 10)
end
