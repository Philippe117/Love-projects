--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 27/12/17
-- Time: 12:37 PM
-- To change this template use File | Settings | File Templates.
--

local refreshTime = 0.15
local colisionThreashold = 250
local path = "assets/maps/"
mapManager = {}
mapManager.maps = {}
setmetatable(mapManager.maps, { __mode = 'vk' })
mapManager.__index = mapManager

function mapManager.loadMap(mapFileName)
    local map = setmetatable({}, mapManager)
    map.imageData = love.image.newImageData(""..path..""..mapFileName.."/image.png")
    map.hardnessData = love.image.newImageData(""..path..""..mapFileName.."/hardnessData.png")
    map.image = love.graphics.newImage(map.imageData)
    map.image:setFilter("nearest","nearest")
    map.position = {x=0, y=0, z=20 }
    map.status = {UTD=false, time=0 }
    map.background = {}
    map.background.image = love.graphics.newImage(""..path..""..mapFileName.."/background.png")
    map.background.position = {x=-650, y=-900, z=-1000 }
    map.background.draw = mapManager.drawBackground
    table.insert(mapManager.maps, map)
    camera.addElement(map)
    camera.addElement(map.background)
    return map
end

function plugin.update()
    for i, map in pairs(mapManager.maps) do
        if  not map.status.UTD
        and map.status.time < time.time then
            map.image = love.graphics.newImage(map.imageData)
            map.status.UTD = true
        end
    end
end

function mapManager.damageMaterial(map, x, y, radius, damage, hardness, delay)
    local damageDealt = 0
    if not delay then delay = refreshTime end
    x = math.floor(x+0.5-map.position.x)
    y = math.floor(y+0.5-map.position.y)
    if map.status.UTD then
        map.status.UTD = false
        map.status.time = time.time+delay
    end
--    local radius2 = radius^2
    for px=math.max(x-radius, 0), math.min(x+radius, map.imageData:getWidth()-1), 1 do
        for py=math.max(y-radius, 0), math.min(y+radius, map.imageData:getHeight()-1), 1 do
            local dist = ((x-px)^2+(y-py)^2)^0.5
            if dist < radius then
                local d = damage*((radius-dist)/radius)^hardness
                local d2 = d/5
                local r, g, b, a = map.hardnessData:getPixel( math.floor(px), math.floor(py) )
                map.hardnessData:setPixel(px, py, math.max(0, r-d), 0, 0, 0)
                local nr, ng, nb, na = map.imageData:getPixel( math.floor(px), math.floor(py) )
                nr = math.max(0, nr-d2)
                ng = math.max(0, ng-d2)
                nb = math.max(0, nb-d2)
                if na ~= 0 and r-d <= 0 then
                    na = 0
                    damageDealt = damageDealt+d
                end
                map.imageData:setPixel(px, py, nr, ng, nb, na)
            end
        end
    end
    return damageDealt
end

function mapManager.draw(map, x, y, r, s)
    love.graphics.draw(map.image ,x , y, r, s)
end

function mapManager.drawBackground(self, x, y, r, s)
    love.graphics.draw(self.image ,x , y, r, s*6)
end

function mapManager.getHardness(map, x,y)
    x = math.max(0, math.min(map.image:getWidth()-1, x-map.position.x))
    y = math.max(0, math.min(map.image:getHeight()-1, y-map.position.y))
    local r, g, b, a = map.hardnessData:getPixel( math.floor(x), math.floor(y) )
    return r
end

function mapManager.getCollision(map, x,y)
    x = math.max(0, math.min(map.image:getWidth()-1, x-map.position.x))
    y = math.max(0, math.min(map.image:getHeight()-1, y-map.position.y))
    local r, g, b, a = map.imageData:getPixel( math.floor(x), math.floor(y) )
    return a > colisionThreashold, a
end

function mapManager.sphericalCollision(map, x, y, radius, precision)
--    Detect collision of a spherical shape with a map.
--    map = the map
--    x, y = the world coordinates of the center of the sphere
--    radius = radius of the sphere
--    precision = number of samples
--    return the angle of collision or -10 if no collision

    local contacts = {}
    local numberOfContacts = 0
    local step = 2*math.pi/precision
    for angle=0, 2*math.pi, step do
        local dx = math.cos(angle)*radius
        local dy = math.sin(angle)*radius
        local cx = x+dx
        local cy = y+dy
        if map:getCollision(cx, cy) then
            table.insert(contacts, {x=dx, y=dy})
            numberOfContacts = numberOfContacts+1
        end
    end

    if numberOfContacts == 0 then return -10 end
    local resultx = 0
    local resulty = 0
    for i, contact in pairs(contacts) do
        resultx = resultx+contact.x
        resulty = resulty+contact.y
    end
    local resultAngle = math.atan2(resulty, resultx)
    return resultAngle
end

function mapManager.raycastCollision(map, ox, oy, dx, dy, step)
    --    Detect collision of a line with a map.
    --    map = the map
    --    ox, oy = the world coordinates of the origin
    --    dx, dy = the world coordinates of the destination
    --    step = distance between samples
    --    return the position of contact on x, y and whether or not the destination is reached
    local distance = ((ox-dx)^2+(oy-dy)^2)^0.5
    if distance ~= 0 then
        local vx, vy = (dx-ox)/distance, (dy-oy)/distance
        for d=0, distance, step do
--            print("step")
            local cx, cy = ox+vx*d, oy+vy*d
            if map:getCollision(cx, cy) then
                return cx, cy, false
            end
        end
        return dx, dy, true
    end
    print("raycast error")
    return ox, oy, false
end
