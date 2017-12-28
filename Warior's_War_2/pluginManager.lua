--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 21/12/17
-- Time: 10:48 PM
-- To change this template use File | Settings | File Templates.
--

pluginManager = {}
pluginManager.plugins = {}
pluginManager.preLoadList = {}
pluginManager.loadList = {}
pluginManager.updateList = {}
pluginManager.drawList = {}
pluginManager.mousepressedList = {}
pluginManager.mousereleasedList = {}
pluginManager.keypressedList = {}
pluginManager.keyreleasedList = {}
pluginManager.wheelmovedList = {}
plugin = {}

function pluginManager.load()
    print("getting plugins...")
    local pluginsNames = love.filesystem.getDirectoryItems("plugins")
    for i, pluginName in pairs(pluginsNames) do
        print("looking for "..pluginName.."")
        local filePath = "plugins/"..pluginName.."/"..pluginName..".lua"
        if love.filesystem.exists(filePath) then
            print("getting "..pluginName.."")
            local p = {name=pluginName }
            plugin = p
            love.filesystem.load(filePath)()
            table.insert(pluginManager.plugins, plugin)

            if plugin.preLoad then
                table.insert(pluginManager.preLoadList, plugin)
            end
            if plugin.load then
                table.insert(pluginManager.loadList, plugin)
            end
            if plugin.mousepressed then
                table.insert(pluginManager.mousepressedList, plugin)
            end
            if plugin.mousereleased then
                table.insert(pluginManager.mousereleasedList, plugin)
            end
            if plugin.keypressed then
                table.insert(pluginManager.keypressedList, plugin)
            end
            if plugin.keyreleased then
                table.insert(pluginManager.keyreleasedList, plugin)
            end
            if plugin.wheelmoved then
                table.insert(pluginManager.wheelmovedList, plugin)
            end
            if plugin.update then
                table.insert(pluginManager.updateList, plugin)
            end
            if plugin.draw then
                table.insert(pluginManager.drawList, plugin)
            end
        else
            print("////// "..filePath.." not found //////")
        end
    end
    print("preLoading plugins...")
    for i, plugin in pairs(pluginManager.preLoadList) do
        print("preLoading "..plugin.name.."")
        plugin.preLoad()
    end
    print("loading plugins...")
    for i, plugin in pairs(pluginManager.loadList) do
        print("loading "..plugin.name.."")
        plugin.load()
    end
end

function pluginManager.mousepressed( mouseX, mouseY, button )
    for i, plugin in pairs(pluginManager.mousepressedList) do
        plugin.mousepressed(mouseX, mouseY, button)
    end
end

function pluginManager.mousereleased( mouseX, mouseY, button )
    for i, plugin in pairs(pluginManager.mousereleasedList) do
        plugin.mousepressed(mouseX, mouseY, button)
    end
end

function pluginManager.keypressed( key )
    for i, plugin in pairs(pluginManager.keypressedList) do
        plugin.keypressed(key)
    end
end

function pluginManager.keyreleased( key )
    for i, plugin in pairs(pluginManager.keyreleasedList) do
        plugin.keyreleased(key)
    end
end

function pluginManager.wheelmoved( x, y )
    for i, plugin in pairs(pluginManager.wheelmovedList) do
        plugin.wheelmoved( x, y )
    end
end

function pluginManager.update(dt)
    for i, plugin in pairs(pluginManager.updateList) do
        plugin.update(dt)
    end
end

function pluginManager.draw()
    for i, plugin in pairs(pluginManager.drawList) do
        plugin.draw()
    end
end
