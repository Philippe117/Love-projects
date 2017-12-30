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
objectManager.loadList = {}
objectManager.updateList = {}
objectManager.slowpdatePointer = 1
objectManager.slowUpdateList = {}
setmetatable(objectManager.loadList, { __mode = 'vk' })
setmetatable(objectManager.updateList, { __mode = 'vk' })
setmetatable(objectManager.slowUpdateList, { __mode = 'vk' })
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
end

function plugin.update(dt)
    slowUpdate()
    for i, object in pairs(objectManager.updateList) do
        object:update(dt)
    end
end

function slowUpdate()
    objectManager.slowpdatePointer = objectManager.slowpdatePointer+1
    local object = objectManager.slowUpdateList[objectManager.slowUpdatePointer]
    if not object then
        objectManager.slowpdatePointer = 1
        object = objectManager.slowUpdateList[objectManager.slowUpdatePointer]
    end
    if object then
        local dt = time.time-object.lastUpdate
        object.lastUpdate = time.time
        object:slowUpdate(dt)
    end
end
