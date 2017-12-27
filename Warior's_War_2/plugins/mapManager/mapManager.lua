--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 27/12/17
-- Time: 12:37 PM
-- To change this template use File | Settings | File Templates.
--

local refreshTime = 0.1
local path = "assets/maps/"
mapManager = {}
mapManager.maps = {}
setmetatable(mapManager.maps, { __mode = 'vk' })

function plugin.update()
    for i, map in pairs(mapManager.maps) do
        if  not map.status.UTD
        and map.status.time < time.time then
            map.image = love.graphics.newImage(map.imageData)
            map.status.UTD = true
        end
    end
end

function mapManager.loadMap(mapFileName)
    local map = {}
    map.imageData = love.image.newImageData(""..path..""..mapFileName.."/image.png")
    map.image = love.graphics.newImage(map.imageData)
    map.image:setFilter("nearest","nearest")
    map.draw = mapManager.draw
    map.removeMaterial = mapManager.draw
    map.position = {x=0, y=0, z=0 }
    map.status = {UTD=false, time=0 }
    table.insert(mapManager.maps, map)
    return map
end

function mapManager.removeMaterial(map, x, y, radius, delay)
    if not delay then delay = refreshTime end
    x = math.floor(x+0.5)
    y = math.floor(y+0.5)
    if map.status.UTD then
        map.status.UTD = false
        map.status.time = time.time+delay
    end
    local radius2 = radius^2
    for px=math.max(x-radius, 1), math.min(x+radius, map.imageData:getWidth()), 1 do
        for py=math.max(y-radius, 1), math.min(y+radius, map.imageData:getHeight()), 1 do
            if (x-px)^2+(y-py)^2 < radius2 then
                map.imageData:setPixel(px, py, 0, 0, 0, 0)
            end
        end
    end
end

function mapManager.draw(self, x, y, r, s)
    love.graphics.draw(self.image ,x , y, r, s)
end
