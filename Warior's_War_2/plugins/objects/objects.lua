--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 20/12/17
-- Time: 6:49 PM
-- To change this template use File | Settings | File Templates.
--

object = {}
objectManager = {}
objectManager.objects = {}
objectManager.checkStatusList = {}
objectManager.loadList = setmetatable({}, { __mode = 'vk' })
objectManager.updateList = setmetatable({}, { __mode = 'vk' })
objectManager.slowUpdatePointer = nil
objectManager.slowUpdateList = setmetatable({}, { __mode = 'vk' })
local path = "assets/objects/"

function plugin.load()
    print("getting objects...")
    local objectsNames = love.filesystem.getDirectoryItems(path)
    for i, objectName in pairs(objectsNames) do
        print("looking for "..objectName.."")
        local filePath = ""..path.."/"..objectName.."/"..objectName..".lua"
        if love.filesystem.exists(filePath) then
            print("getting "..objectName.."")
            local p = {name=objectName }
            object = p
            love.filesystem.load(filePath)()
            table.insert(objectManager.objects, object)

            if object.load then
                table.insert(objectManager.loadList, object)
            end
        else
            print("////// "..filePath.." not found //////")
        end
    end
    print("loading objects...")
    for i, object in pairs(objectManager.loadList) do
        print("loading "..object.name.."")
        object.load()
    end
end

function objectManager.subscribeObject(object)
    if object.update then table.insert(objectManager.updateList, object) end
    if object.slowUpdate then table.insert(objectManager.slowUpdateList, object) end
    object.lastUpdate = time.time
    table.insert(objectManager.checkStatusList, object)
end

function plugin.update(dt)
    objectManager.slowUpdate()
    objectManager.checkStatus()
    for i, object in pairs(objectManager.updateList) do
        if object.update then
            object:update(dt)
        else
            print("bad link")
        end
    end
end

function objectManager.slowUpdate()
    objectManager.slowUpdatePointer, object = next(objectManager.slowUpdateList, objectManager.slowUpdatePointer)
    if object then
        local dt = time.time-object.lastUpdate
        object.lastUpdate = time.time
        object:slowUpdate(dt)
    end
end

function objectManager.checkStatus()
    for i, object in pairs(objectManager.checkStatusList) do
        if object.status == "dead" then
            if object.destroy then object.destroy(object) end
            table.remove(objectManager.checkStatusList, i)
        end
    end
end

function plugin.draw()
    if objectManager.slowUpdatePointer then
        love.graphics.print(objectManager.slowUpdatePointer, 10, 100)
    end

end
