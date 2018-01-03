--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 22/12/17
-- Time: 8:46 PM
-- To change this template use File | Settings | File Templates.
--

camera = {}
camera.keyBinds = { up={"up", "w"},
                    down={"down", "s"},
                    left={"left", "a"},
                    right={"right", "d"},
                    ctrl={"rctrl", "lctrl"}}
camera.maxVelocity = {x=5, y=-5, z=5, zoom=0.9}
camera.position = {x=0, y=0, z=1000, zoom=1}
camera.velocity = {x=0, y=0, z=0, zoom=0}
camera.acceleration = {x=0, y=0, z=0, zoom=0}

camera.elements = setmetatable({}, { __mode = 'vk' })

function plugin.update(dt)
    camera.sortElements()
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

function plugin.wheelmoved( x, y )
    if keyBinds.isKeybindDown(camera.keyBinds.ctrl) then
        local mx, my = love.mouse.getPosition()
        local Z = camera.maxVelocity.zoom^(y)
        camera.position.zoom = camera.position.zoom/Z
        local cx = (mx-love.graphics.getWidth()/2)/camera.position.zoom
        local cy = (my-love.graphics.getHeight()/2)/camera.position.zoom
        cx = -cx*(1-camera.maxVelocity.zoom^(-y))
        cy = -cy*(1-camera.maxVelocity.zoom^(-y))
        camera.position.x = camera.position.x+cx
        camera.position.y = camera.position.y+cy
    else
        camera.position.x = camera.position.x-camera.maxVelocity.x*x/camera.position.zoom
        camera.position.y = camera.position.y+camera.maxVelocity.y*y/camera.position.zoom
    end
end

function camera.addElement(element)
------------------------------------------------------
--    An element must contain the following attributes
--    - a draw function(x,y,r,s)
--    - a position attribute {x, y, z}
    table.insert(camera.elements, element)
end

function camera.worldToScreen(x, y, z)
    if not z then z = 0 end
    local s = math.abs(1000/(camera.position.z-z))*camera.position.zoom
    local x = (x-camera.position.x)*s+love.graphics.getWidth()/2
    local y = (y-camera.position.y)*s+love.graphics.getHeight()/2
    local r = 0
    return x, y, r, s
end

function camera.screenToWorld(x, y, z)
    if not z then z = 0 end
    local s = math.abs(1000/(camera.position.z-z))*camera.position.zoom
    x = (x-love.graphics.getWidth()/2)/s+camera.position.x
    y = (y-love.graphics.getHeight()/2)/s+camera.position.y
    local r = 0
    return x, y, z, r, 1/s
end

function camera.draw()
    for i, element in pairs(camera.elements) do
--        print(element)
        if element.draw then
            local x, y, r, s = camera.worldToScreen(element.position.x, element.position.y, element.position.z)
            element:draw(x, y, r, s)
        else
            print("no draw")
        end
    end
    love.graphics.print("position=("..camera.position.x..", "..camera.position.y..", "..camera.position.zoom..")", 400, 00)
    love.graphics.print("velocity=("..camera.velocity.x..", "..camera.velocity.y..")", 400, 10)
end

function camera.sortElements()
    for i, element in pairs(camera.elements) do
        local n, ne = next(camera.elements, i)
        if camera.elements[n] and element.position.z > ne.position.z then
            camera.elements[i], camera.elements[n] = ne, element
        end
    end
end
